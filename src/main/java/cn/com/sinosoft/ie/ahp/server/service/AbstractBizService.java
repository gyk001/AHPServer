package cn.com.sinosoft.ie.ahp.server.service;

import java.sql.Connection;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.db.DBManager;
import cn.com.sinosoft.ie.ahp.server.db.QueryHelper;
import cn.com.sinosoft.ie.ahp.server.processer.CdaProcessException;
import cn.com.sinosoft.ie.ahp.server.service.cda.MapperCdaParser;

public abstract class AbstractBizService implements IBizService {

	private static final Logger logger = LoggerFactory
			.getLogger(AbstractBizService.class);
	// 初始化标志
	private volatile boolean init = false;
	private BizPluginHandler handler = null;
	/**
	 * 初始化
	 */
	public synchronized void init() {
		if (!init) {
			init = true;
		}
	}
	
	public synchronized void destory(){
		
	}

	@Override
	public BizResult process(String bizId, String ppId, String cdaContent) {
		// 构建返回结果对象
		BizResult result = new BizResult(bizId, ppId);
		Map<String, Object> bizData = null;
		try {
			if (!init) {
				Exception e = new IllegalStateException("未初始化!");
				result.setCode(BizResultCode.SYS_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;				
			}
			try {
				if(handler!=null){
					handler.beforParseCda(bizId, ppId, cdaContent);
				}
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
				if(handler!=null){
					handler.beforSaveBizData(bizId, ppId, cdaContent, bizData);
				}
				// 插入业务数据
				saveBizData(conn, bizData, ppId, bizId);
			} catch (Exception e) {
				result.setCode(BizResultCode.DATA_SAVE_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;
			}
			try {
				if(handler!=null){
					handler.beforSaveCda(bizId, ppId, cdaContent, bizData);
				}
				// 插入CDA
				saveCDA(conn, bizData, ppId, bizId);
			} catch (Exception e) {
				result.setCode(BizResultCode.CDA_SAVE_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;
			}
			try {
				if(handler!=null){
					handler.beforCommitAll(bizId, ppId, cdaContent, bizData);
				}
				// 提交事务
				conn.commit();
			} catch (Exception e) {
				result.setCode(BizResultCode.UNKNOWN_ERROR);
				result.setMsg(e.getLocalizedMessage());
				throw e;
			}

		} catch (Exception ee) {
			result.setException(ee);
			logger.warn("接收数据异常,bizId:[" + bizId + "],ppId:[" + ppId + "]",
					ee);
			if(handler!=null){
				handler.beforReturnResult(bizId, ppId, cdaContent, bizData, result);
			}
			return result;
		} finally {
			DBManager.closeConnection();
		}
		result.setCode(BizResultCode.SUCCESS);
		result.setMsg("OK");
		if(handler!=null){
			handler.beforReturnResult(bizId, ppId, cdaContent, bizData, result);
		}
		return result;

	}
	public void setBizPluginHandler(BizPluginHandler handler){
		this.handler = handler;
	}

	/**
	 * 分析业务数据插入数据库
	 * 
	 * @param conn
	 *            数据库连接
	 * @param bizData
	 *            业务数据
	 * @param patientPersonId
	 *            根据不同的业务值为患者ID或人员ID
	 * @param bussinessId
	 *            业务ID
	 * @throws Exception
	 *             业务数据有问题或者插入失败时抛出
	 */
	protected abstract void saveBizData(Connection conn,
			Map<String, Object> bizData, String patientPersonId, String bussinessId)
			throws Exception;

	// TODO
	protected abstract void saveCDA(Connection conn, Map<String, Object> map,
			String patientPersonId, String bussinessId) throws Exception;

	
	/**
	 * 插入子表数据（集合）
	 * @param conn 数据库连接
	 * @param children 子表数据集合
	 * @param tableName 子表表名
	 * @param parentMapKey 子表数据中包含的父表元素键名
	 * @param fk 外键值，既主表主键值
	 * @throws Exception
	 */
	protected final void insertChildrenSimply(Connection conn,
			Collection<Map<String, Object>> children, String tableName,
			String parentMapKey, String fk) throws CdaProcessException {
		for (Map<String, Object> child : children) {
			// 移除父表元素
			if (parentMapKey != null && !"".equals(parentMapKey)) {
				child.remove(parentMapKey);
			}
			StringBuffer columns = new StringBuffer();
			StringBuffer values = new StringBuffer();
			// 处理构造sql所需的参数
			List<Object> params = SqlMakeUtil.processMapForInsert(child,
					columns, values);
			// 外键关联
			if (fk != null && !"".equals(fk)) {
				columns.append("FIELD_PK_FK");
				values.append("?");
				params.add(fk);
			} else {
				// 删除最后一值
				columns.deleteCharAt(columns.length() - 1);
				values.deleteCharAt(values.length() - 1);
			}
			// 构造sql
			String sql = SqlMakeUtil.makeInsertSql(tableName, columns,
					values);
			// 执行插入
			try {
				QueryHelper.insertSql(conn, sql.toString(), params.toArray());
			} catch (Exception e) {
				CdaProcessException cpe = new CdaProcessException(
						"insertChildrenSimply exception！tableName:" + tableName
								+ ";fk:" + fk, e);
				//logger.error(cpe.getLocalizedMessage(), cpe);
				throw cpe;
			}
		}
	}
}
