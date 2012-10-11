package com.sinosoft.ie.ahp.server.parser;

import java.io.ByteArrayInputStream;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.sinosoft.ie.ahp.server.spi.AttributeMapInfo;
import com.sinosoft.ie.ahp.server.spi.ClassConfig;
import com.sinosoft.ie.ahp.server.spi.ClassMapInfo;
import com.sinosoft.ie.ahp.server.spi.CollectionMapInfo;
import com.sinosoft.ie.ahp.server.spi.EntityBean;
import com.sinosoft.ie.ahp.server.util.DateUtil;
import com.sun.org.apache.xml.internal.dtm.ref.DTMNodeList;

/**
 * 
*    
* @Description: cda 解析器和生成器   
* 
* 
*
*
* @Package com.sinosoft.ie.ahp.server.parser
* @author Liu yun fei  
* @version v1.0,2012-5-22
* @see	
* @since	v1.0

*
*
*
 */
public class CdaParser  {
	private static ClassMapInfo claaMapInf = ClassConfig.getClassMapInfo("RCMR_MT050101UV01");
	private static DocumentBuilder db;
	private static XPath xpath;
	static {

			try {
				db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
				xpath = XPathFactory.newInstance().newXPath();
			} catch (ParserConfigurationException e) {
				throw new RuntimeException(e);
			}

	}
	
	public static void confirmClasLoaded(){
		//do nothing
	}
	
	/**
	 * CDA解析成MAP
	 */
	public static Map<String,Object> parserCDA(String cda) throws Exception {
			Object entityBean = null;
			Map<String,Object> map = new HashMap<String, Object>();
			//String cdaTmp = new   String(cda.getBytes("UTF-8"), "UTF-8"); 
			byte[] b = cda.getBytes("UTF-8");
			ByteArrayInputStream bis = new ByteArrayInputStream(b);
			Document doc = db.parse(bis);
			Element rootNode = doc.getDocumentElement();
			NodeList nodeList=rootNode.getElementsByTagName("templateId");
			Element templatteNode=(Element) nodeList.item(0);
			String msgType=templatteNode.getAttribute("extension");
			//ClassConfig classConfig = new ClassConfig(msgType);
			//ClassMapInfo claaMapInf = ClassConfig.getClassMapInfo(msgType);
			
			//entityBean = (Object) claaMapInf.getClazz().newInstance();
			// 属性赋值
			foundAttributes(entityBean, rootNode, claaMapInf.getAttributes(),map);
			for (ClassMapInfo classMapInfo : claaMapInf.getAtributeObjects()) {
				// 形成对象
				foundObject(entityBean, rootNode, classMapInfo,map);
			}
			for (CollectionMapInfo mapInfo : claaMapInf.getAttributeListObjects()) {
				foundListObject(entityBean, rootNode, mapInfo,map);
			}
		return map;
	}

	/**
	 * 
	 * @param target
	 *            目标对象即属性的所属对象
	 * @param node
	 *            属性所在的节点
	 * @param attributes
	 *            基本属性集合
	 * @throws Exception
	 */
	private static void foundAttributes(Object target, Node node,List<AttributeMapInfo> attributes,Map<String,Object> map) throws Exception {
		for (AttributeMapInfo mapInfo : attributes) {
			String xPath = mapInfo.getAttributePath();
			if (xPath == null || xPath.equals("")) {
				continue;
			}
			XPathExpression expr = xpath.compile(xPath);
			Object result = expr.evaluate(node);
			
			if(mapInfo.getClassName().equals("java.util.Date")){
				String str = (String) result;
				if (!"".equals(str)) {
					Date date = null;
					if (str.length() > 10) {
						date = DateUtil.getDate(str, "yyyy-MM-dd HH:mm:ss");
					} else {
						date = DateUtil.getDate(str, "yyyy-MM-dd");
					}
					result = date;
				}
			} 
			map.put(mapInfo.getAttribute(),  result);
			/*PropertyDescriptor pd = new PropertyDescriptor(mapInfo.getAttribute(), target.getClass());
			Method method = pd.getWriteMethod();
			//判断类型是否为日期。如果为日期则转换类型。需要修改
			if(pd.getPropertyType().isAssignableFrom(Date.class )){
				String str = (String) result;
				if (!"".equals(str)) {
					Date date = DateUtil.getDate(str, "yyyy-MM-dd HH:mm:ss");
					method.invoke(target,  new Object[] { date });
				}
			} else if (pd.getPropertyType().isAssignableFrom(float.class)) {
				String str = (String) result;
				if (!"".equals(str)) {
					Float fl = Float.valueOf(str);
					method.invoke(target, new Object[] { fl });
				}
			} else if (pd.getPropertyType().isAssignableFrom(Long.class)) {
				String str = (String) result;
				if (!"".equals(str)) {
					Long lg = Long.valueOf(str);
					method.invoke(target, new Object[] { lg });
				}
			} else {
				method.invoke(target, new Object[] { result });
			}*/
			
			/*if ("".equals(result)) {
				System.out.println("***字段英文名称：" + mapInfo.getAttribute() + "  CDA文档位置："+ mapInfo.getAttributePath() + "字段值" + result);
			}*/
			
		}
	}

