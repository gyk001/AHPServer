package cn.com.sinosoft.ie.ahp.server.module;


/**
 * @author <a href="gyk001@gmail.com">Guo Yukun</a>
 * @version 2012-10-30
 */
public interface Module {
	
	public void init(ModuleConfig config) throws ModuleExecption;

	public void start(ModuleConfig config) throws ModuleExecption;

	public void shutdown() throws ModuleExecption;

	public ModuleStatus getModuleStatus() throws ModuleExecption;
}
