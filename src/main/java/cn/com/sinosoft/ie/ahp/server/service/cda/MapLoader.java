package cn.com.sinosoft.ie.ahp.server.service.cda;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sinosoft.ie.ahp.server.spi.AttributeMapInfo;
import com.sinosoft.ie.ahp.server.spi.ClassMapInfo;
import com.sinosoft.ie.ahp.server.spi.CollectionMapInfo;

public class MapLoader {
	private static final Logger logger = LoggerFactory.getLogger(MapLoader.class);
	//map.xml文件路径前缀(/mapper/)
	private static final String MAPPER_PREFIX= File.separator+ "mapper"+ File.separator ;
	//解析器实例
	private static final SAXReader saxReader = new SAXReader();

	public static ClassMapInfo loadMapper(final String type, final String version) throws Exception{
		logger.debug("begin load mapper type [{}] version [{}]",type,version);
		// 取得 map.xml 文件路径
		final String mapFile = MAPPER_PREFIX + type + File.separator + version + ".xml";
		// 取得输入流
		InputStream inputStream = MapLoader.class.getResourceAsStream(mapFile);
		// 文件不存在返回null
		if(inputStream==null){
			logger.debug("[{}] not exist, return null", mapFile);
			return null;
		}
		//重置解析器状态
		saxReader.resetHandlers();
		//解析文档对象
		Document document = saxReader.read(inputStream);
		//取得根源素，即一个业务配置
		Element bizElement = document.getRootElement();
		ClassMapInfo claaMapInfo = new ClassMapInfo();
		//claaMapInfo.setClazz(Class.forName(table.attributeValue("class")));
		// 属性
		claaMapInfo.setAttributes(getAttriubteMapInfos(bizElement));
		// 解析object
		List<Element> objects = bizElement.elements("object");
		foundObjects(claaMapInfo, objects);
		// 解析list
		List<Element> lists = bizElement.elements("list");
		foundLists(claaMapInfo, lists);
		return claaMapInfo;
	}
	
	//===============================================
	private static void foundLists(ClassMapInfo claaMapInfo, List<Element> lists)
			throws Exception {
		List<CollectionMapInfo> infos = new ArrayList<CollectionMapInfo>(0);
		if (lists == null || lists.size() == 0) {

		} else {
			for (Element ele : lists) {
				CollectionMapInfo mapInfo = new CollectionMapInfo();
				mapInfo.setListAttributeName(ele.attributeValue("attribute"));
				mapInfo.setListClass(Class.forName(ele.attributeValue("class")));
				mapInfo.setListPath(ele.attributeValue("attributePath"));
				Element element = ele.element("innerObject");
				ClassMapInfo innObject = new ClassMapInfo();
				//innObject.setClazz(Class.forName(element
				//		.attributeValue("class")));
				innObject.setAttributes(getAttriubteMapInfos(element));
				// 子对象设置主对像
				// innObject.setClassMapInfo(claaMapInfo);

				List<Element> objects = element.elements("object");
				foundObjects(innObject, objects);
				// 解析list
				List<Element> innerLists = element.elements("list");
				foundLists(innObject, innerLists);
				mapInfo.setInnerObject(innObject);
				infos.add(mapInfo);
			}
		}
		claaMapInfo.setAttributeListObjects(infos);
	}

	public static void foundObjects(ClassMapInfo classMapInfo,
			List<Element> objects) throws Exception {
		List<ClassMapInfo> infos = new ArrayList<ClassMapInfo>(0);
		if (objects == null || objects.size() == 0) {

		} else {
			for (Element element : objects) {
				ClassMapInfo subClassMapInfo = new ClassMapInfo();
				//subClassMapInfo.setClazz(Class.forName(element
				//		.attributeValue("class")));
				subClassMapInfo.setAttributeName(element
						.attributeValue("attribute"));
				subClassMapInfo.setAttributes(getAttriubteMapInfos(element));
				foundObjects(subClassMapInfo, element.elements("object"));
				foundLists(subClassMapInfo, element.elements("list"));
				infos.add(subClassMapInfo);
			}
		}
		classMapInfo.setAtributeObjects(infos);
	}

	// 得到该节点下的所有属性
	private static List<AttributeMapInfo> getAttriubteMapInfos(Element elment) {
		List<AttributeMapInfo> attributeMaps = new ArrayList<AttributeMapInfo>(
				0);
		List<Element> attributes = elment.elements("column");
		for (Element attribute : attributes) {
			AttributeMapInfo mapInfo = new AttributeMapInfo();
			mapInfo.setAttribute(attribute.attributeValue("attribute"));
			mapInfo.setAttributeCode(attribute.attributeValue("attributeCode"));
			mapInfo.setAttributePath(attribute.attributeValue("attributePath"));
			if (attribute.attributeValue("class") != null) {
				mapInfo.setClassName(attribute.attributeValue("class"));
			} else {
				mapInfo.setClassName("java.lang.String");
			}
			attributeMaps.add(mapInfo);
		}
		return attributeMaps;
	}
}