	/**
	 * 
	 * @param 目标对象
	 * @param 该集合所在xml对应的节点
	 * @param collectionMapInfo
	 *            该集合的信息
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private static void foundListObject(Object target, Node node,CollectionMapInfo collectionMapInfo,Map<String,Object> map) throws Exception {
		Map<String,Object> beanMap = new HashMap<String, Object>();
		XPathFactory factory = XPathFactory.newInstance();
		XPath xpath = factory.newXPath();
		Collection<Object> list = (Collection<Object>) collectionMapInfo.getListClass().newInstance();
		String listPath = collectionMapInfo.getListPath();
		XPathExpression expr = xpath.compile(listPath);
		DTMNodeList nodeSet = (DTMNodeList) expr.evaluate(node,XPathConstants.NODESET);

		for (int i = 0; i < nodeSet.getLength(); i++) {
			Node innerNode = nodeSet.item(i);
			foundInnerObject(innerNode, list, collectionMapInfo.getInnerObject(),beanMap);
		}

		// 把集合赋给目标对象
		map.put(collectionMapInfo.getListAttributeName(), list);
	}

	// 形成listde的object
	private static void foundInnerObject(Node node, Collection<Object> list,ClassMapInfo classMapInfo,Map<String,Object> map) throws Exception {
		Map<String,Object> beanMap = new HashMap<String, Object>();
		Object object = null;//classMapInfo.getClazz().newInstance();
		// 形成属性
		foundAttributes(object, node, classMapInfo.getAttributes(),beanMap);

		for (ClassMapInfo innerClassMapInfo : classMapInfo.getAtributeObjects()) {
			// 形成对象
			foundObject(object, node, innerClassMapInfo,map);
		}
		for (CollectionMapInfo mapInfo : classMapInfo.getAttributeListObjects()) {
			foundListObject(object, node, mapInfo,map);
		}
		list.add(beanMap);
	}
	/**
	 * 形成对象
	 * 
	 * @param target
	 * @param node
	 * @param atributeObject
	 * @throws Exception
	 */
	private static void foundObject(Object target, Node node,ClassMapInfo atributeObject,Map<String,Object> map) throws Exception {
		Map<String,Object> beanMap = new HashMap<String, Object>();
		String clazzName = atributeObject.getAttributeName();
		Object object = null;//atributeObject.getClazz().newInstance();

		foundAttributes(object, node, atributeObject.getAttributes(),beanMap);
		for (ClassMapInfo attributeObject : atributeObject.getAtributeObjects()) {
			foundObject(object, node, attributeObject,map);
		}
		for (CollectionMapInfo mapInfo : atributeObject.getAttributeListObjects()) {
			foundListObject(target, node, mapInfo,map);
		}
		// 把对象赋予目标对象
		map.put(clazzName, beanMap);
	}

	public String formCDA(EntityBean entityBean, String msgType) {
		return null;
	}


}
