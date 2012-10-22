package cn.com.sinosoft.ie.ahp.server.service;

public interface IBizService {
	public BizResult process(String bizId, String ppId, String cdaContent);
	public void init();
	public void destory();
}
