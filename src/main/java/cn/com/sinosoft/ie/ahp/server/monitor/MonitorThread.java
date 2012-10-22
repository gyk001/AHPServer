/**
 *
 */
package cn.com.sinosoft.ie.ahp.server.monitor;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.server.handler.ResourceHandler;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * @author GuoYukun(<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @date 2012/05/28
 *
 */

public class MonitorThread implements Runnable {
	private static final Logger logger = LoggerFactory
			.getLogger(MonitorThread.class);
	private Server server = null;
	private MonitorConfig config = null;
	public MonitorThread(MonitorConfig config){
		this.config = config;
	}
	

	@Override
	public void run() {
		logger.info("monitor thread start...");
	
        ServletContextHandler servletContext = new ServletContextHandler(ServletContextHandler.SESSIONS);
       
        // 获取工作者状态接口
        servletContext.addServlet(new ServletHolder(new WorkerStateServlet()),"/*");
 
        ContextHandlerCollection contexts = new ContextHandlerCollection();
        ResourceHandler rh = new ResourceHandler();
        rh.setDirectoriesListed(true);
        rh.setWelcomeFiles(new String[]{"index.html"});
        contexts.addContext("/"+config.getContextPath(), config.getWebRoot()).setHandler(rh);
        contexts.addContext("/"+config.getContextPath()+"/ac",".").setHandler(servletContext);
		server = new Server(config.getPort());
        server.setHandler(contexts);
        try {
			server.start();
			server.join();
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*
		BufferedReader   br=new 
		BufferedReader(new   InputStreamReader(System.in)); 
		System.out.println( "Enter 'q' to quit,'s' to print state!"); 
		String cmd = null;
		do{ 
		    try {
		    	cmd = br.readLine();
				//输出处理状态
				if( cmd.equalsIgnoreCase("s")){
					ClientStatus.printStatus(System.out);
				}else if(cmd.startsWith("x:")){
					String tName = cmd.substring(2);
					AHPClient.stopWorker(tName);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 
		}while(cmd.equalsIgnoreCase("q"));
		
		
		AHPClient.stopAllWorkers();
		ClientStatus.printStatus(System.out);
		*/
        logger.info("monitor thread exit..");
	}

}


