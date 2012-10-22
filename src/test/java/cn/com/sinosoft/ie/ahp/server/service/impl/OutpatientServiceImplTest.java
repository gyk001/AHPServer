package cn.com.sinosoft.ie.ahp.server.service.impl;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import cn.com.sinosoft.ie.ahp.server.db.DBManager;
import cn.com.sinosoft.ie.ahp.server.service.BizResult;
import cn.com.sinosoft.ie.ahp.server.service.BizResultCode;
import cn.com.sinosoft.ie.ahp.server.service.IBizService;
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
		IBizService  service = new OutpatientServiceImpl();
		service.init();
		for(int i=0;i<10;i++){
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
