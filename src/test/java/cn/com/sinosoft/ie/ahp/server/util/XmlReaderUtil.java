package cn.com.sinosoft.ie.ahp.server.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class XmlReaderUtil {
	private static final Logger logger = LoggerFactory.getLogger(XmlReaderUtil.class);
	
	/**
	 * 返回demoFile的文件内容为字符串
	 * @param demoFile
	 * @return
	 * @throws IOException
	 */
	public static String loadTestXml(String demoFile) throws IOException{
		
		//样例xml
		InputStream input = XmlReaderUtil.class.getResourceAsStream(demoFile);

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
		//logger.trace("load xml {}:[{}]",demoFile,sb);
		return sb.toString();
	}
}
