package cn.com.sinosoft.ie.ahp.server;

import java.util.Date;
import java.util.List;

import cn.com.sinosoft.ie.ahp.server.worker.IWorker;


public final class ServerStatus {
	private ServerStatus(){};

	//启动时间
	private final Date startupTime = new Date();
	//工作进程组
	//public static ThreadGroup workerThreadGroup;
	private List<IWorker> workers;
	
	
	public List<IWorker> getWorkers() {
		return workers;
	}
	
	public void setWorkers(List<IWorker> workers) {
		this.workers = workers;
	}
	
	public Date getStartupTime() {
		return startupTime;
	}
	
	
	
	
	
	//接收到的总消息数
	//已处理的消息总数
    //正在处理的消息总数
	//处理成功的消息总数
	//处理失败的消息总数
    //

}
