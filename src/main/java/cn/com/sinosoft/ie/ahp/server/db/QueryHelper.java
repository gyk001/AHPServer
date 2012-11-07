package cn.com.sinosoft.ie.ahp.server.db;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 数据库查询助手 (需要到 Common-DBUtils 包)
 * 
 * @author CaoJia
 */

public class QueryHelper {
	private static Logger logger = LoggerFactory.getLogger(QueryHelper.class);

	// jdbc支持 getPreparedStatementMetaData 时使用 如果不支持如oracle 构造函数加true参数
	private final static QueryRunner qr = new QueryRunner(true);
	
	private final static MapListHandler mapListHandler = new MapListHandler();

	public static int insertSql(Connection conn,String sql, Object... params) throws Exception{
		int ret = 0;
		try {
			if (params.length > 0) {
				ret = qr.update(conn, sql, params);
			} else {
				ret = qr.update(conn, sql);
			}
		} catch (SQLException e) {
			logger.error("插入数据异常!",e);
			throw e;
		}
		return ret;
	}
	
	public static List<Map<String, Object>> selectSql(Connection conn, String sql,
			Object... params) {
		List<Map<String, Object>> list = null;
		try {
			if (params.length > 0) {
				list = qr.query(conn, sql, mapListHandler,
						params);
			} else {
				list = qr.query(conn, sql, mapListHandler);
			}

		} catch (SQLException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
			logger.error("查询失败:" + sql);
		}
		return list;
	}
	public static int updateSql(Connection conn,String sql, Object... params) throws Exception{
		int ret = 0;
		try {
			if (params.length > 0) {
				ret = qr.update(conn, sql, params);
			} else {
				ret = qr.update(conn, sql);
			}
		} catch (SQLException e) {
			logger.error("更新数据异常!",e);
			throw e;
		}
		return ret;
	}
	
	public static Map<String, Object> selectMapSql(Connection conn, String sql,
			Object... params) {
		List<Map<String, Object>> list = null;
		try {
			if (params.length > 0) {
				list = qr.query(conn, sql, mapListHandler,
						params);
			} else {
				list = qr.query(conn, sql, mapListHandler);
			}
			if(list!=null && list.size()>0){
				return list.get(0);
			}

		} catch (SQLException e) {
			logger.error(e.getLocalizedMessage()+" :"+sql);
		}
		return null;
	}
}
