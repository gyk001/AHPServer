package com.sinosoft.ie.ahp.server.spi;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

@SuppressWarnings("unchecked")
public class ClassConfig {
	public static Map<String, ClassMapInfo> classMapInfos = new HashMap<String, ClassMapInfo>();

	public static void initClassConfig() {
		try {
			// 读取CDA解析配置map.xml文件
			SAXReader reader = new SAXReader();
			InputStream inputStream = ClassConfig.class.getClassLoader()
					.getResourceAsStream("map.xml");
			Document document = reader.read(inputStream);
			Element root = document.getRootElement();
			List<Element> tables = root.elements();
			// 遍历map.xml里所以的
			for (Element table : tables) {
				String[] msgTypeArr = null;
				// if(table.attributeValue("name").equals(msgType)){
				// 取得map.xml中某个节点的include属性，放到数组msgTypeArr中
				msgTypeArr = (table.attributeValue("id") + "," + table
						.attributeValue("include")).split(",");
				// }
				if (msgTypeArr != null) {
					if (msgTypeArr.length > 0) {
						for (String str : msgTypeArr) {
							// 只有include中包含的对象才进行类创建操作
							if (table.attributeValue("id").equals(str)) {
								ClassMapInfo claaMapInfo = new ClassMapInfo();
								//claaMapInfo.setClazz(Class.forName(table.attributeValue("class")));
								// 属性
								claaMapInfo.setAttributes(getAttriubteMapInfos(table));
								// 解析object
								List<Element> objects = table.elements("object");
								foundObjects(claaMapInfo, objects);
								// 解析list
								List<Element> lists = table.elements("list");
								foundLists(claaMapInfo, lists);
								classMapInfos.put(table.attributeValue("name"), claaMapInfo);
							}
						}
					}
				}
			}
		} catch (Exception e) {
			System.out.println("读map.xml异常!");
			e.printStackTrace();
		}
		System.out.println("读取map.xml完毕!");
	}

	/*
	 * public ClassConfig(String msgType){ try{ //读取CDA解析配置map.xml文件 SAXReader
	 * reader = new SAXReader(); InputStream inputStream =
	 * ClassConfig.class.getClassLoader().getResourceAsStream("map.xml");
	 * Document document = reader.read(inputStream); Element root =
	 * document.getRootElement(); List<Element> tables = root.elements();
	 * //遍历map.xml里所以的 for(Element table:tables){ String[] msgTypeArr = null;
	 * if(table.attributeValue("name").equals(msgType)){
	 * //取得map.xml中某个节点的include属性，放到数组msgTypeArr中 msgTypeArr =
	 * (table.attributeValue("id") + "," +
	 * table.attributeValue("include")).split(","); } if(msgTypeArr!=null){
	 * if(msgTypeArr.length>0){ for(String str : msgTypeArr){
	 * //只有include中包含的对象才进行类创建操作 if(table.attributeValue("id").equals(str)){
	 * ClassMapInfo claaMapInfo=new ClassMapInfo();
	 * claaMapInfo.setClazz(Class.forName(table.attributeValue("class"))); //属性
	 * claaMapInfo.setAttributes(getAttriubteMapInfos(table)); //解析object
	 * List<Element> objects=table.elements("object");
	 * foundObjects(claaMapInfo,objects);
	 * 
	 * //解析list List<Element> lists=table.elements("list");
	 * foundLists(claaMapInfo,lists);
	 * 
	 * classMapInfos.put(table.attributeValue("name"),claaMapInfo); } } } } } }
	 * catch (Exception e) { e.printStackTrace(); } }
	 */
	public static ClassMapInfo getClassMapInfo(String msgType) {
		return classMapInfos.get(msgType);
	}

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
