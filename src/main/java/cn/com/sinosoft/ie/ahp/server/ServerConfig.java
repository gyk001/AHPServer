package cn.com.sinosoft.ie.ahp.server;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.module.Module;
import cn.com.sinosoft.ie.ahp.server.module.ModuleConfig;
import cn.com.sinosoft.ie.ahp.server.monitor.MonitorConfig;

/**
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-28
 *
 */
public class ServerConfig {
	private static final Logger logger = LoggerFactory
			.getLogger(ServerConfig.class);
	// 配置键-启用的组件
	public static final String SC_MODULE_ENABLE="module.conf.enable";
	// 配置键-组件配置文件目录
	public static final String SC_MODULE_CONFIG_DIR="module.conf.dir";
	// 配置键-组件配置前缀
	public static final String SC_PREFIEX_MODULE="module.conf";
	// 配置键-监控配置前缀
	public static final String SC_PREFIEX_MONITOR="monitor";
	
	// 初始化标志
	private boolean init=false;
    // 监控配置
    private MonitorConfig monitorConfig;
    // 组件配置文件夹
    private String moduleConfDir;
    // 需要加载的组件名列表
    private List<String> moduleNames = new ArrayList<String>();
	// 已经加载组件配置
    private Map<String,ModuleConfig> moduleConfigs = new HashMap<String,ModuleConfig>();
    // 已经加载的组件对象
    private Map<String, Module> modules = new HashMap<String,Module>();
	
	public void init() throws ConfigException{
		if(this.init){
			return;
		}
		//加载配置文件
		Configuration config = null;
		try {
			config = new PropertiesConfiguration("cfg/server.properties");
		} catch (ConfigurationException e) {
			ConfigException ce = new ConfigException("加载主配置文件失败", e);
			throw ce;
		}
		//
		this.moduleConfDir = config.getString(SC_MODULE_CONFIG_DIR, "cfg/module").trim();
		if(! this.moduleConfDir.endsWith(File.separator)){
			this.moduleConfDir= this.moduleConfDir+File.separator;
		}
		// 监控配置
		this.monitorConfig = new MonitorConfig();
		Configuration monitorConf = config.subset(SC_PREFIEX_MONITOR);
		Iterator<String> monitorKeys = monitorConf.getKeys();
		while(monitorKeys.hasNext()){
			String monitorKey = monitorKeys.next();
			if(monitorKey!=null && ! monitorKey.isEmpty()){
				try {
					BeanUtils.copyProperty(this.monitorConfig, monitorKey, monitorConf.getProperty(monitorKey));
				} catch (Exception e) {
					ConfigException ce = new ConfigException("读取monitor配置异常", e);
					throw ce;
				}
			}
		}	
		
		//取得配置文件中启用的module,没有返回空数组，不会为null
		String[] enableModuleNames = config.getStringArray(SC_MODULE_ENABLE);
		//剔除空元素，多写逗号会产生空元素
		for(String moduleName: enableModuleNames){
			if(moduleName==null || moduleName.isEmpty()){
				logger.warn("配置项[{}]中[{}]之后有空元素",SC_MODULE_ENABLE,moduleNames.get(moduleNames.size()-1));
				continue;
			}
			moduleNames.add(moduleName);
		}
		logger.info("enabled module:{}",moduleNames);
		Configuration moduleConf =  config.subset(SC_PREFIEX_MODULE);
		
		
		
		/*
		
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
		
		*/
	}
	
/*
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
*/

	
	public MonitorConfig getMonitorConfig() {
		return monitorConfig;
	}

	public boolean isInit() {
		return init;
	}

	public String getModuleConfDir() {
		return moduleConfDir;
	}

	public List<String> getModuleNames() {
		return moduleNames;
	}

	public Map<String, ModuleConfig> getModuleConfigs() {
		return moduleConfigs;
	}

	public Map<String, Module> getModules() {
		return modules;
	}
	
}
