package cn.com.sinosoft.ie.ahp.server.app;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sinosoft.ie.ahp.server.monitor.MonitorConfig;
import com.sinosoft.ie.ahp.server.mq.SingleQueueConfig;
import com.sinosoft.ie.ahp.server.processer.ICdaProcesser;

/**
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-28
 *
 */
public class ServerConfig {
	private static final Logger logger = LoggerFactory
			.getLogger(ServerConfig.class);
	
    //private Map<String,SingleQueueConfig> mqs = new HashMap<String, SingleQueueConfig>();
    // 工作线程配置
   // private Map<String,WorkerConfig> workersConfigMap = new HashMap<String,WorkerConfig>();
    // 监控配置
    private static MonitorConfig monitorConfig;

	
	
	
	public static MonitorConfig getMonitorConfig() {
		return monitorConfig;
	}


	//工作线程数
	private int workerThreadCount ;
	private Integer mqMaxMsgCount;
	private String mqIp ;
	private int mqPort;
	private String mqUsername;
	private String mqPassword;
	private String mqBizQueue;
	private String mqBizExchange;
	private String mqBizRoutingKey;
	private String mqResultQueue;
	private String mqResultExchange;
	private String mqResultRoutingKey;

    
	
	
	//发送队列
	public final static String SENDQUEUE = "APHSEND_Q";
	//接收队列
	public final static String RECEIVEQUEUE = "APHRECEIVE_Q";
	//处理类的类名和msgType的对应关系
	private Properties processerProps;
	//处理类实例和msgType的对应关系
	private Map<String,ICdaProcesser> cdaProcessers ;
	
	public ICdaProcesser getCdaProcesser(String msgType){
		//处理类类名
		String processerClaz = processerProps.getProperty(msgType);
		ICdaProcesser processer = cdaProcessers.get(processerClaz);
		if(processer == null){
			synchronized (this) {
				try {
					processer = (ICdaProcesser) Class.forName(processerClaz).newInstance();
					cdaProcessers.put(processerClaz, processer);
				} catch (Exception ignore) {
					logger.warn("get CDAProcesser exception !",ignore);
				}
			}
		}
		return processer;
	}
	
	public void init() throws IOException{
		//TODO:根据配置文件初始化
		this.workerThreadCount=2;
		// 加载连接配置
		Properties p = new Properties();
		p.load(ClassLoader
				.getSystemResourceAsStream("config.properties"));
		this.mqIp = p.getProperty("mq.ip");
		this.mqPort = Integer.valueOf( p.getProperty("mq.port","63333") );
		
		this.mqUsername = p.getProperty("mq.username");
		this.mqPassword = p.getProperty("mq.password");
		this.workerThreadCount = Integer.valueOf( p.getProperty("worker.thread","1"));
		this.mqMaxMsgCount = Integer.valueOf( p.getProperty("mq.maxMsgCount","1000"));
		this.mqBizExchange = p.getProperty("mq.bizExchange");
		this.mqBizQueue = p.getProperty("mq.bizQueue");
		this.mqBizRoutingKey = p.getProperty("mq.bizRoutingKey");
		this.mqResultExchange = p.getProperty("mq.resultExchange");
		this.mqResultQueue = p.getProperty("mq.resultQueue");
		this.mqResultRoutingKey = p.getProperty("mq.resultRoutingKey");
		
		// 监控配置
		this.monitorConfig = new MonitorConfig();
		Configuration config = null;
		try {
			config = new PropertiesConfiguration("config.properties");
		} catch (ConfigurationException e) {
			throw new IOException(e);
		}
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
		
		this.processerProps = new Properties();
		this.processerProps.load( ClassLoader.getSystemResourceAsStream("processer.properties"));
		this.cdaProcessers = new HashMap<String,ICdaProcesser>();
	}

	public int getWorkerThreadCount(){
		return this.workerThreadCount;
	}

	public String getMqIp() {
		return mqIp;
	}

	public int getMqPort() {
		return mqPort;
	}

	public String getMqUsername() {
		return mqUsername;
	}

	public String getMqPassword() {
		return mqPassword;
	}

	public static String getSendqueue() {
		return SENDQUEUE;
	}

	public static String getReceivequeue() {
		return RECEIVEQUEUE;
	}

	public Map<String, ICdaProcesser> getCdaProcessers() {
		return cdaProcessers;
	}

	public Integer getMqMaxMsgCount() {
		return mqMaxMsgCount;
	}

	public String getMqBizQueue() {
		return mqBizQueue;
	}

	public String getMqBizExchange() {
		return mqBizExchange;
	}

	public String getMqBizRoutingKey() {
		return mqBizRoutingKey;
	}

	public String getMqResultQueue() {
		return mqResultQueue;
	}

	public String getMqResultExchange() {
		return mqResultExchange;
	}

	public String getMqResultRoutingKey() {
		return mqResultRoutingKey;
	}

}
