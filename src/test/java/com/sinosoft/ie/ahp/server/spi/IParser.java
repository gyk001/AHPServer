package com.sinosoft.ie.ahp.server.spi;

import java.util.Map;


/**
 * 
*    
* @Description: cda操作。 解析器以及生成器    
* 
* 
*
* 
* @Package com.sinosoft.ie.hl.spi 
* @author Qin Shouxin  
* @version v1.0,2011-4-11
* @see	
* @since	（可选）	
* @deprecated（可选）
*
*
*
 */
public interface IParser {
	/**
	 * 解析cda
	 * @param cda  cda文本
	 * @return
	 * @throws Exception 
	 */
	public  Map<String, java.lang.Object> parserCDA(String cda) throws Exception;
	/**
	 * 生成cda
	 * @param entityBean  需要持久化的类型
	 * @param msgType  需要生成cda的消息类型
	 * @return
	 */
	public String formCDA(EntityBean entityBean, String msgType);
	
	
}
