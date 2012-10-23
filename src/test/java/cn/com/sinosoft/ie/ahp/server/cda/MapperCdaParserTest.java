package cn.com.sinosoft.ie.ahp.server.cda;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import cn.com.sinosoft.ie.ahp.server.service.cda.MapperCdaParser;
import cn.com.sinosoft.ie.ahp.server.service.cda.MapperProvider;
import cn.com.sinosoft.ie.ahp.server.util.XmlReaderUtil;

import com.sinosoft.ie.ahp.server.parser.CdaParser;
import com.sinosoft.ie.ahp.server.spi.ClassConfig;

public class MapperCdaParserTest {
	private static final Logger logger = LoggerFactory.getLogger(MapperCdaParserTest.class);
	private static final String demoDir = File.separator+"cda"+File.separator;
	@BeforeClass
	public void beforeClass() throws IOException {
		//新解析器需要初始化这个
		MapperProvider.init();
		//老解析器需要初始化这个
		ClassConfig.initClassConfig();
		
	}

	@AfterClass
	public void afterClass() {
		MapperProvider.destory();
	}

	
	@DataProvider(name = "cda-demos")
	public Object[][] dataValues() {
		URL url =MapperCdaParserTest.class.getResource(demoDir);
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
	 * 测试新旧解析器的解析结果是否一致<br/>
	 * 会测试/src/test/resources/cda文件夹下的所有文件
	 * @param demo
	 * @throws Exception
	 */
	@Test(dataProvider="cda-demos")
	public void parserCDA(String demo) throws Exception {
		String xmlContent = XmlReaderUtil.loadTestXml(demoDir+demo);
		//新解析器的解析结果
		Map<String, Object> old = MapperCdaParser.parserCDA(xmlContent,null);
		//旧解析器的解析结果
		Map<String, Object> newMap = CdaParser.parserCDA(xmlContent);
		
		//模拟不一致的情况
		//map2.put("FIELD_PK", "diffent");//都有键，但值不一样
		//map2.remove("FIELD_PK");  //键缺失
		//map2.put("_any_key_map1_not_contain_", "asfd"); //键多余

		//比较两个map是否一致
		for(Entry<String, Object> e : old.entrySet()) {
		    if (newMap.containsKey(e.getKey())) {
		        if (!newMap.get(e.getKey()).equals(e.getValue())) {
		        	assert false : "键["+e.getKey()+"]的值不一致:"+e.getValue()+" | "+newMap.get(e.getKey());
		        }
		    } else {
		    	assert false : "键["+e.getKey()+"]缺失:"+e.getValue();
		    }
		}
		newMap.keySet().removeAll(old.keySet());
		for (String e : newMap.keySet()) {
		    assert false : "键["+e+"]多余:"+newMap.get(e);
		}
	}
	
}
