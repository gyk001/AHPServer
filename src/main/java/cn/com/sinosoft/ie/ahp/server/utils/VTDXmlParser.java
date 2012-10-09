package cn.com.sinosoft.ie.ahp.server.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ximpleware.AutoPilot;
import com.ximpleware.VTDGen;
import com.ximpleware.VTDNav;

public class VTDXmlParser {
	private static final Logger logger = LoggerFactory
			.getLogger(VTDXmlParser.class);

	public static void parse(String input) throws Exception {
		logger.debug("parse");
		VTDGen vg = new VTDGen();
		vg.setDoc(input.getBytes());
		vg.parse(true);
		VTDNav vn = vg.getNav();
		int i;
		AutoPilot ap = new AutoPilot();
		// ap.declareXPathNameSpace("ns1", "someURL");
		ap.selectXPath("/ClinicalDocument/author/assignedAuthor/assignedAuthoringDevice/id[@root='HR99.01.166']/@extension");
		ap.bind(vn);
		// AutoPilot moves the cursor for you, as it returns the index value
		// of the qualified node
		while ((i = ap.evalXPath()) != -1) {
			// notice that i always is equal to vn.getCurrentIndex()!!!
			System.out.println("the text node index val is " + i + " the text string ==>" + vn.toString(i)); // below is equivalent to
			// vn's cursor is what gets moved by AutoPilot here
			System.out.println("the text node index val is " + i + " the text string ==>" + vn.toString(vn.getCurrentIndex()));
		}
	}
}
