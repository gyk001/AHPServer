package cn.com.sinosoft.ie.ahp.server.utils;

import com.ximpleware.AutoPilot;
import com.ximpleware.VTDGen;
import com.ximpleware.VTDNav;

public class OldCdaParserTest {

	 private  void xpathTest() throws Exception{
         VTDGen vg = new VTDGen();
         AutoPilot ap = new AutoPilot();
         int i;
         // declareXPathNameSpace associates name space with a prefix
         ap.declareXPathNameSpace("ns1","someURL");
	    ap.selectXPath("/ns1:a/ns1:b/text()");
         if (vg.parseFile("d:/java_tutorial_by_code_examples/3/input.xml",true)){
             VTDNav vn = vg.getNav();
             ap.bind(vn); 
             // AutoPilot moves the cursor for you, as it returns the index value of the qualified node
             while((i=ap.evalXPath())!=-1){
                 // notice that i always is equal to vn.getCurrentIndex()!!!
                 System.out.println("the text node index val is "+ 
                     i +" the text string ==>"+vn.toString(i));
                 // below is equivalent to 
                 // vn's cursor is what gets moved by AutoPilot here
                 System.out.println("the text node index val is " + 
                     i + " the text string ==>" + vn.toString(vn.getCurrentIndex()));
             }
         }
     } 
}
