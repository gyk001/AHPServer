package cn.com.sinosoft.ie.ahp.server.worker;

import java.io.Serializable;
import java.util.LinkedHashMap;

import cn.com.sinosoft.ie.ahp.server.ServerConfig;
import cn.com.sinosoft.ie.ahp.server.mq.SingleQueueConfig;
import cn.com.sinosoft.ie.ahp.server.service.BizPluginHandler;

public class WorkerConfig implements Serializable {
	private static final long serialVersionUID = -6703803106631691168L;
	private ServerConfig serverConfig;
	//配置名前缀
	private String namePrefix;
	//实现类的完全限定名
	private String clazz;
	//线程数
	private int thread;
	//接收业务的mq配置
	private SingleQueueConfig mqBizConfig;
	//发送处理结果的mq配置
	private SingleQueueConfig mqResultConfig;
	//业务处理的插件列表
	private LinkedHashMap<String,BizPluginHandler> serviceHandlers;
	
	public ServerConfig getServerConfig() {
		return serverConfig;
	}
	public void setServerConfig(ServerConfig serverConfig) {
		this.serverConfig = serverConfig;
	}
	public String getNamePrefix() {
		return namePrefix;
	}
	public void setNamePrefix(String namePrefix) {
		this.namePrefix = namePrefix;
	}
	public String getClazz() {
		return clazz;
	}
	public void setClazz(String clazz) {
		this.clazz = clazz;
	}
	public int getThread() {
		return thread;
	}
	public void setThread(int thread) {
		this.thread = thread;
	}
	public SingleQueueConfig getMqBizConfig() {
		return mqBizConfig;
	}
	public void setMqBizConfig(SingleQueueConfig mqBizConfig) {
		this.mqBizConfig = mqBizConfig;
	}
	public SingleQueueConfig getMqResultConfig() {
		return mqResultConfig;
	}
	public void setMqResultConfig(SingleQueueConfig mqResultConfig) {
		this.mqResultConfig = mqResultConfig;
	}
	public LinkedHashMap<String, BizPluginHandler> getServiceHandlers() {
		return serviceHandlers;
	}
	public void setServiceHandlers(
			LinkedHashMap<String, BizPluginHandler> serviceHandlers) {
		this.serviceHandlers = serviceHandlers;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((clazz == null) ? 0 : clazz.hashCode());
		result = prime * result
				+ ((mqBizConfig == null) ? 0 : mqBizConfig.hashCode());
		result = prime * result
				+ ((mqResultConfig == null) ? 0 : mqResultConfig.hashCode());
		result = prime * result
				+ ((namePrefix == null) ? 0 : namePrefix.hashCode());
		result = prime * result
				+ ((serviceHandlers == null) ? 0 : serviceHandlers.hashCode());
		result = prime * result + thread;
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
		WorkerConfig other = (WorkerConfig) obj;
		if (clazz == null) {
			if (other.clazz != null)
				return false;
		} else if (!clazz.equals(other.clazz))
			return false;
		if (mqBizConfig == null) {
			if (other.mqBizConfig != null)
				return false;
		} else if (!mqBizConfig.equals(other.mqBizConfig))
			return false;
		if (mqResultConfig == null) {
			if (other.mqResultConfig != null)
				return false;
		} else if (!mqResultConfig.equals(other.mqResultConfig))
			return false;
		if (namePrefix == null) {
			if (other.namePrefix != null)
				return false;
		} else if (!namePrefix.equals(other.namePrefix))
			return false;
		if (serviceHandlers == null) {
			if (other.serviceHandlers != null)
				return false;
		} else if (!serviceHandlers.equals(other.serviceHandlers))
			return false;
		if (thread != other.thread)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "WorkerConfig [namePrefix=" + namePrefix + ", clazz=" + clazz
				+ ", thread=" + thread + ", mqBizConfig=" + mqBizConfig
				+ ", mqResultConfig=" + mqResultConfig + ", serviceHandlers="
				+ serviceHandlers + "]";
	}
	
	
		
}
