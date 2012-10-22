package cn.com.sinosoft.ie.ahp.server.service;

public class BizResult {
	private BizResultCode code;
	private String msg;
	private String bizId;
	private String ppId;

	
	
	public BizResult() {
		super();
	}

	public BizResult(String bizId, String ppId) {
		super();
		this.bizId = bizId;
		this.ppId = ppId;
	}

	public BizResultCode getCode() {
		return code;
	}

	public void setCode(BizResultCode code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getBizId() {
		return bizId;
	}

	public void setBizId(String bizId) {
		this.bizId = bizId;
	}

	public String getPpId() {
		return ppId;
	}

	public void setPpId(String ppId) {
		this.ppId = ppId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bizId == null) ? 0 : bizId.hashCode());
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((msg == null) ? 0 : msg.hashCode());
		result = prime * result + ((ppId == null) ? 0 : ppId.hashCode());
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
		BizResult other = (BizResult) obj;
		if (bizId == null) {
			if (other.bizId != null)
				return false;
		} else if (!bizId.equals(other.bizId))
			return false;
		if (code != other.code)
			return false;
		if (msg == null) {
			if (other.msg != null)
				return false;
		} else if (!msg.equals(other.msg))
			return false;
		if (ppId == null) {
			if (other.ppId != null)
				return false;
		} else if (!ppId.equals(other.ppId))
			return false;
		return true;
	}

}
