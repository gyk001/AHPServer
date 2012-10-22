package cn.com.sinosoft.ie.ahp.server.service;

import java.sql.Connection;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.db.DBManager;
import cn.com.sinosoft.ie.ahp.server.service.cda.MapperCdaParser;

public abstract class AbstractBizService implements IBizService {

	private static final Logger logger = LoggerFactory
			.getLogger(AbstractBizService.class);

	@Override
	public BizResult process(String bizId, String ppId, String cdaContent) {
		// 构建返回结果对象
		BizResult result = new BizResult(bizId, ppId);
		try {
			Map<String, Object> bizData = null;
			try {
				// 解析CDA为业务对象
				bizData = MapperCdaParser.parserCDA(cdaContent);
			} catch (Exception e) {
				// 解析失败，构建失败结果
				result.setCode(BizResultCode.CDA_PARSE_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;
			}
			Connection conn = null;
			try {
				conn = DBManager.getConnection();
				if (conn == null) {
					throw new NullPointerException("cannot get db conn!");
				}
				conn.setAutoCommit(false);
			} catch (Exception e) {
				result.setCode(BizResultCode.UNKNOWN_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;
			}
			try {
				// 插入业务数据
				saveBizData(conn, bizData, ppId, bizId);
			} catch (Exception e) {
				result.setCode(BizResultCode.DATA_SAVE_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;
			}
			try {
				// 插入CDA
				saveCDA(conn, bizData , ppId, bizId);
			} catch (Exception e) {
				result.setCode(BizResultCode.CDA_SAVE_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;
			}
			try {
				//提交事务
				conn.commit();
			} catch (Exception e) {
				result.setCode(BizResultCode.UNKNOWN_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;
			}

		} catch (Exception ee) {
			logger.warn("获取数据库连接失败,bizId:[" + bizId + "],ppId:[" + ppId + "]",
					ee);
			return result;
		} finally {
			DBManager.closeConnection();
		}
		result.setCode(BizResultCode.SUCCESS);
		result.setMsg("OK");
		return result;

	}

	/**
	 * 分析业务数据插入数据库
	 * 
	 * @param conn  数据库连接
	 * @param map   业务数据
	 * @param patientPersonId  根据不同的业务值为患者ID或人员ID
	 * @param bussinessId  业务ID
	 * @throws Exception   业务数据有问题或者插入失败时抛出
	 */
	protected abstract void saveBizData(Connection conn,
			Map<String, Object> map, String patientPersonId, String bussinessId)
			throws Exception;

	//TODO
	protected abstract void saveCDA(Connection conn, Map<String, Object> map,
			String patientPersonId, String bussinessId)
			throws Exception;

}
