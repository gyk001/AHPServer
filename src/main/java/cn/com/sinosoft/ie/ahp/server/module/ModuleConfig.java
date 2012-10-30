package cn.com.sinosoft.ie.ahp.server.module;

import org.apache.commons.configuration.Configuration;

/**
 * @author <a href="gyk001@gmail.com">Guo Yukun</a>
 * @version 2012-10-30
 */
public interface ModuleConfig {
	public void init(Configuration config) throws ModuleExecption;
	public String getConfigClazz();
	public String getModuleClazz();
	
	public static final String MC_CLAZZ_MODULE="module";
	public static final String MC_CLAZZ_CONFIG="config";
}
