package com.sinosoft.ie.ahp.server.mq;

import java.io.IOException;
import java.io.Serializable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.rabbitmq.client.AMQP.BasicProperties;
import com.rabbitmq.client.AMQP.Queue.DeclareOk;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.ConsumerCancelledException;
import com.rabbitmq.client.QueueingConsumer;
import com.rabbitmq.client.ReturnListener;
import com.rabbitmq.client.ShutdownSignalException;
import com.sinosoft.ie.ahp.util.ObjectSerilize;

public class SimpleMQHelper {
	private static final Logger logger = LoggerFactory
			.getLogger(SimpleMQHelper.class);
	private static ConnectionFactory factory = new ConnectionFactory();
	
	private SingleQueueConfig config;
	private Connection conn;
	private Channel channel;
	private DeclareOk declareOk;
	private QueueingConsumer consumer;
	
	public SimpleMQHelper(SingleQueueConfig config) {
		super();
		this.config = config;
	}

	
	public void openMQ(boolean canReceive) throws MQException {
		try {
			conn = getConnection(false);
			// 队列通道
			this.channel = conn.createChannel();

			channel.exchangeDeclare(config.getExchangeName(), config.getExchangeType());
			declareOk = channel.queueDeclare(config.getQueueName(), false,
					false, false, null);
			channel.queueBind(config.getQueueName(), config.getExchangeName(), config.getRoutingKey());
			//接收的最大消息数量,防止接收过多内存溢出
			channel.basicQos( config.getMaxMsgCount() ); 
			if(canReceive){
				consumer = new QueueingConsumer(channel);
				channel.basicConsume(config.getQueueName(), false, consumer);
			}
		} catch (IOException e) {
			MQException mqe = new MQException("MQ init exception！", e);
			throw mqe;
		} catch (Exception e) {
			MQException mqe = new MQException("MQ init exception！", e);
			throw mqe;
		}
		// 设置return listener，处理不能发送或未被送达的消息，
		// 如果发送时设置 强制发送 或 立即发送 ，但是消息没有被接收到，就会回调return listener
		channel.addReturnListener(new ReturnListener() {
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
	
	public Connection getConnection(boolean forceNew) throws MQException {
		if (conn == null || !conn.isOpen() || forceNew) {
			factory.setUsername(config.getUsername());
			factory.setPassword(config.getPassword());
			factory.setHost(config.getIp());
			synchronized (this) {
				try {
					conn = factory.newConnection();
				} catch (IOException e) {
					MQException mqe = new MQException("MQ conn open exception！", e);
					throw mqe;
				}
			}

		}
		return conn;
	}
	public Object getMessage() throws MQException {
		logger.debug("getMessage...");
		if (declareOk == null) {
			throw new MQException(
					"receiveDeclareOk is null, you may forget call openMQ(true)!");
		}
		
		/*
		int msgCount = declareOk.getMessageCount();
		//没有消息,返回null
		if ( msgCount==0) {
			logger.debug("msg null!");
			return null;
		}
		logger.debug("----> "+msgCount);
		*/
		
		try {
			QueueingConsumer.Delivery delivery = null;
			try {
				delivery = consumer.nextDelivery(3000);
			} catch (ShutdownSignalException e1) {
				logger.warn("ShutdownSignalException",e1);
				return null;
			} catch (ConsumerCancelledException e1) {
				throw e1;
			} catch (InterruptedException e1) {
				logger.warn("InterruptedException",e1);
				return null;
			}
			if(delivery == null){
				return null;
			}
			// 给收到消息（业务信息）发送回执,不是返回消息
			if(channel.isOpen()){
				logger.debug("ack..");
				channel.basicAck(delivery.getEnvelope().getDeliveryTag(), false);
			}else{
				logger.info("*************");
			}
			byte[] msgBody = delivery.getBody();
			Object message = ObjectSerilize.getObjectFromBytes(msgBody);
			return message;
		} catch (Exception e) {
			MQException mqe = new MQException("peek mq msg exception!",e);
			logger.error(mqe.getLocalizedMessage(),mqe);
			throw mqe;
		}
	}
	
	public void sendMessage(Serializable msg) throws MQException {
		try {
			channel.basicPublish(config.getExchangeName(), config.getRoutingKey(), null,
					ObjectSerilize.getBytesFromObject(msg));
		} catch (IOException e) {
			MQException mqe = new MQException("MQ send msg exception！", e);
			throw mqe;
		} catch (Exception e) {
			MQException mqe = new MQException("msg serilize exception！", e);
			throw mqe;
		}
	}
	
	public void closeMQ() throws MQException {
		try {
			if(channel!=null && channel.isOpen()){
				channel.close();
			}
			if(channel!=null && channel.isOpen()){
				channel.close();
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
