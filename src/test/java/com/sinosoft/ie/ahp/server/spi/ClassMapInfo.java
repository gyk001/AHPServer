package com.sinosoft.ie.ahp.server.spi;

import java.io.Serializable;
import java.util.List;

public class ClassMapInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5559205094686128365L;
	@SuppressWarnings("rawtypes")
	private Class clazz;
	private List<AttributeMapInfo> attributes;
	private List<ClassMapInfo> atributeObjects;
	private List<CollectionMapInfo> attributeListObjects;
	private String attributeName;
	
	
	public String getAttributeName() {
		return attributeName;
	}
	public void setAttributeName(String attributeName) {
		this.attributeName = attributeName;
	}
	@SuppressWarnings("rawtypes")
	public Class getClazz() {
		return clazz;
	}
	public void setClazz(@SuppressWarnings("rawtypes") Class clazz) {
		this.clazz = clazz;
	}
	public List<AttributeMapInfo> getAttributes() {
		return attributes;
	}
	public void setAttributes(List<AttributeMapInfo> attributes) {
		this.attributes = attributes;
	}
	public List<ClassMapInfo> getAtributeObjects() {
		return atributeObjects;
	}
	public void setAtributeObjects(List<ClassMapInfo> atributeObjects) {
		this.atributeObjects = atributeObjects;
	}
	public List<CollectionMapInfo> getAttributeListObjects() {
		return attributeListObjects;
	}
	public void setAttributeListObjects(List<CollectionMapInfo> attributeListObjects) {
		this.attributeListObjects = attributeListObjects;
	}
	
}
