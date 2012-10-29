package cn.com.sinosoft.ie.ahp.server.app;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.monitor.MonitorConfig;
import cn.com.sinosoft.ie.ahp.server.mq.SingleQueueConfig;
import cn.com.sinosoft.ie.ahp.server.worker.WorkerConfig;

import com.sinosoft.ie.ahp.msg.MsgType;

/**
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-28
 *
 */
public class ServerConfig {
	private static final Logger logger = LoggerFactory
			.getLogger(ServerConfig.class);
	private boolean init=false;
	// MQ配置
    private Map<String,SingleQueueConfig> mqs = new HashMap<String, SingleQueueConfig>();
    // 工作线程配置
    private Map<String,WorkerConfig> workersConfigMap = new HashMap<String,WorkerConfig>();
    // 监控配置
    private MonitorConfig monitorConfig;
    
    
	public Map<String, SingleQueueConfig> getMqs() {
		return mqs;
	}


	public void setMqs(Map<String, SingleQueueConfig> mqs) {
		this.mqs = mqs;
	}

	
	public Map<String, WorkerConfig> getWorkersConfigMap() {
		return workersConfigMap;
	}

	public void setWorkersConfigMap(Map<String, WorkerConfig> workersConfigMap) {
		this.workersConfigMap = workersConfigMap;
	}

	
	
	public MonitorConfig getMonitorConfig() {
		return monitorConfig;
	}

	public void setMonitorConfig(MonitorConfig monitorConfig) {
		this.monitorConfig = monitorConfig;
	}

	public boolean isInit() {
		return init;
	}


	public void setInit(boolean init) {
		this.init = init;
	}


	private SingleQueueConfig makeMQConfig(String mqName, Configuration config, SingleQueueConfig defaultMQConf){
		SingleQueueConfig mqConfig = null;
		if(defaultMQConf==null){
			mqConfig = new SingleQueueConfig();
		}else{
			try {
				mqConfig =(SingleQueueConfig)BeanUtils.cloneBean(defaultMQConf);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Iterator<String> mqKeys = config.getKeys();
		while(mqKeys.hasNext()){
			String mqKey = mqKeys.next();
			if(mqKey!=null && ! mqKey.isEmpty()){
				try {
					BeanUtils.copyProperty(mqConfig, mqKey, config.getProperty(mqKey));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}	
		mqConfig.setName(mqName);
		return mqConfig;
	}
	private WorkerConfig makeWorkerConfig(String workerName,Configuration config, WorkerConfig defaultWorkerConf) throws ConfigException{
		WorkerConfig workerConfig= null;
		if(defaultWorkerConf==null){
			workerConfig = new WorkerConfig();
		}else{
			try {
				workerConfig = (WorkerConfig)BeanUtils.cloneBean(defaultWorkerConf);
			} catch (Exception e) {
				throw new ConfigException("clone defaultWorkerConf error!", e);
			}
		}
		
		Iterator<String> wcKeys = config.getKeys();
		while(wcKeys.hasNext()){
			String wcKey = wcKeys.next();
			if(wcKeys!=null && ! wcKey.isEmpty()){
				if(wcKey.equals("mqBiz")){
					String mqName = config.getString(wcKey);
					if( mqName==null || mqName.isEmpty()){
						throw new ConfigException(workerName+"'s "+wcKey +" is not set!");
					}
					workerConfig.setMqBizConfig(this.mqs.get(mqName));
				}else if(wcKey.equals("mqResult")){
					String mqName = config.getString(wcKey);
					if( mqName==null || mqName.isEmpty()){
						throw new ConfigException(workerName+"'s "+wcKey +" is not set!");
					}
					workerConfig.setMqResultConfig(this.mqs.get(mqName));
				}else{
					try {
						BeanUtils.copyProperty(workerConfig, wcKey, config.getProperty(wcKey));
					} catch (Exception e) {
						throw new ConfigException(workerName+"'s "+wcKey+" set error!", e);
					}
				}
			}
		}	
		workerConfig.setNamePrefix(workerName);
		//workerConfig.setAhpConfig(this);
		return workerConfig;
	}
	public void init() throws Exception{
		if(this.init){
			return;
		}
		//加载配置文件
		Configuration config = null;
		try {
			config = new PropertiesConfiguration("cfg/server.properties");
		} catch (ConfigurationException e) {
			throw e;
		}
		//mq配置
		Configuration mqBaseConf = config.subset("mqbase");
		SingleQueueConfig mqBaseConfig = makeMQConfig("base", mqBaseConf, null);
		logger.debug("mq base conf: {}",mqBaseConfig);
		this.mqs.put("base", mqBaseConfig);
		String[] mqNames = config.getStringArray("mq.enable");
		for (int i = 0; i < mqNames.length; i++) {
			Configuration mqConf = config.subset("mq."+mqNames[i]);
			SingleQueueConfig mqConfig = makeMQConfig(mqNames[i], mqConf, mqBaseConfig);
			logger.debug("mq {} conf: {}", mqNames[i], mqConfig);
			this.mqs.put(mqNames[i], mqConfig);
		}
		//worker配置
		Configuration workerBaseConf = config.subset("workerbase");
		WorkerConfig workerBaseConfig = makeWorkerConfig("base", workerBaseConf, null);
		logger.debug("worker base conf:{}",workerBaseConfig);
		this.workersConfigMap.put("base", workerBaseConfig);
		String[] workerNames = config.getStringArray("worker.enable");
		for (int i = 0; i < workerNames.length; i++) {
			Configuration workerConf = config.subset("worker."+workerNames[i]);
			WorkerConfig workerConfig = makeWorkerConfig(workerNames[i], workerConf, workerBaseConfig);
			logger.debug("worker {} conf:{}", workerNames[i], workerConfig);
			this.workersConfigMap.put(workerNames[i], workerConfig);
			
		}
		// 监控配置
		this.monitorConfig = new MonitorConfig();
		Configuration monitorConf = config.subset("monitor");
		Iterator<String> monitorKeys = monitorConf.getKeys();
		while(monitorKeys.hasNext()){
			String monitorKey = monitorKeys.next();
			if(monitorKey!=null && ! monitorKey.isEmpty()){
				try {
					BeanUtils.copyProperty(this.monitorConfig, monitorKey, monitorConf.getProperty(monitorKey));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}	
		
	}


}
