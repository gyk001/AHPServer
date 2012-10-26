package cn.com.sinosoft.ie.ahp.server.worker;

import java.util.Map;

/**
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-31
 *
 */
public interface IWorker {
	public String getWorkerName();
	public WorkerConfig getWorkerConfig();
	public void init( WorkerConfig workercfg ) throws WorkerException;
	public void work() throws WorkerException;
	public void shouldStop() throws WorkerException;
	@SuppressWarnings("rawtypes")
	public Map getWorkerState();
}
