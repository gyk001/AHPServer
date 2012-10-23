package cn.com.sinosoft.ie.ahp.server.service.cda;

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
import com.sinosoft.ie.ahp.server.spi.ClassMapInfo;
import com.sinosoft.ie.ahp.server.spi.CollectionMapInfo;
import com.sinosoft.ie.ahp.server.util.DateUtil;
import com.sun.org.apache.xml.internal.dtm.ref.DTMNodeList;

public class MapperCdaParser {
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

	public static Map<String, Object> parserCDA(final String cda,
			Map<String, Object> extObj) throws Exception {
		final Map<String, Object> map = new HashMap<String, Object>();
		final byte[] b = cda.getBytes("UTF-8");
		final ByteArrayInputStream bis = new ByteArrayInputStream(b);
		final Document doc = db.parse(bis);
		final Element rootNode = doc.getDocumentElement();
		final NodeList nodeList = rootNode.getElementsByTagName("templateId");
		Element templatteNode = (Element) nodeList.item(0);

		// 业务类型
		String bizType = templatteNode.getAttribute("extension");
		if(extObj!=null){
			extObj.put("bizType", bizType);
		}
		// 取得该业务类型对应的配置
		ClassMapInfo claaMapInf = MapperProvider.get(bizType);
		if (claaMapInf == null) {
			throw new NullPointerException("mapper不能为空！");
		}
		// 属性赋值
		foundAttributes(rootNode, claaMapInf.getAttributes(), map);
		for (ClassMapInfo classMapInfo : claaMapInf.getAtributeObjects()) {
			// 形成对象
			foundObject(rootNode, classMapInfo, map);
		}
		for (CollectionMapInfo mapInfo : claaMapInf.getAttributeListObjects()) {
			foundListObject(rootNode, mapInfo, map);
		}
		return map;
	}

	/**
	 * 
	 * @param node
	 *            属性所在的节点
	 * @param attributes
	 *            基本属性集合
	 * @throws Exception
	 */
	private static void foundAttributes(Node node,
			List<AttributeMapInfo> attributes, Map<String, Object> map)
			throws Exception {
		for (AttributeMapInfo mapInfo : attributes) {
			String xPath = mapInfo.getAttributePath();
			if (xPath == null || xPath.equals("")) {
				continue;
			}
			XPathExpression expr = xpath.compile(xPath);
			Object result = expr.evaluate(node);

			if (mapInfo.getClassName().equals("java.util.Date")) {
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
			map.put(mapInfo.getAttribute(), result);
		}
	}

	/**
	 * 
	 * @param 该集合所在xml对应的节点
	 * @param collectionMapInfo
	 *            该集合的信息
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private static void foundListObject(Node node,
			CollectionMapInfo collectionMapInfo, Map<String, Object> map)
			throws Exception {
		Map<String, Object> beanMap = new HashMap<String, Object>();
		XPathFactory factory = XPathFactory.newInstance();
		XPath xpath = factory.newXPath();
		Collection<Object> list = (Collection<Object>) collectionMapInfo
				.getListClass().newInstance();
		String listPath = collectionMapInfo.getListPath();
		XPathExpression expr = xpath.compile(listPath);
		DTMNodeList nodeSet = (DTMNodeList) expr.evaluate(node,
				XPathConstants.NODESET);

		for (int i = 0; i < nodeSet.getLength(); i++) {
			Node innerNode = nodeSet.item(i);
			foundInnerObject(innerNode, list,
					collectionMapInfo.getInnerObject(), beanMap);
		}

		// 把集合赋给目标对象
		map.put(collectionMapInfo.getListAttributeName(), list);
	}

	// 形成listde的object
	private static void foundInnerObject(Node node, Collection<Object> list,
			ClassMapInfo classMapInfo, Map<String, Object> map)
			throws Exception {
		Map<String, Object> beanMap = new HashMap<String, Object>();
		// 形成属性
		foundAttributes(node, classMapInfo.getAttributes(), beanMap);

		for (ClassMapInfo innerClassMapInfo : classMapInfo.getAtributeObjects()) {
			// 形成对象
			foundObject(node, innerClassMapInfo, map);
		}
		for (CollectionMapInfo mapInfo : classMapInfo.getAttributeListObjects()) {
			foundListObject(node, mapInfo, map);
		}
		list.add(beanMap);
	}

	/**
	 * 形成对象
	 * 
	 * @param node
	 * @param atributeObject
	 * @throws Exception
	 */
	private static void foundObject(Node node, ClassMapInfo atributeObject,
			Map<String, Object> map) throws Exception {
		Map<String, Object> beanMap = new HashMap<String, Object>();
		String clazzName = atributeObject.getAttributeName();

		foundAttributes(node, atributeObject.getAttributes(), beanMap);
		for (ClassMapInfo attributeObject : atributeObject.getAtributeObjects()) {
			foundObject(node, attributeObject, map);
		}
		for (CollectionMapInfo mapInfo : atributeObject
				.getAttributeListObjects()) {
			foundListObject(node, mapInfo, map);
		}
		// 把对象赋予目标对象
		map.put(clazzName, beanMap);
	}

}
