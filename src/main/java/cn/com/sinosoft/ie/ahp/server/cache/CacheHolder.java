package cn.com.sinosoft.ie.ahp.server.cache;

import java.io.Serializable;
import java.net.URL;
import java.util.Arrays;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.app.AhpServerMain;

public class CacheHolder {
	private static final Logger logger = LoggerFactory.getLogger(CacheHolder.class);
	//CDA解析配置对象缓存
	private static final String CDA_MAPPER_CACHE="cdaMapperCache";
	
	private static CacheManager manager ;
	private static Cache cache ;
	
	public static void init(){
		URL url = AhpServerMain.class.getResource("/ehcache.xml");
		manager = CacheManager.newInstance(url);
		logger.debug("caches:{}",Arrays.asList(manager.getCacheNames()));
		cache = manager.getCache(CDA_MAPPER_CACHE);
	}
	public static void close(){
		manager.shutdown();
	}
	/*
	public static Map putIfAbset(String key,Map value){
		cache.putIfAbsent(new Element(key, value));
		return value;
	}
	*/
	public static Serializable get(String key){
		
		Element e = cache.get(key);
		if(e!=null){
			logger.debug("item found:{}",key);
			return e.getValue();
		}else{
			logger.debug("item not found:{}",key);
			String value = "demo";
			cache.putIfAbsent(new Element(key,value));
			return value;
		}
		
	}
	
}
