package cn.com.sinosoft.ie.ahp.server.service.cda;

import java.net.URL;
import java.util.Arrays;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import net.sf.ehcache.Status;

import org.dom4j.DocumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sinosoft.ie.ahp.server.spi.ClassMapInfo;

public class MapperProvider {
	//log对象
	private static final Logger logger = LoggerFactory
			.getLogger(MapperProvider.class);
	//初始化标志
	private static volatile boolean init = false;
	// CDA解析配置对象缓存
	private static final String CDA_MAPPER_CACHE = "cdaMapperCache";
	// 缓存管理器
	private static CacheManager manager;
	// Mapper缓存
	private static Cache cache;

	/**
	 * 初始化
	 */
	public static synchronized void init() {
		if (init == false) {
			URL url = MapperProvider.class.getResource("/ehcache.xml");
			manager = CacheManager.newInstance(url);
			logger.debug("caches:{}", Arrays.asList(manager.getCacheNames()));
			cache = manager.getCache(CDA_MAPPER_CACHE);
			init = true;
		}
	}

	/**
	 * 销毁 
	 */
	public static synchronized void destory() {
		if (manager != null && Status.STATUS_ALIVE.equals(manager.getStatus())) {
			manager.shutdown();
		}
	}

	public static ClassMapInfo get(String bizType) {
		return get(bizType, TypeVersionCdaKey.DEFALUT_VERSION);
	}

	public static ClassMapInfo get(String bizType, String version) {
		final TypeVersionCdaKey TypeVersionCdaKey = new TypeVersionCdaKey(bizType, version);
		final Element mapper = cache.get(TypeVersionCdaKey);
		if (mapper != null) {
			logger.debug("item found:{}", TypeVersionCdaKey);
			try {
				return ((ClassMapInfo) mapper.getValue());
			} catch (Exception e) {
				logger.warn("get mapper exception", e);
				return null;
			}
		} else {
			logger.debug("item not found:{}", TypeVersionCdaKey);
			ClassMapInfo a = loadMapper(TypeVersionCdaKey);
			cache.putIfAbsent(new Element(TypeVersionCdaKey, a));
			return a;
		}
	}

	private static ClassMapInfo loadMapper(TypeVersionCdaKey TypeVersionCdaKey) {
		try {
			return MapLoader.loadMapper(TypeVersionCdaKey.getBizType(),
					TypeVersionCdaKey.getVersion());
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

