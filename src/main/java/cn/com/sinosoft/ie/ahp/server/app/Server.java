package cn.com.sinosoft.ie.ahp.server.app;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.worker.SimpleWorker;
import cn.com.sinosoft.ie.ahp.server.worker.WorkerConfig;

public class Server {
	private static final Logger logger = LoggerFactory.getLogger(Server.class);
	
	public ServerStatus start(ServerConfig serverConfig) throws Exception{
		logger.info("server startup...");
		serverConfig.init();
		
		Map<String, WorkerConfig> workerConfigs = serverConfig.getWorkersConfigMap();
		Iterator<Entry<String, WorkerConfig>> ite= workerConfigs.entrySet().iterator();
		while(ite.hasNext()){
			Entry<String,WorkerConfig> workerEntry = ite.next();
			String workerPrefix = workerEntry.getKey();
			if("base".equals(workerPrefix)){
				//模板配置，不生成实际的工作者
				continue;
			}
			WorkerConfig wc = workerEntry.getValue();
			for(int i=0; i<wc.getThread(); i++){
				SimpleWorker sw = new SimpleWorker(wc);
				sw.start();
			}
		}
		return null;
	}
}
