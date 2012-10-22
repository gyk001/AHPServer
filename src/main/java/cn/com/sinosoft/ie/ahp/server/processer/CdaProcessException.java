package cn.com.sinosoft.ie.ahp.server.processer;

import com.sinosoft.ie.ahp.msg.ReturnCode;

/**
 * @author 郭玉昆(<a href="mailto:gyk001@gmail.com">gyk001@gmail.com</a>)
 * @version 2012-5-22
 * 
 */
public class CdaProcessException extends Exception {
	private static final long serialVersionUID = -2587141879708826724L;

	private ReturnCode returnCode;

	public CdaProcessException() {
		super();
		this.returnCode = ReturnCode.UNKNOWN_ERROR;
	}

	public CdaProcessException(String message, ReturnCode returnCode) {
		super(message);
		this.returnCode = returnCode;
	}

	public CdaProcessException(String message, Throwable cause,
			ReturnCode returnCode) {
		super(message, cause);
		this.returnCode = returnCode;
	}

	public CdaProcessException(String message, Throwable cause) {
		super(message, cause);
		if (cause instanceof CdaProcessException) {
			this.returnCode = ((CdaProcessException) cause).getReturnCode();
		}
	}

	public CdaProcessException(String message) {
		super(message);
		this.returnCode = ReturnCode.UNKNOWN_ERROR;
	}

	public CdaProcessException(Throwable cause) {
		super(cause);
		if (cause instanceof CdaProcessException) {
			this.returnCode = ((CdaProcessException) cause).getReturnCode();
		}
	}

	public ReturnCode getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(ReturnCode returnCode) {
		this.returnCode = returnCode;
	}

}
