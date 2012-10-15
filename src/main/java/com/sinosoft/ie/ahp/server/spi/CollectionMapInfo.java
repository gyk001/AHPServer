package com.sinosoft.ie.ahp.server.spi;

import java.io.Serializable;

public class CollectionMapInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -350288984205597066L;

	
	@SuppressWarnings("rawtypes")
	private Class listClass;

	private String listAttributeName;
	
	private String listPath;
	
	@SuppressWarnings("rawtypes")
	public Class getListClass() {
		return listClass;
	}

	private  ClassMapInfo innerObject;

	public void setListClass(@SuppressWarnings("rawtypes") Class listClass) {
		this.listClass = listClass;
	}

	public String getListAttributeName() {
		return listAttributeName;
	}

	public void setListAttributeName(String listAttributeName) {
		this.listAttributeName = listAttributeName;
	}

	public String getListPath() {
		return listPath;
	}

	public void setListPath(String listPath) {
		this.listPath = listPath;
	}

	public ClassMapInfo getInnerObject() {
		return innerObject;
	}

	public void setInnerObject(ClassMapInfo innerObject) {
		this.innerObject = innerObject;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((innerObject == null) ? 0 : innerObject.hashCode());
		result = prime
				* result
				+ ((listAttributeName == null) ? 0 : listAttributeName
						.hashCode());
		result = prime * result
				+ ((listClass == null) ? 0 : listClass.hashCode());
		result = prime * result
				+ ((listPath == null) ? 0 : listPath.hashCode());
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
		CollectionMapInfo other = (CollectionMapInfo) obj;
		if (innerObject == null) {
			if (other.innerObject != null)
				return false;
		} else if (!innerObject.equals(other.innerObject))
			return false;
		if (listAttributeName == null) {
			if (other.listAttributeName != null)
				return false;
		} else if (!listAttributeName.equals(other.listAttributeName))
			return false;
		if (listClass == null) {
			if (other.listClass != null)
				return false;
		} else if (!listClass.equals(other.listClass))
			return false;
		if (listPath == null) {
			if (other.listPath != null)
				return false;
		} else if (!listPath.equals(other.listPath))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CollectionMapInfo [listClass=" + listClass
				+ ", listAttributeName=" + listAttributeName + ", listPath="
				+ listPath + ", innerObject=" + innerObject + "]";
	}


	
	
	
	
	

}
