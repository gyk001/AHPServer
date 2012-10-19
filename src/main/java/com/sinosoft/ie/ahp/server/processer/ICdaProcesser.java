/**
 * 
 */
package com.sinosoft.ie.ahp.server.processer;

import com.sinosoft.ie.ahp.msg.ClientProperties;

/**
 * @author 郭玉昆(<a href="mailto:gyk001@gmail.com">gyk001@gmail.com</a>)
 * @version 2012-5-22
 *
 */
public interface ICdaProcesser {
	void process(String cda,String patientPersonId,String bussinessId,ClientProperties cp) throws CdaProcessException;
}
