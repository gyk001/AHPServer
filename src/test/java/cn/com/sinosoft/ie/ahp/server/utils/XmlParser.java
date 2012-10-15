package cn.com.sinosoft.ie.ahp.server.utils;

import java.io.StringReader;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class XmlParser {
	private static final Logger logger = LoggerFactory
			.getLogger(XmlParser.class);

	private static final XMLInputFactory factory = XMLInputFactory
			.newInstance();

	public static void parse(String input) throws XMLStreamException {
		logger.debug("parse");
		XMLStreamReader r = factory.createXMLStreamReader(new StringReader(input));
		try {
			int event = r.getEventType();
			while (true) {
				switch (event) {
				case XMLStreamConstants.START_DOCUMENT:
					logger.debug("Start Document.");
					break;
				case XMLStreamConstants.START_ELEMENT:
					logger.debug("Start Element: {}", r.getName());
					for (int i = 0, n = r.getAttributeCount(); i < n; ++i) {
						logger.debug("Attribute: {} = {}", r.getAttributeName(i), r.getAttributeValue(i));
					}
					break;
				case XMLStreamConstants.CHARACTERS:
					if (r.isWhiteSpace()) {
						break;
					}
					logger.debug("Text: {}", r.getText());
					break;
				case XMLStreamConstants.END_ELEMENT:
					logger.debug("End Element: {}", r.getName());
					break;
				case XMLStreamConstants.END_DOCUMENT:
					logger.debug("End Document.");
					break;
				}

				if (!r.hasNext())
					break;

				event = r.next();
			}
		} finally {
			r.close();
		}
	}
}
