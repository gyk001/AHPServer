package com.sinosoft.ie.ahp.server.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import jodd.datetime.JDateTime;
import jodd.datetime.format.DefaultFormatter;
import jodd.datetime.format.JdtFormatter;


public class DateUtil {

	public static String getDateStr(String format)
	{
		Date dt = new Date(System.currentTimeMillis());
		SimpleDateFormat sdf=new SimpleDateFormat(format);
		String dtStr = sdf.format(dt);
		return dtStr;
	}
	
	public static Date getDate(String dateStr,String format)
	{
		if(format==null)
		{
			format = "yyyy-MM-dd HH:mm:ss";
		}
		Date d = null;
		SimpleDateFormat sf = new SimpleDateFormat(format);
		try {
			d = new Date(sf.parse(dateStr).getTime());
		} catch (Exception e) {
			//e.printStackTrace();
			d = null;
		}
		return d;
	}
	
	public static String getDateStr(Date dt,String format)
	{
		if(format==null)
		{
			format = "yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat sdf=new SimpleDateFormat(format);
		String dtStr = sdf.format(dt);
		return dtStr;
	}
	/**
	 * 得到国家固定的时间格式
	 * @param args
	 */
	public static String getDateStrFromPro(Date dt) {
		Calendar c=Calendar.getInstance();
		c.setTime(dt);
		JDateTime jdt = new JDateTime();
		jdt.loadFrom(c);
		JdtFormatter fmt = new DefaultFormatter();
		String s = fmt.convert(jdt,"YYYY-MM-DDThh:mm:ss");
		
		return s;
	}
}
