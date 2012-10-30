package cn.com.sinosoft.ie.ahp.server.module.mq;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.configuration.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.module.ModuleConfig;
import cn.com.sinosoft.ie.ahp.server.module.ModuleExecption;
import cn.com.sinosoft.ie.ahp.server.mq.SingleQueueConfig;
import cn.com.sinosoft.ie.ahp.server.worker.WorkerConfig;

public class ModuleMQConfig implements ModuleConfig {
	private static final Logger logger = LoggerFactory.getLogger(ModuleMQConfig.class);
	// MQ配置
    private Map<String,SingleQueueConfig> mqs = new HashMap<String, SingleQueueConfig>();
    // 工作线程配置
    private Map<String,WorkerConfig> workersConfigMap = new HashMap<String,WorkerConfig>();
	
	private String configClazz;
	private String moduleClazz;
    
	public Map<String, SingleQueueConfig> getMqs() {
		return mqs;
	}


	public Map<String, WorkerConfig> getWorkersConfigMap() {
		return workersConfigMap;
	}


	@Override
	public void init(Configuration config) throws ModuleExecption {
		this.configClazz = config.getString(MC_CLAZZ_CONFIG).trim();
		this.moduleClazz = config.getString(MC_CLAZZ_MODULE).trim();
		
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

	}


	private SingleQueueConfig makeMQConfig(String mqName, Configuration config, SingleQueueConfig defaultMQConf) throws ModuleExecption{
		SingleQueueConfig mqConfig = null;
		if(defaultMQConf==null){
			mqConfig = new SingleQueueConfig();
		}else{
			try {
				mqConfig =(SingleQueueConfig)BeanUtils.cloneBean(defaultMQConf);
			} catch (Exception e) {
				throw new ModuleExecption(e);
			}
		}
		Iterator<String> mqKeys = config.getKeys();
		while(mqKeys.hasNext()){
			String mqKey = mqKeys.next();
			if(mqKey!=null && ! mqKey.isEmpty()){
				try {
					BeanUtils.copyProperty(mqConfig, mqKey, config.getProperty(mqKey));
				} catch (Exception e) {
					throw new ModuleExecption(e);
				}
			}
		}	
		mqConfig.setName(mqName);
		return mqConfig;
	}
	private WorkerConfig makeWorkerConfig(String workerName,Configuration config, WorkerConfig defaultWorkerConf) throws ModuleExecption {
		WorkerConfig workerConfig= null;
		if(defaultWorkerConf==null){
			workerConfig = new WorkerConfig();
		}else{
			try {
				workerConfig = (WorkerConfig)BeanUtils.cloneBean(defaultWorkerConf);
			} catch (Exception e) {
				throw new ModuleExecption(e);
			}
		}
		
		Iterator<String> wcKeys = config.getKeys();
		while(wcKeys.hasNext()){
			String wcKey = wcKeys.next();
			if(wcKeys!=null && ! wcKey.isEmpty()){
				if(wcKey.equals("mqBiz")){
					String mqName = config.getString(wcKey);
					if( mqName==null || mqName.isEmpty()){
						throw new ModuleExecption(workerName+"'s "+wcKey +" is not set!");
					}
					workerConfig.setMqBizConfig(this.mqs.get(mqName));
				}else if(wcKey.equals("mqResult")){
					String mqName = config.getString(wcKey);
					if( mqName==null || mqName.isEmpty()){
						throw new ModuleExecption(workerName+"'s "+wcKey +" is not set!");
					}
					workerConfig.setMqResultConfig(this.mqs.get(mqName));
				}else{
					try {
						BeanUtils.copyProperty(workerConfig, wcKey, config.getProperty(wcKey));
					} catch (Exception e) {
						throw new ModuleExecption(workerName+"'s "+wcKey+" set error!", e);
					}
				}
			}
		}	
		workerConfig.setNamePrefix(workerName);
		//workerConfig.setAhpConfig(this);
		return workerConfig;
	}


	@Override
	public String getConfigClazz() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public String getModuleClazz() {
		// TODO Auto-generated method stub
		return null;
	}
}
