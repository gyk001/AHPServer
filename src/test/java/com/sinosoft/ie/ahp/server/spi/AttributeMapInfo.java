package com.sinosoft.ie.ahp.server.spi;

import java.io.Serializable;


public class AttributeMapInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -156724454768936759L;
	private String attribute;
	private String attributeCode;
	private String attributePath;
	// lyf: Obj 主表作为一个属性
	private Object maintar;
	
	// 字段类型名称
	private String className;
	
	public Object getMaintar() {
		return maintar;
	}
	public void setMaintar(Object maintar) {
		this.maintar = maintar;
	}
	public String getAttribute() {
		return attribute;
	}
	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	public String getAttributeCode() {
		return attributeCode;
	}
	public void setAttributeCode(String attributeCode) {
		this.attributeCode = attributeCode;
	}
	public String getAttributePath() {
		return attributePath;
	}
	public void setAttributePath(String attributePath) {
		this.attributePath = attributePath;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	
	
	
	
}
