package cn.com.sinosoft.ie.ahp.server.cda;

import org.testng.annotations.Test;
import org.testng.annotations.DataProvider;

public class CdaKeyTest {

  @DataProvider(name="con")
  public Object[][] dp() {
    return new Object[][] {
      new Object[] { "abc", "1" },
      new Object[] { "sadf", "x" },
    };
  }

  @Test(dataProvider="con")
  public void CdaKey(String bizType, String version) {
	  CdaKey key1 = new CdaKey(bizType, version);
	  CdaKey key2 = new CdaKey(bizType, version);
	  assert key1.equals(key2):"键值不相等";
  }
}
