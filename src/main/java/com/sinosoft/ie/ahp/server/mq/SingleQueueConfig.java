package com.sinosoft.ie.ahp.server.mq;

import java.util.Properties;

public class SingleQueueConfig {
	private static final String DEFAULT_EXCHANGE_TYPE= "direct";
	private static final String DEFAULT_USERNAME = "guest";
	private static final String DEFAULT_PASSWD = "guest";
	private static final int DEFAULT_MAX_MSG_COUNT = 100;

	// ip
	private String ip ;
	// 端口
	private int port;
	// 积压的最大消息数
	private int maxMsgCount;
	// 交换机名
	private String exchangeName;
	// 交换机类型
	private String exchangeType;
	// 路由键
	private String routingKey;
	// 队列名
	private String queueName;
	// 用户名密码
	private String username;
	private String password;

	
	
	public SingleQueueConfig(String ip, int port, String exchangeName, 
			String exchaggeType, String routingKey,String queueName,
			Integer maxMsgCount,String username, String password) {
		super();
		this.ip = ip;
		this.port = port;
		this.exchangeName = exchangeName;
		this.routingKey = routingKey;
		this.queueName = queueName;
		this.exchangeType = exchangeType==null ? DEFAULT_EXCHANGE_TYPE : exchangeType;
		this.maxMsgCount = maxMsgCount==null ? DEFAULT_MAX_MSG_COUNT : maxMsgCount;
		this.username = username==null ? DEFAULT_USERNAME : username;
		this.password = password==null ? DEFAULT_PASSWD : password;
	}

	public String getIp() {
		return ip;
	}

	public int getPort() {
		return port;
	}

	public int getMaxMsgCount() {
		return maxMsgCount;
	}

	public String getExchangeName() {
		return exchangeName;
	}

	public String getExchangeType() {
		return exchangeType;
	}

	public String getQueueName() {
		return queueName;
	}

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public String getRoutingKey() {
		return routingKey;
	}
	
	public void getConfig(Properties props, String prefix){
		
	}
	
}
