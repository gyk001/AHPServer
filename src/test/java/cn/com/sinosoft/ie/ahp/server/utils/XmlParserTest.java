package cn.com.sinosoft.ie.ahp.server.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

import javax.xml.stream.XMLStreamException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.sinosoft.ie.ahp.server.parser.CdaParser;
import com.sinosoft.ie.ahp.server.spi.ClassConfig;

public class XmlParserTest {
	private static final Logger logger = LoggerFactory
			.getLogger(XmlParserTest.class);
	private static final String testXml = "/outpatient_demo.xml";
	private static final int testRepeatTime = 10000;
	private static String xmlContent = null;

	@BeforeClass
	public void beforeClass() throws IOException {
		logger.debug("beforeClass");

		InputStream input = XmlParserTest.class.getResourceAsStream(testXml);

		BufferedReader bf = new BufferedReader(new InputStreamReader(input));
		StringBuilder sb = new StringBuilder();
		String content = "";
		while (content != null) {
			content = bf.readLine();
			if (content == null) {
				break;
			}
			sb.append(content.trim()).append(
					System.getProperty("line.separator"));
		}

		bf.close();
		xmlContent = sb.toString();

		ClassConfig.initClassConfig();
		//CdaParser.confirmClasLoaded();
	}
	private double calcAvgTime(long startTime, long endTime) {
		return ((endTime - startTime) / Math.pow(10, 6) / testRepeatTime);
	}
	
	
	// =================================================

	@Test(enabled=false)
	public void testOldCdaParser() throws Exception {
		long startTime = System.nanoTime();
		Map<String, Object> map = null;
		for (int i = 0; i < testRepeatTime; i++) {
			map = (Map<String, Object>) CdaParser.parserCDA(xmlContent);
		}
		logger.info("{} 平均耗时：{} ms", "testOldCdaParser",calcAvgTime(startTime, System.nanoTime()));
	}

	// =================================================

	@Test(enabled=false)
	public void testSingleThreadStAX() throws XMLStreamException {
		long startTime = System.nanoTime(); // 获取开始时间
		for (int i = 0; i < testRepeatTime; i++) {
			XmlParser.parse(xmlContent);
		}
		logger.info("{} 个平均耗时：{} ms", "testSingleThreadStAX",
				calcAvgTime(startTime, System.nanoTime()));
	}

	// =================================================
	@Test(enabled=false)
	public void testMutiThreadStAX() {
		ExecutorService executor = Executors.newFixedThreadPool(100);// .newCachedThreadPool();
		int waitTime = 20;
		long startTime = System.nanoTime(); // 获取开始时间
		Future future1 = null;
		for (int i = 0; i < testRepeatTime; i++) {
			future1 = executor.submit(new StAXParseCallable());
		}
		try {
			Thread.sleep(waitTime);
			executor.shutdown();
			executor.awaitTermination(waitTime, TimeUnit.MILLISECONDS);
		} catch (InterruptedException ignored) {
		}
		logger.info("{} 平均耗时：{} ms", "testMutiThreadStAX",
				calcAvgTime(startTime, System.nanoTime()));
	}

	class StAXParseCallable implements Callable {

		@Override
		public Object call() throws Exception {
			// TODO Auto-generated method stub
			// logger.info("parse");
			//XmlParser.parse(xmlContent);
			return 1;
		}

	}

	// =================================================
	@Test(enabled=false)
	public void testSingleThreadVTD() throws Exception {
		long startTime = System.nanoTime(); // 获取开始时间
		for (int i = 0; i < testRepeatTime; i++) {
			VTDXmlParser.parse(xmlContent);
		}
		logger.info("{} 平均耗时：{} ms", "testSingleThreadVTD",
				calcAvgTime(startTime, System.nanoTime()));
	}

	// =================================================
	@Test(enabled=false)
	public void testMutiThreadVTD() {
		ExecutorService executor = Executors.newFixedThreadPool(100);// .newCachedThreadPool();
		int waitTime = 20;
		long startTime = System.nanoTime(); // 获取开始时间
		Future future1 = null;
		for (int i = 0; i < testRepeatTime; i++) {
			future1 = executor.submit(new VTDParseCallable());
		}
		try {
			Thread.sleep(waitTime);
			executor.shutdown();
			executor.awaitTermination(waitTime, TimeUnit.MILLISECONDS);
		} catch (InterruptedException ignored) {
		}
		logger.info("{} 平均耗时：{} ms", "testMutiThreadVTD",
				calcAvgTime(startTime, System.nanoTime()));
	}

	class VTDParseCallable implements Callable {

		@Override
		public Object call() throws Exception {
			VTDXmlParser.parse(xmlContent);
			return 1;
		}

	}
	
	
	
}
