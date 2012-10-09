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


	
	
	
	
	

}
