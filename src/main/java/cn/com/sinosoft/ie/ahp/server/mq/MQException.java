package cn.com.sinosoft.ie.ahp.server.mq;

/**
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-29
 *
 */
public class MQException extends Exception {
	private static final long serialVersionUID = -2123310551939272377L;

	public MQException() {
		super();
	}

	public MQException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public MQException(String arg0) {
		super(arg0);
	}

	public MQException(Throwable arg0) {
		super(arg0);
	}

}
