package cn.com.sinosoft.ie.ahp.server.service.impl;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import cn.com.sinosoft.ie.ahp.server.db.DBManager;
import cn.com.sinosoft.ie.ahp.server.service.BizPluginHandler;
import cn.com.sinosoft.ie.ahp.server.service.BizResult;
import cn.com.sinosoft.ie.ahp.server.service.BizResultCode;
import cn.com.sinosoft.ie.ahp.server.service.cda.MapperProvider;
import cn.com.sinosoft.ie.ahp.server.util.XmlReaderUtil;

public class OutpatientServiceImplTest {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(OutpatientServiceImplTest.class);
	private static final String demoDir = File.separator+"cda_for_biz_insert_test"+File.separator+
			"outpatient"+File.separator;

	@BeforeClass
	public void beforeClass() throws IOException {
		// 新解析器需要初始化这个
		MapperProvider.init();
		DBManager.initDataSource(null);
	}

	@AfterClass
	public void afterClass() {
		MapperProvider.destory();
	}
	
	@DataProvider(name = "outpatient-demos")
	public Object[][] dataValues() {
		URL url =OutpatientServiceImplTest.class.getResource(demoDir);
		String[] fnames = new File(url.getFile()).list();
		Object [][] res = new Object[fnames.length][];
		
		int i=0;
		for(String fname: fnames){
			String[] name = new String[]{fname};
			res[i++]=name;
		}
		return res;
	}

	/**
	 * 插入一万次
	 * @throws Exception 
	 */
	@Test(dataProvider="outpatient-demos")
	public void saveBizData(String demofiles) throws Exception {
		String xml = XmlReaderUtil.loadTestXml(demoDir+demofiles);
		assert (xml!=null && ! xml.isEmpty()):"加载示例xml文件错误";
		OutpatientServiceImpl  service = new OutpatientServiceImpl();
		service.init();
		//随机数
		service.setBizPluginHandler(new BizFieldpkRandomPluginHandler());
		for(int i=0;i<10000;i++){
			BizResult result = service.process(UUID.randomUUID().toString(), UUID.randomUUID().toString(), xml);
			if (! BizResultCode.SUCCESS.equals(result.getCode())){
				throw result.getException();
			}
		}
		service.destory();
	}

	@Test(enabled=false)
	public void saveCDA() {
		throw new RuntimeException("Test not implemented");
	}


}



//将业务主键修改为随机的UUID，否则会主键重复无法插入
class BizFieldpkRandomPluginHandler implements BizPluginHandler {
	
	@Override
	public void beforSaveCda(String bizId, String ppId, String cdaContent,
			Map<String, Object> bizData) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void beforSaveBizData(String bizId, String ppId, String cdaContent,
			Map<String, Object> bizData) throws Exception {
		if(bizData!=null){
			if(bizData.containsKey("FIELD_PK")){
				bizData.put("FIELD_PK", UUID.randomUUID().toString());
			}
			//if(bizData.containsKey(""))
		}
	}
	
	@Override
	public void beforReturnResult(String bizId, String ppId, String cdaContent,
			Map<String, Object> bizData, BizResult result) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void beforParseCda(String bizId, String ppId, String cdaContent)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void beforCommitAll(String bizId, String ppId, String cdaContent,
			Map<String, Object> bizData) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
