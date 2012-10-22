package cn.com.sinosoft.ie.ahp.server.app;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.mq.MQException;
import cn.com.sinosoft.ie.ahp.server.mq.MQHelper;
import cn.com.sinosoft.ie.ahp.server.mq.SimpleMQHelper;
import cn.com.sinosoft.ie.ahp.server.mq.SingleQueueConfig;
import cn.com.sinosoft.ie.ahp.server.processer.CdaProcessException;
import cn.com.sinosoft.ie.ahp.server.processer.ICdaProcesser;

import com.sinosoft.ie.ahp.msg.ClientProperties;
import com.sinosoft.ie.ahp.msg.ReceiveMessage;
import com.sinosoft.ie.ahp.msg.ReturnCode;

/**
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-28
 * 
 */
public class WorkerThread extends Thread {
	private static final Logger logger = LoggerFactory
			.getLogger(WorkerThread.class);
	private volatile boolean stopFlag;
	private ServerConfig config;
	private SimpleMQHelper bizMqHelper;
	private SimpleMQHelper resultMqHelper;
	private String lastError;
	//处理成功的业务记录
	private static Logger bizSuccessLogger = LoggerFactory.getLogger(BizSuccessLogger.class);
	//处理失败的业务记录
	private static Logger bizErrorLogger = LoggerFactory.getLogger(BizErrorLogger.class);

	//接收到的消息总数
	private int msgCount = 0;
	//处理成功的消息数
	private int successMsg = 0;
	//处理出错的消息数
	private int errorMsg = 0;
	//正在处理的消息数
	private int processingMsg = 0;
	//成功返回的消息数
	private int sentMsg = 0;
	
	public void setStopableFlag() {
		this.stopFlag = true;
		logger.info("set stopFlag for "+this.getName()+" to stop ...");
	}
	
	@Override
	public void run() {
		// 停止标志
		stopFlag = false;
		logger.info(getName() + " running...");
		// 捕获所有异常，不要向外抛出，否则会回中断消息处理
		try {
			// 开启mq
			try {
				logger.info(getName() +"打开mq资源...");
				this.bizMqHelper.openMQ(true);
				this.resultMqHelper.openMQ(false);
			} catch (MQException e) {
				lastError = e.getLocalizedMessage();
				logger.error("open mq error! " + getName() + " exit...", e);
				// 结束线程
				return;
			}

			while (!stopFlag) {
				ClientProperties cp = null;
				try {
					Object msg = bizMqHelper.getMessage();
					try{
						cp = (ClientProperties)msg;
					}catch(Exception e){
						logger.warn("msg type not ClientProperties!");
					}
					if(logger.isDebugEnabled()){
						if(cp!=null){
							logger.debug(cp.getPatientPerosnId());
						}else{
							logger.debug("msg null");
						}
					}
					//logger.debug(cp);
				} catch (Exception e) {
					logger.warn("received msg exception!", e);
				}
				processMsg(cp);
			}
			
			logger.info(getName() +"释放mq资源...");
			// 结束mq
			try {
				this.bizMqHelper.closeMQ();
				this.resultMqHelper.closeMQ();
			} catch (MQException e) {
				lastError = e.getLocalizedMessage();
				logger.error("close mq error!" + getName() + " exit...", e);
				// 结束线程
				return;
			}
			
		} catch (Exception anyException) {
			logger.warn("some exception!", anyException);
		}
		logger.info(getName() + " exit..");
	}
	
