package cn.com.sinosoft.ie.ahp.server.cda;

import java.io.Serializable;
import java.net.URL;
import java.util.Arrays;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.dom4j.DocumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
		URL url = MapperProvider.class.getResource("/ehcache.xml");
		manager = CacheManager.newInstance(url);
		logger.debug("caches:{}",Arrays.asList(manager.getCacheNames()));
		cache = manager.getCache(CDA_MAPPER_CACHE);
	}
	
	public static void destory(){
		manager.shutdown();
	}
	
	public static ClassMapInfo get(String bizType){
		return get(bizType,CdaKey.DEFALUT_VERSION);
	}
	
	public static ClassMapInfo get(String bizType, String version){
		final CdaKey cdaKey = new CdaKey(bizType, version);
		final Element mapper = cache.get( cdaKey );
		if(mapper!=null){
			logger.debug("item found:{}", cdaKey);
			try{
				return ((ClassMapInfo) mapper.getValue());
			}catch(Exception e){
				logger.warn("get mapper exception", e);
				return null;
			}
		}else{
			logger.debug("item not found:{}",cdaKey);
			ClassMapInfo a = loadMapper( cdaKey );
			cache.putIfAbsent(new Element(cdaKey, a));
			return a;
		}
	}
	
	private static ClassMapInfo loadMapper(CdaKey cdaKey){
		try {
			return MapLoader.loadMapper(cdaKey.getBizType(), cdaKey.getVersion());
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

class CdaKey implements Serializable{
	private static final long serialVersionUID = -1816346477055816208L;
	//默认版本号，因为CDA没有，认为是版本1
	public static final String DEFALUT_VERSION="1";
	//业务类型(如:PRPA_MT000101UV01)
	private String bizType ;
	//CDA版本
	private String version ;
	
	public CdaKey() {
		super();
		this.version = DEFALUT_VERSION;
	}
	
	public CdaKey(String bizType) {
		super();
		this.version = DEFALUT_VERSION;
		this.bizType = bizType;
	}

	public CdaKey(String bizType, String version) {
		super();
		this.bizType = bizType;
		this.version = version;
	}



	public String getBizType() {
		return bizType;
	}
	public void setBizType(String bizType) {
		this.bizType = bizType;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bizType == null) ? 0 : bizType.hashCode());
		result = prime * result + ((version == null) ? 0 : version.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CdaKey other = (CdaKey) obj;
		if (bizType == null) {
			if (other.bizType != null)
				return false;
		} else if (!bizType.equals(other.bizType))
			return false;
		if (version == null) {
			if (other.version != null)
				return false;
		} else if (!version.equals(other.version))
			return false;
		return true;
	}
	
}
