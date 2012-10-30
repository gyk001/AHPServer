package cn.com.sinosoft.ie.ahp.server.module;

/**
 * @author <a href="gyk001@gmail.com">Guo Yukun</a>
 * @version 2012-10-30
 */
public interface ModuleStatus {
   public Throwable getLastError();
   public boolean isWorkRight();
   public boolean isInit();
}
