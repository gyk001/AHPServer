package cn.com.sinosoft.ie.ahp.server.worker;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;


public class WorkerState implements Serializable{
	private static final long serialVersionUID = -5835132861880318978L;
	// 状态键：工作者名称
	public static final String ST_NAME = "st_name";
	// 状态键：最后检查时间间隔
	public static final String ST_LAST_CHECK_TIME = "st_last_check";
	// 状态键：最后出现的错误
	public static final String ST_LAST_ERROR = "st_last_error";
	// 状态键:是否正常工作
	public static final String ST_WORK_RIGHT = "st_work_right";
	
	private String name;
	// 最后检查有无数据时间
	private long lastChecktime;
	// 是否正常工作
	private boolean workRight;
	//处理数据数量
	private Map<String,Integer> bizCount;
	// 最后的出现错误
	private Throwable lastError;
	
	public long refreshLastCheckTime(){
		this.lastChecktime = System.nanoTime();
		return this.lastChecktime;
	}
	public Map<String,Object> toMap(){
		Map map = new HashMap<String,Object>();
		map.put(ST_LAST_CHECK_TIME, this.lastChecktime);
		map.put(ST_LAST_ERROR, this.lastError);
		map.put(ST_WORK_RIGHT, this.workRight);
		map.put(ST_NAME, name);
		return map;
	}
	
	public long getLastChecktime() {
		return lastChecktime;
	}
	public void setLastChecktime(long lastChecktime) {
		this.lastChecktime = lastChecktime;
	}
	public boolean isWorkRight() {
		return workRight;
	}
	public void setWorkRight(boolean workRight) {
		this.workRight = workRight;
	}
	public Throwable getLastError() {
		return lastError;
	}
	public void setLastError(Throwable lastError) {
		this.lastError = lastError;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Map<String, Integer> getBizCount() {
		return bizCount;
	}
	public void setBizCount(Map<String, Integer> bizCount) {
		this.bizCount = bizCount;
	}
	
	
	

}
