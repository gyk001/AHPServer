package cn.com.sinosoft.ie.ahp.server.cda;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import cn.com.sinosoft.ie.ahp.server.service.cda.MapperProvider;

import com.sinosoft.ie.ahp.server.spi.ClassConfig;
import com.sinosoft.ie.ahp.server.spi.ClassMapInfo;

public class MapperProviderTest {
	private static final Logger logger = LoggerFactory.getLogger(MapperProviderTest.class);
	@BeforeClass
	public void beforeClass() {
		MapperProvider.init();
		ClassConfig.initClassConfig();
	}

	@AfterClass
	public void afterClass() {
		MapperProvider.destory();
	}

	@BeforeTest
	public void beforeTest() {
	}

	@AfterTest
	public void afterTest() {
	}

	@DataProvider(name = "cda-type")
	 public Object[][] dataValues(){
	  return new Object[][]{
			  {new String("PRPA_MT000101UV01")},
			  {new String("PRPA_MT000101UV01")},
			  {"RCMR_MT050101UV01"}
	  };
	 }

	@Test(dataProvider="cda-type")
	public void testGet(String msgType) {
		//原来的配置
		ClassMapInfo oldMap = ClassConfig.getClassMapInfo(msgType);
		//现在的配置
		ClassMapInfo newMap =  MapperProvider.get(msgType, "1");
		logger.trace("old:{}"+ oldMap);
		logger.trace("new:{}"+ newMap);
		assert newMap.equals( oldMap ): msgType+"配置结果和原来不一致！";
	}
	
}
