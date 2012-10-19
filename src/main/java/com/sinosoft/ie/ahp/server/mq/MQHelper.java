package com.sinosoft.ie.ahp.server.mq;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.app.ServerConfig;

import com.rabbitmq.client.AMQP.BasicProperties;
import com.rabbitmq.client.AMQP.Queue.DeclareOk;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.QueueingConsumer;
import com.rabbitmq.client.ReturnListener;
import com.sinosoft.ie.ahp.msg.ClientProperties;
import com.sinosoft.ie.ahp.msg.ReceiveMessage;
import com.sinosoft.ie.ahp.util.ObjectSerilize;

public class MQHelper {
	private static final Logger logger = LoggerFactory
			.getLogger(MQHelper.class);
	private ServerConfig config;
	private Connection conn;
	private Channel receiveChannel;
	private Channel sendChannel;
	private DeclareOk receiveDeclareOk;
	private QueueingConsumer consumer;
	
	public MQHelper(ServerConfig config) {
		super();
		this.config = config;
	}

	public Connection getConnection(boolean forceNew) throws MQException {
		if (conn == null || !conn.isOpen() || forceNew) {
			ConnectionFactory factory = new ConnectionFactory();
			factory.setUsername(config.getMqUsername());
			factory.setPassword(config.getMqPassword());
			factory.setHost(config.getMqIp());

			try {
				conn = factory.newConnection();
			} catch (IOException e) {
				MQException mqe = new MQException("MQ conn open exception！", e);
				throw mqe;
			}

		}
		return conn;
	}

	public ClientProperties getClientProperties() throws MQException {
		if (receiveDeclareOk == null) {
			throw new MQException(
					"receiveDeclareOk is null,you may forget call openMQ()");
		}
		int msgCount = receiveDeclareOk.getMessageCount();
		//没有消息,返回null
		if ( msgCount==0) {
			logger.debug("msg null!");
			return null;
		}
		//logger.info("----> "+msgCount);
		try {
			QueueingConsumer.Delivery delivery =consumer.nextDelivery();
		
			// 给收到消息（业务信息）发送回执,不是返回消息
			if(receiveChannel.isOpen()){
				receiveChannel.basicAck(delivery.getEnvelope().getDeliveryTag(), false);
			}else{
				logger.info("*************");
			}
			byte[] msgBody = delivery.getBody();
			Object message = ObjectSerilize.getObjectFromBytes(msgBody);
			if (message instanceof ClientProperties) {
				ClientProperties cp = (ClientProperties) message;
				if(logger.isDebugEnabled()){
					logger.info(cp.getBussinessId()+" "+cp.getPatientPerosnId());
				}
				return cp;
				
			}else{
				MQException mqe = new MQException("msg not instanceof ClientProperties!");
				logger.error(mqe.getLocalizedMessage());
				throw mqe;
			}
		} catch (Exception e) {
			MQException mqe = new MQException("peek mq msg exception!",e);
			logger.error(mqe.getLocalizedMessage(),mqe);
			throw mqe;
		}
	}

	public void sendReceiveMessage(ReceiveMessage rm) throws MQException {
		try {
			sendChannel.basicPublish(ServerConfig.RECEIVEQUEUE, "", null,
					ObjectSerilize.getBytesFromObject(rm));
		} catch (IOException e) {
			MQException mqe = new MQException("MQ send msg exception！", e);
			throw mqe;
		} catch (Exception e) {
			MQException mqe = new MQException("msg serilize exception！", e);
			throw mqe;
		}
	}

	public void openMQ() throws MQException {
		try {
			conn = getConnection(true);
			// 接收业务消息队列
			this.receiveChannel = conn.createChannel();

			receiveChannel.exchangeDeclare(ServerConfig.SENDQUEUE, "direct");
			receiveDeclareOk = receiveChannel.queueDeclare("sendq", false,
					false, false, null);
			//接收的最大消息数量,防止接收过多内存溢出
			receiveChannel.basicQos( config.getMqMaxMsgCount() ); 
			receiveChannel.queueBind("sendq", ServerConfig.SENDQUEUE, "");

			consumer = new QueueingConsumer(receiveChannel);
			receiveChannel.basicConsume("sendq", false, consumer);
			// 发送回执消息队列
			sendChannel = conn.createChannel();
			sendChannel.exchangeDeclare(ServerConfig.RECEIVEQUEUE,"direct" );
			sendChannel.queueDeclare("receiveq", false, false, false, null);
			sendChannel.queueBind("receiveq", ServerConfig.RECEIVEQUEUE, "");
		} catch (IOException e) {
			MQException mqe = new MQException("MQ init exception！", e);
			throw mqe;
		} catch (Exception e) {
			MQException mqe = new MQException("MQ init exception！", e);
			throw mqe;
		}
		// 设置return listener，处理不能发送或未被送达的消息，
		// 如果发送时设置 强制发送 或 立即发送 ，但是消息没有被接收到，就会回调return listener
		sendChannel.addReturnListener(new ReturnListener() {
			@Override
			public void handleReturn(int arg0, String arg1, String arg2,
					String arg3, BasicProperties arg4, byte[] arg5)
					throws IOException {
				// TODO 发送回执信息失败处理
				logger.error("send msg error!" + arg4.toString());
			}
		});

		// receiveChannel.addConfirmListener(arg0)
	}

	public void closeMQ() throws MQException {
		try {
			if(sendChannel!=null && sendChannel.isOpen()){
				sendChannel.close();
			}
			if(receiveChannel!=null && receiveChannel.isOpen()){
				receiveChannel.close();
			}
			if(conn!=null && conn.isOpen()){
				conn.close();
			}
		} catch (Exception e) {
			MQException mqe = new MQException("MQ close exception！", e);
			throw mqe;
		}
	}
}
