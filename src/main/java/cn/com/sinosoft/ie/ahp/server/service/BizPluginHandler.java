package cn.com.sinosoft.ie.ahp.server.service;

import java.util.Map;

public interface BizPluginHandler {
	public void beforParseCda(String bizId, String ppId, String cdaContent) throws Exception;
	public void beforSaveBizData(String bizId, String ppId, String cdaContent, Map<String,Object> bizData) throws Exception;
	public void beforSaveCda(String bizId, String ppId, String cdaContent, Map<String,Object> bizData) throws Exception;
	public void beforCommitAll(String bizId, String ppId, String cdaContent, Map<String,Object> bizData) throws Exception;
	public void beforReturnResult(String bizId, String ppId, String cdaContent, Map<String,Object> bizData,BizResult result) ;
	@Override
	public boolean equals(Object obj);
	@Override
	public int hashCode();
}
