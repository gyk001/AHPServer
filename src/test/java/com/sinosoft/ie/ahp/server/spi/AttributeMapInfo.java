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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((attribute == null) ? 0 : attribute.hashCode());
		result = prime * result
				+ ((attributeCode == null) ? 0 : attributeCode.hashCode());
		result = prime * result
				+ ((attributePath == null) ? 0 : attributePath.hashCode());
		result = prime * result
				+ ((className == null) ? 0 : className.hashCode());
		result = prime * result + ((maintar == null) ? 0 : maintar.hashCode());
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
		AttributeMapInfo other = (AttributeMapInfo) obj;
		if (attribute == null) {
			if (other.attribute != null)
				return false;
		} else if (!attribute.equals(other.attribute))
			return false;
		if (attributeCode == null) {
			if (other.attributeCode != null)
				return false;
		} else if (!attributeCode.equals(other.attributeCode))
			return false;
		if (attributePath == null) {
			if (other.attributePath != null)
				return false;
		} else if (!attributePath.equals(other.attributePath))
			return false;
		if (className == null) {
			if (other.className != null)
				return false;
		} else if (!className.equals(other.className))
			return false;
		if (maintar == null) {
			if (other.maintar != null)
				return false;
		} else if (!maintar.equals(other.maintar))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "AttributeMapInfo [attribute=" + attribute + ", attributeCode="
				+ attributeCode + ", attributePath=" + attributePath
				+ ", maintar=" + maintar + ", className=" + className + "]";
	}
	
	
	
	
}
