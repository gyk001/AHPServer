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

	public void setAttributeListObjects(
			List<CollectionMapInfo> attributeListObjects) {
		this.attributeListObjects = attributeListObjects;
	}

	@Override
	public String toString() {
		return "ClassMapInfo [clazz=" + clazz + ", attributes=" + attributes
				+ ", atributeObjects=" + atributeObjects
				+ ", attributeListObjects=" + attributeListObjects
				+ ", attributeName=" + attributeName + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((atributeObjects == null) ? 0 : atributeObjects.hashCode());
		result = prime
				* result
				+ ((attributeListObjects == null) ? 0 : attributeListObjects
						.hashCode());
		result = prime * result
				+ ((attributeName == null) ? 0 : attributeName.hashCode());
		result = prime * result
				+ ((attributes == null) ? 0 : attributes.hashCode());
		result = prime * result + ((clazz == null) ? 0 : clazz.hashCode());
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
		ClassMapInfo other = (ClassMapInfo) obj;
		if (atributeObjects == null) {
			if (other.atributeObjects != null)
				return false;
		} else if (!atributeObjects.equals(other.atributeObjects))
			return false;
		if (attributeListObjects == null) {
			if (other.attributeListObjects != null)
				return false;
		} else if (!attributeListObjects.equals(other.attributeListObjects))
			return false;
		if (attributeName == null) {
			if (other.attributeName != null)
				return false;
		} else if (!attributeName.equals(other.attributeName))
			return false;
		if (attributes == null) {
			if (other.attributes != null)
				return false;
		} else if (!attributes.equals(other.attributes))
			return false;
		if (clazz == null) {
			if (other.clazz != null)
				return false;
		} else if (!clazz.equals(other.clazz))
			return false;
		return true;
	}

}
