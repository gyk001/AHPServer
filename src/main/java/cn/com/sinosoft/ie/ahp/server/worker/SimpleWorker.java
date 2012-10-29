package cn.com.sinosoft.ie.ahp.server.worker;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sinosoft.ie.ahp.msg.ClientProperties;

import cn.com.sinosoft.ie.ahp.common.StopableRepeatThread;
import cn.com.sinosoft.ie.ahp.server.mq.MQException;
import cn.com.sinosoft.ie.ahp.server.mq.SimpleMQHelper;

public class SimpleWorker extends StopableRepeatThread implements IWorker {
	private static final Logger logger = LoggerFactory
			.getLogger(SimpleWorker.class);
	// jvm生成的线程名前缀,设置worker名称时会替换为worker的前缀
	private static final String SYS_DEFAULT_THREAD_PREFIX = "Thread";
	
	private WorkerConfig workConfig;
	// 业务接收
	private SimpleMQHelper bizMqHelper;
	// 结果发送
	private SimpleMQHelper resultMqHelper;
	
	private WorkerState workerState = new WorkerState();
	
	
	public SimpleWorker() {
	}

	@Override
	protected void beforRepeat() throws Exception {
		logger.debug("open mq...");
		bizMqHelper.openMQ();
		resultMqHelper.openMQ();
		logger.debug("opened mq");
	}

	/**
	 * 只有在没有消息线程sleep时才能直接向外抛出 InterruptedException，<br/>
	 * 其他情况下需捕获异常且等待当前操作完成再中断
	 * 
	 * @see cn.com.sinosoft.ie.ahp.common.StopableRepeatThread#doRepeat()
	 */
	@Override
	protected void doRepeat() throws InterruptedException {
		logger.debug("begin doRepeat");
		this.workerState.refreshLastCheckTime();
		Object msg = null;
		try {
			msg =  bizMqHelper.getMessage();
		} catch (MQException e) {
			
		}
		
		/*-------------------*/
		msg = new Object();//ClientProperties();//
		 
		/*------------------*/
		if (msg == null) {
			logger.debug(this.workerState.getLastChecktime() + " no msg，sleep a while");
			try {
				Thread.sleep(30000);
			} catch (InterruptedException ignore) {
				// 因为没有工作需要做，所以可以直接抛出该异常中断循环,不会有什么副作用
				throw ignore;
			}
			return;
		}
		
		if( !(msg instanceof ClientProperties)){
			throw new RuntimeException("msg not a "+ClientProperties.class.getName());
		}
		ClientProperties cp = (ClientProperties) msg;
		
	}

	@Override
	protected void afterRepeat() throws Exception {
		bizMqHelper.closeMQ();
		resultMqHelper.closeMQ();
	}

	@Override
	protected void repeatInterrupted() {
		// TODO Auto-generated method stub

	}

	@Override
	public void wkInit(WorkerConfig config) {
		this.workConfig = config;
		this.bizMqHelper = new SimpleMQHelper(config.getMqBizConfig());
		this.resultMqHelper = new SimpleMQHelper(config.getMqResultConfig());
		// 为了简单，不使用生成策略，直接替换系统自动生成的线程名
		// 比如把 Thread-1 替换为 test-1
		this.setName(this.getName().replace(SYS_DEFAULT_THREAD_PREFIX,
				config.getNamePrefix()));
		this.workerState.setName(this.getName());
		this.setUncaughtExceptionHandler(new UncaughtExceptionHandler() {
			@Override
			public void uncaughtException(Thread t, Throwable e) {
				SimpleWorker sw = (SimpleWorker)t;
				sw.workerState.setWorkRight(false);
				sw.workerState.setLastError(e);
			}
		});
	}

	@Override
	public void wkStart() {
		start();
		this.workerState.setWorkRight(true);
	}

	@Override
	public void wkStop() {
		super.shouldStop();
	}

	@Override
	public Map<String, Object> getWkState() {
		Map state = this.workerState.toMap();
		state.put("XX", "XX");
		return state;
	}

}
