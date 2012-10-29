package cn.com.sinosoft.ie.ahp.server.worker;

import java.util.Map;

public interface IWorker {
	public void wkInit(WorkerConfig config);
	public void wkStart();
	public void wkStop();
	public Map<String,Object> getWkState();
}