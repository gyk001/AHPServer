package cn.com.sinosoft.ie.ahp.server.mq;

import java.io.Serializable;
import java.util.Properties;

/**
 * @author 郭玉昆(<a href="mailto:gyk001@gmail.com">gyk001@gmail.com</a>)
 * @version 2012-5-29
 *
 */
public class SingleQueueConfig implements Serializable {
	private static final long serialVersionUID = 4659719416378431487L;
	//默认交换机
	private static final String DEFAULT_EXCHANGE_TYPE= "direct";
	//默认用户名
	private static final String DEFAULT_USERNAME = "guest";
	//默认密码
	private static final String DEFAULT_PASSWD = "guest";
	//默认最大接收消息数
	private static final int DEFAULT_MAX_MSG_COUNT = 100;
	//配置名称
	private String name;
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
	//是否用于接收消息
	private boolean forReceive;
	
	public SingleQueueConfig(){}
	
	public SingleQueueConfig(String ip, int port, String exchangeName, 
			String exchaggeType, String routingKey,String queueName,
			Integer maxMsgCount,String username, String password) {
		super();
		this.forReceive=false;
		this.ip = ip;
		this.port = port;
		this.exchangeName = exchangeName;
		this.routingKey = routingKey;
		this.queueName = queueName;
		this.exchangeType = exchangeType==null ? DEFAULT_EXCHANGE_TYPE : exchangeType;
		this.maxMsgCount = maxMsgCount==null ? DEFAULT_MAX_MSG_COUNT : maxMsgCount;
		this.username = username==null ? DEFAULT_USERNAME : username;
		this.password = password==null ? DEFAULT_PASSWD : password;
		this.forReceive = false;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
	
	
	
	public void setIp(String ip) {
		this.ip = ip;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public void setMaxMsgCount(int maxMsgCount) {
		this.maxMsgCount = maxMsgCount;
	}

	public void setExchangeName(String exchangeName) {
		this.exchangeName = exchangeName;
	}

	public void setExchangeType(String exchangeType) {
		this.exchangeType = exchangeType;
	}

	public void setRoutingKey(String routingKey) {
		this.routingKey = routingKey;
	}

	public void setQueueName(String queueName) {
		this.queueName = queueName;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	

	public void getConfig(Properties props, String prefix){
		
	}

	
	
	public boolean isForReceive() {
		return forReceive;
	}

	public void setForReceive(boolean forReceive) {
		this.forReceive = forReceive;
	}
	
	

	@Override
	public String toString() {
		return "SingleQueueConfig [name=" + name + ", ip=" + ip + ", port="
				+ port + ", maxMsgCount=" + maxMsgCount + ", exchangeName="
				+ exchangeName + ", exchangeType=" + exchangeType
				+ ", routingKey=" + routingKey + ", queueName=" + queueName
				+ ", username=" + username + ", password=" + password
				+ ", forReceive=" + forReceive + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((exchangeName == null) ? 0 : exchangeName.hashCode());
		result = prime * result
				+ ((exchangeType == null) ? 0 : exchangeType.hashCode());
		result = prime * result + (forReceive ? 1231 : 1237);
		result = prime * result + ((ip == null) ? 0 : ip.hashCode());
		result = prime * result + maxMsgCount;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result
				+ ((password == null) ? 0 : password.hashCode());
		result = prime * result + port;
		result = prime * result
				+ ((queueName == null) ? 0 : queueName.hashCode());
		result = prime * result
				+ ((routingKey == null) ? 0 : routingKey.hashCode());
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SingleQueueConfig other = (SingleQueueConfig) obj;
		if (exchangeName == null) {
			if (other.exchangeName != null)
				return false;
		} else if (!exchangeName.equals(other.exchangeName))
			return false;
		if (exchangeType == null) {
			if (other.exchangeType != null)
				return false;
		} else if (!exchangeType.equals(other.exchangeType))
			return false;
		if (forReceive != other.forReceive)
			return false;
		if (ip == null) {
			if (other.ip != null)
				return false;
		} else if (!ip.equals(other.ip))
			return false;
		if (maxMsgCount != other.maxMsgCount)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (port != other.port)
			return false;
		if (queueName == null) {
			if (other.queueName != null)
				return false;
		} else if (!queueName.equals(other.queueName))
			return false;
		if (routingKey == null) {
			if (other.routingKey != null)
				return false;
		} else if (!routingKey.equals(other.routingKey))
			return false;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}

	

}
