package cn.com.sinosoft.ie.ahp.server.app;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.monitor.MonitorThread;

/**
 * @author GuoYukun (<a href="mailto:gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-28
 * 
 */
public class AHPServer {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(AHPServer.class);
	private static ServerConfig serverConfig = new ServerConfig();
	private static Server server = new Server();
	
	public static void main(String[] args) throws Exception {
		//创建监控进程
		Thread monitor = new Thread(new MonitorThread(serverConfig.getMonitorConfig()),"MT");
	//	monitor.setDaemon(true);
		logger.debug("Monitor thread ["+monitor.getName()+"] created!");
		monitor.start();
		
		
	//	server.start(serverConfig);
		
	}

}
