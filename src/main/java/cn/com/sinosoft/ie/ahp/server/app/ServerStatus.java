package cn.com.sinosoft.ie.ahp.server.app;

import java.io.PrintStream;
import java.util.Date;
import java.util.List;


public final class ServerStatus {
	private ServerStatus(){};

	//启动时间
	public static Date startupTime;
	//关闭时间
	public static Date shutdownTime;
	//工作进程组
	//public static ThreadGroup workerThreadGroup;
	public static List<Thread> workerThreads;
	
	
	//接收到的总消息数
	//已处理的消息总数
    //正在处理的消息总数
	//处理成功的消息总数
	//处理失败的消息总数
    //

	public static void printStatus(PrintStream ps){
		ps.append(" ============== AHPStatus ==================\n");
		ps.append(" Start from ").append( startupTime.toString());
		ps.append("  ,Now time is ").append(new Date().toString());
		ps.append("\nThread\tTotal\tSuccess\tError\tProssess\tSend\n");
		for (Thread t: workerThreads) {
			WorkerThread wt = (WorkerThread) t;
			ps.append(wt.getMsgState(false)).append("\n");
		}
	}
}
