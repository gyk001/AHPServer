package com.sinosoft.ie.ahp.server.util;
/**
 * @version 1.0
 * @author lyf
 * @see OrgCode 
 */
public class OrgUtil {
	
	/**
	 * 医院的code
	 */
	public final static String HDYYCODE = "400880246";//海淀医院
	public final static String ZGCYYCODE = "400880123";//中关村医院
	public final static String HDFYCODE = "400880190";//中关村医院
	/**
	 * 业务字典
	 */
	public final static String ABSTRACTPATIENT="0";//患者
	public final static String ABSTRACTOUTPATIENT = "1";// 门诊
	// public final static String ABSTRACTOUTPATIENT="2";//高血压
	// public final static String ABSTRACTOUTPATIENT="3";//糖尿病
	public final static String ABSTRACTEHRPEXAMREG="4";//成人体检
	public final static String ABSTRACTEHRINHOSFIR="5";//住院
	/**
	 * 匹配类型
	 */
	public final static String IDCARD = "1";// 身份证匹配
	public final static String MEDICALID = "2";// 医保号匹配
	public final static String NAMEGENDER = "3";// 姓名，性别，出生日期匹配
	public final static String NAMEMEMARY = "4";// 姓名，出生日期（疑似匹配）
	public final static String HRID = "4";//健康档案号匹配
	/**
	 * 处理类型
	 */
	public final static String MATCH = "1";//  匹配
	public final static String REVISE = "2";// 修订
	/**
	 * 处理方式
	 */
	public final static String AUTOANNEXATION   = "1";//  自动合并
	public final static String ARTIANNEXATION   = "2";//  人工合并
	public final static String AUTONEW = "3";			//  自动新建
	public final static String ARTINEW = "4";			//  人工新建
	public final static String AUTOSPLIT = "5";			//  自动拆分
	public final static String ARTISPLIT = "6";			//  人工拆分
	
}
