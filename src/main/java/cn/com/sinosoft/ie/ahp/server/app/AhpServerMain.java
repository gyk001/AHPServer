package cn.com.sinosoft.ie.ahp.server.app;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.cache.CacheHolder;

public class AhpServerMain {
	private static final Logger logger = LoggerFactory.getLogger(AhpServerMain.class);

	public static void main(String[] args) throws InterruptedException {
		logger.info("======= start ======");
		CacheHolder.init();
		logger.debug("{}", CacheHolder.get("xxx"));
		logger.debug("{}", CacheHolder.get("xx"));
		logger.debug("{}", CacheHolder.get("xxx"));
		logger.debug("{}", CacheHolder.get("xx"));
		Thread.sleep(5000);
		logger.debug("{}", CacheHolder.get("xx"));
		CacheHolder.close();
		logger.info("=======  end  ======");
	}

}
