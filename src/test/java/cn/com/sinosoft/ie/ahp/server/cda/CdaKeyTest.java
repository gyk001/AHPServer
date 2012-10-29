package cn.com.sinosoft.ie.ahp.server.cda;

import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import cn.com.sinosoft.ie.ahp.server.service.cda.TypeVersionCdaKey;

public class CdaKeyTest {

  @DataProvider(name="con")
  public Object[][] dp() {
    return new Object[][] {
      new Object[] { "abc", "1" },
      new Object[] { "sadf", "x" },
    };
  }

  @Test(dataProvider="con",enabled=false)
  public void CdaKey(String bizType, String version) {
	  TypeVersionCdaKey key1 = new TypeVersionCdaKey(bizType, version);
	  TypeVersionCdaKey key2 = new TypeVersionCdaKey(bizType, version);
	  assert key1.equals(key2):"键值不相等";
  }
}
