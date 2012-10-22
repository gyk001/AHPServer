package cn.com.sinosoft.ie.ahp.server.service.cda;

import java.io.Serializable;


/**
 * 可以根据业务类型和业务版本区分文档模板的key
 * 
 * @author <a href="gyk001@gmail.com">Guo Yukun</a>
 * @version 2012-10-22
 */
public class TypeVersionCdaKey implements Serializable{
	private static final long serialVersionUID = -8078385986452227628L;
	// 默认版本号，因为CDA没有，认为是版本1
	public static final String DEFALUT_VERSION = "1";
	// 业务类型(如:PRPA_MT000101UV01)
	private String bizType;
	// CDA版本
	private String version =DEFALUT_VERSION;
	
	public TypeVersionCdaKey() {
		super();
	}
	
	public TypeVersionCdaKey(String bizType) {
		super();
		this.bizType = bizType;
	}

	public TypeVersionCdaKey(String bizType, String version) {
		super();
		this.bizType = bizType;
		this.version = version;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bizType == null) ? 0 : bizType.hashCode());
		result = prime * result + ((version == null) ? 0 : version.hashCode());
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
		TypeVersionCdaKey other = (TypeVersionCdaKey) obj;
		if (bizType == null) {
			if (other.bizType != null)
				return false;
		} else if (!bizType.equals(other.bizType))
			return false;
		if (version == null) {
			if (other.version != null)
				return false;
		} else if (!version.equals(other.version))
			return false;
		return true;
	}

	public String getBizType() {
		return bizType;
	}

	public void setBizType(String bizType) {
		this.bizType = bizType;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	
	
}
