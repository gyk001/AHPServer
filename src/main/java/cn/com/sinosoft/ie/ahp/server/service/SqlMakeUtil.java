package cn.com.sinosoft.ie.ahp.server.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author 郭玉昆(<a href="mailto:gyk001@gmail.com">gyk001@gmail.com</a>)
 * @version 2012-5-23
 *
 */
public class SqlMakeUtil {

	/**
	 * 
	 * @param map
	 * @param columns
	 * @param values
	 * @return
	 */
	public static List<Object> processMapForInsert(Map<String, Object> map,
			StringBuffer columns,StringBuffer values){
		List<Object> params = new ArrayList<Object>(map.keySet().size());
		for (String key : map.keySet()) {
			Object value = map.get(key);
			if (value != null && !"".equals(value)) {
				columns.append(key).append(",");
				values.append("?,");
				if(value instanceof java.util.Date){
					params.add( new java.sql.Date(((Date)value).getTime()));
				}else{
					params.add(value);
				}
			}
		}
		return params;
	}
	
	public static String makeInsertSql(CharSequence tableName,CharSequence columns,CharSequence placeholders){
		if(tableName!=null && columns!=null && placeholders!=null && tableName.length()>0 && columns.length()>0 && placeholders.length()>0){
			StringBuffer sql= new StringBuffer(); 
			sql.append("insert into ").append(tableName + " (").append(columns)
			.append(") ").append("values (").append(placeholders).append(")");
			return sql.toString();
		}else{
			return null;
		}
	}
	
	public static String makeUpdateSql(CharSequence tableName,CharSequence columns){
		StringBuffer sql= new StringBuffer(); 
		if (columns != null) {
			sql.append(" update  ").append( tableName.toString()).append(" set");
			String columnsList = columns.toString();
			 String[] columnsarray = columnsList.split(",");
			 for (int i = 0; i < columnsarray.length; i++) {
				String str =  columnsarray[i];
				if (!str.equals("FIELD_PK")) {
					sql.append(" " + str).append(" = ? ");
					if (i !=(columnsarray.length-1)) {
						sql.append(",");
					} 
				}
			}
		}
		sql.append("  where FIELD_PK = ?");
		return sql.toString();
	}
	
	public static List<Object> processMapForUpdate(Map<String, Object> map,
			StringBuffer columns,StringBuffer values){
		List<Object> params = new ArrayList<Object>(map.keySet().size());
		for (String key : map.keySet()) {
			Object value = map.get(key);
			if (value != null && !"".equals(value)) {
				if (!key.equals("FIELD_PK")) {
					columns.append(key).append(",");
					values.append("?,");
					if(value instanceof java.util.Date){
						params.add( new java.sql.Date(((Date)value).getTime()));
					}else{
						params.add(value);
					}
				}
			}
		}
		return params;
	}
/*	public static List<Object> processMapForUpdate(Map<String, Object> map,StringBuffer columns,StringBuffer values){
		List<Object> params = new ArrayList<Object>(map.keySet().size());
		for (String key : map.keySet()) {
			Object value = map.get(key);
			if (value != null && !"".equals(value)) {
				columns.append(key).append(",");
				values.append("?,");
				if(value instanceof java.util.Date){
					params.add( new java.sql.Date(((Date)value).getTime()));
				}else{
					params.add(value);
				}
			}
		}
		return params;
	}*/
}
