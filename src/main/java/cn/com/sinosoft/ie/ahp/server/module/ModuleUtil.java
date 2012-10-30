package cn.com.sinosoft.ie.ahp.server.module;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.ServerConfig;

/**
 * @author <a href="gyk001@gmail.com">Guo Yukun</a>
 * @version 2012-10-30
 */
public class ModuleUtil {
	private static final Logger logger = LoggerFactory.getLogger(ModuleUtil.class);
	
	public static ModuleConfig makeModuleConfig(ServerConfig serverConfig, String moduleName) throws ModuleExecption{
		try {
			// 合成模块配置文件名
			String moduleConfFile = serverConfig.getModuleConfDir()
					+ moduleName + ".properties";
			// 读取模块配置文件
			Configuration moduleConfigProperties = new PropertiesConfiguration(
					moduleConfFile);
			// 取模块配置类
			String moduleConfClazz = moduleConfigProperties.getString(ModuleConfig.MC_CLAZZ_CONFIG, "");
			logger.debug("read file [{}],config class[{}]", moduleConfFile, moduleConfClazz);
			// 实例化模块配置类
			ModuleConfig moduleConfig = (ModuleConfig) Class
					.forName(moduleConfClazz).newInstance();
			// 初始化配置
			moduleConfig.init(moduleConfigProperties);
			return moduleConfig;
		} catch (ConfigurationException e) {
			ModuleExecption me = new ModuleExecption("[" + moduleName
					+ "]配置文件读取失败！", e);
			throw me;
		} catch (ClassNotFoundException e) {
			ModuleExecption me = new ModuleExecption("[" + moduleName
					+ "]配置类不存在！", e);
			throw me;
		} catch (Exception e) {
			ModuleExecption me = new ModuleExecption("[" + moduleName
					+ "]配置类实例化失败！", e);
			throw me;
		}
	}
	
	public static Module makeModule(ServerConfig serverConfig, String moduleName) throws ModuleExecption{
		try {
			// 合成模块配置文件名
			String moduleConfFile = serverConfig.getModuleConfDir()
					+ moduleName + ".properties";
			// 读取模块配置文件
			Configuration moduleConfigProperties = new PropertiesConfiguration(
					moduleConfFile);
			// 取模块配置类
			String moduleClazz = moduleConfigProperties.getString(ModuleConfig.MC_CLAZZ_MODULE, "");
			logger.debug("read file [{}], module class[{}]", moduleConfFile, moduleClazz);
			// 实例化模块配置类
			Module module = (Module) Class.forName(moduleClazz).newInstance();
			return module;
		} catch (ConfigurationException e) {
			ModuleExecption me = new ModuleExecption("[" + moduleName
					+ "]模块配置文件读取失败！", e);
			throw me;
		} catch (ClassNotFoundException e) {
			ModuleExecption me = new ModuleExecption("[" + moduleName
					+ "]模块类不存在！", e);
			throw me;
		} catch (Exception e) {
			ModuleExecption me = new ModuleExecption("[" + moduleName
					+ "]模块类实例化失败！", e);
			throw me;
		}
	}
}
