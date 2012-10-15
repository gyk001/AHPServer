package cn.com.sinosoft.ie.ahp.server.cda;

import java.net.URL;
import java.util.Arrays;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.dom4j.DocumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.app.AhpServerMain;

import com.sinosoft.ie.ahp.server.spi.ClassMapInfo;

public class MapperProvider {
	private static final Logger logger = LoggerFactory.getLogger(MapperProvider.class);
	//CDA解析配置对象缓存
	private static final String CDA_MAPPER_CACHE="cdaMapperCache";
	//缓存管理器
	private static CacheManager manager ;
	//Mapper缓存
	private static Cache cache ;
	
	
	public static void init(){
		URL url = AhpServerMain.class.getResource("/ehcache.xml");
		manager = CacheManager.newInstance(url);
		logger.debug("caches:{}",Arrays.asList(manager.getCacheNames()));
		cache = manager.getCache(CDA_MAPPER_CACHE);
	}
	
	public static void destory(){
		manager.shutdown();
	}
	
	public static ClassMapInfo get(String bizType, String version){
		
		final Element mapper = cache.get(bizType);
		if(mapper!=null){
			logger.debug("item found:{}",bizType);
			try{
				return ((ClassMapInfo) mapper.getValue());
			}catch(Exception e){
				logger.warn("get mapper exception", e);
				return null;
			}
		}else{
			logger.debug("item not found:{}",bizType);
			ClassMapInfo a = loadMapper( bizType, version );// ClassConfig.getClassMapInfo("RCMR_MT050101UV01");
			cache.putIfAbsent(new Element(bizType,a));
			return a;
		}
	}
	
	private static ClassMapInfo loadMapper(String type, String version){
		try {
			return MapLoader.loadMapper(type, version);
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
}
