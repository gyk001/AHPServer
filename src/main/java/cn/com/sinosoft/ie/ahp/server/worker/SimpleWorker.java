package cn.com.sinosoft.ie.ahp.server.worker;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.common.StopableRepeatThread;
import cn.com.sinosoft.ie.ahp.server.mq.MQException;
import cn.com.sinosoft.ie.ahp.server.mq.SimpleMQHelper;

public class SimpleWorker extends StopableRepeatThread {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory
			.getLogger(SimpleWorker.class);
	//
	private WorkerConfig workConfig;
	// 业务接收
	private SimpleMQHelper bizMqHelper;
	// 结果发送
	private SimpleMQHelper resultMqHelper;
	// 最后检查有无数据时间
	private long lastChecktime;
	// 最后的出现错误
	private Throwable lastError;

	public SimpleWorker(WorkerConfig config) {
		super();
		this.workConfig = config;
		this.bizMqHelper = new SimpleMQHelper(config.getMqBizConfig());
		this.resultMqHelper = new SimpleMQHelper(config.getMqResultConfig());
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
		// TODO Auto-generated method stub
		logger.debug("begin doRepeat");
		this.lastChecktime = System.nanoTime();
		Object msg = null;// bizMqHelper.getMessage();
		if (msg == null) {
			logger.debug(this.lastChecktime+" no msg，sleep a while");
			try{
				Thread.sleep(30000);
			}catch(InterruptedException ignore){
				//因为没有工作需要做，所以可以直接抛出该异常中断循环,不会有什么副作用
				throw ignore;
			}
			return;
		}

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

}
