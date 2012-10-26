package cn.com.sinosoft.ie.ahp.server.worker;

import com.sinosoft.ie.ahp.msg.ReturnCode;

/**
 * @author 郭玉昆(<a href="mailto:gyk001@gmail.com">gyk001@gmail.com</a>)
 * @version 2012-5-31
 * 
 */
public class WorkerException extends Exception {
	private static final long serialVersionUID = -3870038308118782380L;
	
	private ReturnCode returnCode;

	public WorkerException() {
		super();
		this.returnCode = ReturnCode.UNKNOWN_ERROR;
	}

	public WorkerException(String message, ReturnCode returnCode) {
		super(message);
		this.returnCode = returnCode;
	}

	public WorkerException(String message, Throwable cause,
			ReturnCode returnCode) {
		super(message, cause);
		this.returnCode = returnCode;
	}

	public WorkerException(String message, Throwable cause) {
		super(message, cause);
		if (cause instanceof WorkerException) {
			this.returnCode = ((WorkerException) cause).getReturnCode();
		}
	}

	public WorkerException(String message) {
		super(message);
		this.returnCode = ReturnCode.UNKNOWN_ERROR;
	}

	public WorkerException(Throwable cause) {
		super(cause);
		if (cause instanceof WorkerException) {
			this.returnCode = ((WorkerException) cause).getReturnCode();
		}
	}

	public ReturnCode getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(ReturnCode returnCode) {
		this.returnCode = returnCode;
	}

}
