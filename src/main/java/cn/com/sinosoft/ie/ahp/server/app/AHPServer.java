package cn.com.sinosoft.ie.ahp.server.app;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sinosoft.ie.ahp.server.db.DBManager;
import com.sinosoft.ie.ahp.server.monitor.MonitorThread;

/**
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-28
 *
 */
public class AHPServer {
	private static final Logger logger = LoggerFactory.getLogger(AHPServer.class);
	private static ServerConfig config;
	
	public static void main(String[] args) throws Exception{
		
	//	ClassConfig.initClassConfig();
		DBManager.initDataSource(null);
		DBManager.getConnection();
		//HPServerHandler prh=new HPServerHandler();
		//prh.run();
		logger.info("AHPServer starting...");
		//初始化状态
		config = new ServerConfig();
		config.init();
		//启动时间
		ServerStatus.startupTime = new Date();
		//创建工作进程组
		//AHPStatus.workerThreadGroup = new ThreadGroup("workers");
		//工作进程数
		int workerCount = config.getWorkerThreadCount();
		//启动所有工作进程
		List<Thread> workers = new ArrayList<Thread>(workerCount);
		//创建工作进程
		for(int i=0; i<workerCount; i++){
			//MQHelper mqHelper = new MQHelper(config);
			//创建工作线程并添加至线程组
			WorkerThread worker = new WorkerThread("WK_"+i, config, null/* mqHelper*/);
			workers.add( worker);
			logger.debug("Worker thread [{}] created!",worker.getName());
		}
		
		ServerStatus.workerThreads = workers;
		//创建监控进程
		Thread monitor = new Thread(new MonitorThread(ServerConfig.getMonitorConfig()),"MT");
		//monitor.setDaemon(true);
		logger.debug("Monitor thread ["+monitor.getName()+"] created!");
		/*
		for (Thread worker :workers) {
			if(worker != null){
				worker.start();
			}else{
				logger.warn("a worker thread is null!");
			}
		}
		*/
		logger.info("all worker thread started!");
		//启动监控进程
		monitor.start();
		logger.info("Monitor thread started!");
		
		//退出回调
		Runtime.getRuntime().addShutdownHook(new Thread(){
			@Override
			public void run() {
				logger.info("ShutdownHook enter...");
				//TODO:温和关闭所有工作线程
				stopAllWorkers();
				ServerStatus.printStatus(System.out);
				ServerStatus.shutdownTime = new Date();
				logger.info("ShutdownHook done!");
				
			}
		});
		logger.info("Main thread exit...");
	}

	public static void stopAllWorkers(){
		//所有工作进程
		List<Thread> workers =ServerStatus.workerThreads;
		if(workers != null){
			for (Thread worker: workers) {
				//TODO:检查进程状态
				
				//设置进程终止标志
				if(worker instanceof WorkerThread){
					((WorkerThread) worker).setStopableFlag();
				}else{
					logger.warn(worker.getName()+" is not stopable!");
				}
			}
			boolean allWorkerStop = false;
			//int activeThreadCount = AHPStatus.workerThreadGroup.activeCount();
			while( ! allWorkerStop ){
				for (Thread worker: workers) {
					if(worker != null && worker.isAlive() && worker.isInterrupted()){
						try {
							Thread.sleep(1000);
							if(logger.isDebugEnabled()){
								logger.debug(worker.getName());
							}
						} catch (InterruptedException ignore) {
							logger.warn(ignore.getLocalizedMessage());
						}
						logger.info("waiting for "+worker.getName()+" stop...");
						continue;
					}
				}
				allWorkerStop = true;
				logger.info("all worker threads stoped...");
			}
		}
		DBManager.closeDataSource();
	}
}
