package cn.com.sinosoft.ie.ahp.server;

import java.util.List;
import java.util.concurrent.CountDownLatch;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.module.Module;
import cn.com.sinosoft.ie.ahp.server.module.ModuleConfig;
import cn.com.sinosoft.ie.ahp.server.module.ModuleExecption;
import cn.com.sinosoft.ie.ahp.server.module.ModuleUtil;
import cn.com.sinosoft.ie.ahp.server.monitor.MonitorThread;

/**
 * @author GuoYukun (<a href="mailto:gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-28
 * 
 */
public class ServerMain {
	private static final Logger logger = LoggerFactory
			.getLogger(ServerMain.class);


	public static void main(String[] args) throws ConfigException, InterruptedException {
		final CountDownLatch monitorDoneSignal = new CountDownLatch(1);
		// 主配置对象
		final ServerConfig serverConfig = new ServerConfig();
		// 初始化配置,如有异常直接抛出，中断程序运行
		serverConfig.init();
		// ==== 创建并启动监控进程 ====
		MonitorThread monitor = new MonitorThread(
				serverConfig.getMonitorConfig());
		monitor.setMonitorDoneSignal(monitorDoneSignal);
		Thread monitorThread = new Thread(monitor,"M");
		logger.debug("Monitor thread [{}] created!",monitorThread.getName());
		monitorThread.start();
		logger.info("等待启动监控进程启动完毕。。。");
		monitorDoneSignal.await();
		logger.info("监控进程启动完毕");
		
		// ========= 循环配置并启动模块 =========
		List<String> enableModuleNames = serverConfig.getModuleNames();
		for (String moduleName : enableModuleNames) {
			try {
				//读取配置文件
				ModuleConfig moduleConfig = ModuleUtil.makeModuleConfig(serverConfig, moduleName); 
				Module module = ModuleUtil.makeModule(serverConfig, moduleName);
				
			} catch (ModuleExecption me) {
				// 出错不抛出异常，仅记录错误信息,
				// 一个模块出错并不一定影响整个程序运行
				logger.error("启用模块["+moduleName+"]失败！", me);
			}
		}
		logger.info("server startup!");
	}

}