	private void processMsg(ClientProperties cp){
		StringBuffer bizLog = new StringBuffer(getName());
		if (cp != null) {
			// 消息总数递增
			msgCount ++;
			// 处理中消息递增
			processingMsg++;
		
			//logger.info( bizLog.toString()+" "+msgcount );

			// 业务主键
			String bussinessId = cp.getBussinessId();
			// 消息类型
			String msgType = cp.getCdaCode();
			// CDA文档内容
			String cda = cp.getXmlParam();
			// 患者或人员ID
			String ppId = cp.getPatientPerosnId();
			
			//组装日志字符串
			bizLog.append(" ").append(msgType).append(" ").append( bussinessId ).append(" ").append( ppId );
			
			// 组装返回消息
			ReceiveMessage rm = new ReceiveMessage();
			rm.setBussinessId(cp.getBussinessId());
			rm.setMsgType(cp.getCdaCode());

			// 实例化处理类
			ICdaProcesser processer = config.getCdaProcesser(msgType);
			try {
				if (processer == null) {
					throw new CdaProcessException(
							"cannot init a cda processer!",
							ReturnCode.ERROR);
				}
				// 处理业务
				processer.process(cda, ppId, bussinessId, cp);
				// 设置成功标志
				rm.setReturnCode(ReturnCode.SUCCESS);
				// 成功计数累加
				successMsg++;
				// 记录业务日志
				bizSuccessLogger.info(bizLog.toString());
			} catch (CdaProcessException e) {
				ReturnCode rc = e.getReturnCode();
				if (rc == null) {
					rc = ReturnCode.UNKNOWN_ERROR;
					e.setReturnCode(rc);
				}
				// 设置失败标志
				rm.setReturnCode(rc);
				// 失败计数累加
				errorMsg++;
				// 记录业务失败日志
				bizErrorLogger.info(bizLog.toString());
				if (rc == ReturnCode.HAVE_NOT_PERSON) {
					logger.error("patientreg not exists :" + ppId);
				} else {
					logger.error(e.getLocalizedMessage());
					// throw e;
				}
			} catch (Exception e) {
				// 设置失败标志
				rm.setReturnCode(ReturnCode.UNKNOWN_ERROR);
				// 失败计数累加
				errorMsg++;
				// 记录业务失败日志
				bizErrorLogger.info(bizLog.toString());
				logger.error("CDA信息处理异常！", e);
				// throw e;
			} finally {
				// 处理中计数
				processingMsg--;
				try {
					// 客户端返回数据
					resultMqHelper.sendMessage(rm);
					// 成功返回的消息数
					sentMsg ++;
				} catch (MQException e) {
					logger.error("send receive msg exception!", e);
					// 记录日志
				}

				bizLog.append(" -> ").append( rm.getReturnCode() );
				logger.info(bizLog.toString() );
			}
		
		} else {
			//logger.info("no more msg,wait 3sec...");
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				logger.warn(e.getLocalizedMessage());
			}
		}
	}

	public WorkerThread(String name, ServerConfig config,
			MQHelper mqHelper) {
		super(name);
		this.config = config;
		SingleQueueConfig bizCfg = new SingleQueueConfig(config.getMqIp(), config.getMqPort(), 
				config.getMqBizExchange() ,null , config.getMqBizRoutingKey(), config.getMqBizQueue(),
				config.getMqMaxMsgCount(), config.getMqUsername(), config.getMqPassword());
		SingleQueueConfig resCfg = new SingleQueueConfig(config.getMqIp(), config.getMqPort(), 
				config.getMqResultExchange() , null, config.getMqResultRoutingKey(), config.getMqResultQueue(),
				config.getMqMaxMsgCount(), config.getMqUsername(), config.getMqPassword());
		this.resultMqHelper = new SimpleMQHelper(resCfg);
		this.bizMqHelper = new SimpleMQHelper(bizCfg);
		
		this.setUncaughtExceptionHandler(new UncaughtExceptionHandler() {
			
			@Override
			public void uncaughtException(Thread t, Throwable e) {
				logger.error("uncaughtException!"+e,e);
				
				if(WorkerThread.this.bizMqHelper!=null){
					try {
						WorkerThread.this.bizMqHelper.closeMQ();
					} catch (MQException e1) {
						logger.error("close mq exception when uncaughtException!",e1);
					}
				}
				
				if(WorkerThread.this.resultMqHelper!=null){
					try {
						WorkerThread.this.resultMqHelper.closeMQ();
					} catch (MQException e1) {
						logger.error("close mq exception when uncaughtException!",e1);
					}
				}
			}
		});
	}
	public String getLastError() {
		return lastError;
	}
	
	public String getMsgState(boolean header){
		StringBuffer ms = new StringBuffer();
		if(header){
			ms.append("ThreadName\tTotal\tSuccess\tError\tProssess\tSending\n");
		}
		ms.append( this.getName() ).append("\t").append(msgCount)
			.append("\t").append(this.successMsg).append("\t").append(this.errorMsg)
			.append("\t").append(this.processingMsg).append("\t").append(this.sentMsg);
		//ms.append(resultMqHelper.getMessage())
		return ms.toString();
	}
}
