package cn.com.sinosoft.ie.ahp.common;
import java.io.Closeable;
import java.io.InputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 可温和终止的循环工作线程<br/>
 * <p>该线程会不断循环调用{@linkplain #doRepeat()}
 * ,直到被{@linkplain #shouldStop()}或者{@linkplain Thread#interrupt()}中断,<br/>
 * 中断后会回调{@linkplain #repeatInterrupted()}方法。<br/>
 * 该类目前<b>没有</b>实现对<i>不可中断的IO操作</i>进行中断，如System.in.read(),但是可以中断RabbitMQ的操作
 * </p>
 * <p>
 * TODO:<b>已经取消ingerrupt()中断,因为会导致正在进行的sql操作和mq操作失败,现在是每次操作后进行一次判定<br/>
 * 但是mq服务器宕机后mqHelper无限重连状态无法中断,待以后完善</b>
 * </p>
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-6-3
 *
 */
public abstract class StopableRepeatThread extends Thread{
	private static final Logger logger = LoggerFactory.getLogger(StopableRepeatThread.class); 
	private boolean stopping = false;
	private boolean initiative = false;
	private Closeable closeable = null;
	
	
	
	public boolean isInitiative() {
		return initiative;
	}

	/* (non-Javadoc)
	 * @see java.lang.Thread#run()
	 */
	@Override
	public final void run() {
		try {
			beforRepeat();
		} catch (Exception e) {
			logger.error("before repeat exception !",e);
			return;
		}
		while( ! initiative){
			try {
				doRepeat();
				super.yield();
			} catch (InterruptedException e) {
				logger.debug("{} has been interrupted!", this.getName());
				this.stopping = true;                        
				repeatInterrupted();  
				Thread.interrupted();//清除中断状态
			}
		}
		try {
			afterRepeat();
		} catch (Exception e) {
			logger.error("after repeat exception !",e);
			return;
		}
		this.stopping = false;
	}
	
	public final void setCloseable(Closeable closeable){
		this.closeable = closeable;
	}
	
	/**
	 * 调用该方法可中断正在进行的工作，（不可中断的IO操作除外，如{@link InputStream#read()}）
	 * 进而触发{@linkplain #repeatInterrupted()}和{@linkplain #afterRepeat()}终止线程
	 * @see {@linkplain #repeatInterrupted()}
	 * @see {@linkplain #afterRepeat()} 
	 */
	public final void shouldStop(){
		logger.debug("{} will be interrupted...",this.getName());
		initiative = true;
		/*
		super.interrupt();
		if(this.closeable!=null){
			try {
				closeable.close();
			} catch (IOException e) {
				logger.warn("close closeable to stop io!");
			}
		}
		*/
	}
	
	/**
	 * 判断是否因为被中断而处于正在停止状态，
	 * 从线程接收到中断到{@linkplain #afterRepeat()}调用完成该值都为true
	 * @return 
	 */
	public final boolean isStopping() {
		return stopping;
	}
	
	/**
	 * 工作初始化方法，开始循环工作前调用，只调用一次
	 * @see {@linkplain #doRepeat()}
	 * @see {@linkplain #afterRepeat()}
	 * @throws Exception
	 */
	protected abstract void beforRepeat() throws Exception;
	/**
	 * 工作方法，会被不断重复调用直至被{@linkplain #shouldStop()}中断.
	 * @see {@linkplain #beforRepeat()}
	 * @see {@linkplain #afterRepeat()}
	 * @see {@linkplain #repeatInterrupted()}
	 * @throws InterruptedException
	 */
	protected abstract void doRepeat() throws InterruptedException;
	/**
	 * 工作结束，可进行资源的释放工作，只调用一次
	 * @see {@linkplain #beforRepeat()}
	 * @see {@linkplain #doRepeat()}
	 * @throws Exception
	 */
	protected abstract void afterRepeat() throws Exception;
	
	/**
	 * 当进程被{@linkplain #shouldStop()}方法或{@linkplain #interrupt()}方法中断时调用。<br/>
	 * 该方法调用后仍会正常调用{@linkplain #afterRepeat()}方法
	 * @see {@linkplain #shouldStop()}
	 * @see {@linkplain #afterRepeat()}
	 */
	protected abstract void repeatInterrupted();
	
	public StopableRepeatThread() {
		super();
	}

	public StopableRepeatThread(Runnable target, String name) {
		super(target, name);
	}

	public StopableRepeatThread(Runnable target) {
		super(target);
	}

	public StopableRepeatThread(String name) {
		super(name);
	}

	public StopableRepeatThread(ThreadGroup group, Runnable target,
			String name, long stackSize) {
		super(group, target, name, stackSize);
	}

	public StopableRepeatThread(ThreadGroup group, Runnable target,
			String name) {
		super(group, target, name);
	}

	public StopableRepeatThread(ThreadGroup group, Runnable target) {
		super(group, target);
	}

	public StopableRepeatThread(ThreadGroup group, String name) {
		super(group, name);
	}
	
	
}
