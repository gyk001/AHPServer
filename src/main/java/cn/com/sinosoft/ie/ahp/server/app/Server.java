package cn.com.sinosoft.ie.ahp.server.app;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.worker.IWorker;
import cn.com.sinosoft.ie.ahp.server.worker.WorkerConfig;

public class Server {
	private static final Logger logger = LoggerFactory.getLogger(Server.class);
	private static final String BASE_CFG_NAME = "base";
	
	public ServerStatus start(ServerConfig serverConfig) throws Exception{
		logger.info("server startup...");
		if( ! serverConfig.isInit()){
			serverConfig.init();
		}
		Map<String, WorkerConfig> workerConfigs = serverConfig.getWorkersConfigMap();
		Iterator<Entry<String, WorkerConfig>> ite= workerConfigs.entrySet().iterator();
		while(ite.hasNext()){
			Entry<String,WorkerConfig> workerEntry = ite.next();
			String workerPrefix = workerEntry.getKey();
			if(BASE_CFG_NAME.equals(workerPrefix)){
				//模板配置，不生成实际的工作者
				continue;
			}
			WorkerConfig wc = workerEntry.getValue();
			String clazz = wc.getClazz();
			if(clazz==null || clazz.isEmpty()){
				throw new Exception("no clazz def for config: "+wc.getNamePrefix());
			}
			for(int i=0; i<wc.getThread(); i++){
				Object obj = Class.forName(clazz).newInstance();
				if(! (obj instanceof IWorker)){
					throw new Exception(wc.getClazz()+" not a IWorker instance!");
				}
				IWorker worker = (IWorker)obj;
				worker.wkInit(wc);
				worker.wkStart();
			}
		}
		return null;
	}
}
