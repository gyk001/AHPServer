package cn.com.sinosoft.ie.ahp.server.module;

/**
 * @author <a href="gyk001@gmail.com">Guo Yukun</a>
 * @version 2012-10-30
 */
public class ModuleExecption extends Exception {
	private static final long serialVersionUID = -7220476885705445038L;

	public ModuleExecption() {
		super();
	}

	public ModuleExecption(String message, Throwable cause) {
		super(message, cause);
	}

	public ModuleExecption(String message) {
		super(message);
	}

	public ModuleExecption(Throwable cause) {
		super(cause);
	}

}
