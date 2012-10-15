package cn.com.sinosoft.ie.ahp.server.cda;

import java.io.Serializable;

public class CdaKey implements Serializable{
	private static final long serialVersionUID = -1816346477055816208L;
	//默认版本号，因为CDA没有，认为是版本1
	private static final String DEFALUT_VERSION="1";
	//业务类型(如:PRPA_MT000101UV01)
	private String bizType ;
	//CDA版本
	private String version ;
	
	public CdaKey() {
		super();
		this.version = DEFALUT_VERSION;
	}
	
	public CdaKey(String bizType) {
		super();
		this.version = DEFALUT_VERSION;
		this.bizType = bizType;
	}

	public CdaKey(String bizType, String version) {
		super();
		this.bizType = bizType;
		this.version = version;
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
		CdaKey other = (CdaKey) obj;
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
	
}
