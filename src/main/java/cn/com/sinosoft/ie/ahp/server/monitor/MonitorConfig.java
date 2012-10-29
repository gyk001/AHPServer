package cn.com.sinosoft.ie.ahp.server.monitor;

/**
 * @author 郭玉昆(<a href="mailto:gyk001@gmail.com">gyk001@gmail.com</a>)
 * @version 2012-7-5
 *
 */
public class MonitorConfig {
	private int port;
	private String contextPath;
	
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	public String getContextPath() {
		return contextPath;
	}
	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}
}
