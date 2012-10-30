package cn.com.sinosoft.ie.ahp.server.module.mq;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import jodd.mail.MailException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.module.Module;
import cn.com.sinosoft.ie.ahp.server.module.ModuleConfig;
import cn.com.sinosoft.ie.ahp.server.module.ModuleExecption;
import cn.com.sinosoft.ie.ahp.server.module.ModuleStatus;
import cn.com.sinosoft.ie.ahp.server.worker.IWorker;
import cn.com.sinosoft.ie.ahp.server.worker.WorkerConfig;

/**
 * @author <a href="gyk001@gmail.com">Guo Yukun</a>
 * @version 2012-10-30
 */
public class ModuleMQ implements Module{
	private static final Logger logger = LoggerFactory.getLogger(ModuleMQ.class);
	private static final String BASE_CFG_NAME = "base";

	@Override
	public void init(ModuleConfig config) throws ModuleExecption {
		if( config instanceof ModuleMQConfig){
			doInit((ModuleMQConfig)config );
		}else{
			throw new MailException("unknown config class!");
		}
	}

	@Override
	public void start(ModuleConfig config) throws ModuleExecption {
		// TODO Auto-generated method stub
		logger.info("++++++++++++++++++++++");
		
	}

	@Override
	public void shutdown() throws ModuleExecption {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ModuleStatus getModuleStatus() throws ModuleExecption {
		// TODO Auto-generated method stub
		return null;
	}
	
	private void doInit(ModuleMQConfig config) throws ModuleExecption{
		Map<String, WorkerConfig> workerConfigs = config.getWorkersConfigMap(); 
		Iterator<Entry<String, WorkerConfig>> ite= workerConfigs.entrySet().iterator();
		while(ite.hasNext()){
			Entry<String,WorkerConfig> workerEntry = ite.next();
			String workerPrefix = workerEntry.getKey();
			if(BASE_CFG_NAME.equals(workerPrefix)){
				//模板配置，不生成实际的工作者
				continue;
			}
			WorkerConfig wc = workerEntry.getValue();
			String clazz = wc.getClazz();
			if(clazz==null || clazz.isEmpty()){
				throw new ModuleExecption("no clazz def for config: "+wc.getNamePrefix());
			}
			for(int i=0; i<wc.getThread(); i++){
				Object obj=null;
				try {
					obj = Class.forName(clazz).newInstance();
				} catch (Exception e) {
					new ModuleExecption(wc.getClazz()+" get instance exception!",e);
				}
				if(! (obj instanceof IWorker)){
					throw new ModuleExecption(wc.getClazz()+" not a IWorker instance!");
				}
				IWorker worker = (IWorker)obj;
				worker.wkInit(wc);
				worker.wkStart();
			}
		}
	}
}
