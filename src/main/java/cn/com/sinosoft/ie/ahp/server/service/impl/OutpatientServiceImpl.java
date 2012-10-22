package cn.com.sinosoft.ie.ahp.server.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.com.sinosoft.ie.ahp.server.db.QueryHelper;
import cn.com.sinosoft.ie.ahp.server.processer.CdaProcessException;
import cn.com.sinosoft.ie.ahp.server.service.AbstractBizService;
import cn.com.sinosoft.ie.ahp.server.service.SqlMakeUtil;

import com.sinosoft.ie.ahp.server.util.DateUtil;
import com.sinosoft.ie.ahp.server.util.OrgUtil;

/**
 * @author <a href="gyk001@gmail.com">Guo Yukun</a>
 * @version 2012-10-22
 */
public class OutpatientServiceImpl extends AbstractBizService {
	private static final Logger logger = LoggerFactory.getLogger(OutpatientServiceImpl.class);
	//门诊
	private static final String TBL_OUT_PATIENT = "UDP_R_VIEWER_OUT_PATIENT_R";
	//患者
	private static final String TBL_PATIENT = "UDP_R_VIEWER_EHR_PATIENT";
	//门急诊症状
	private static final String TBL_CLIN_FRAME_T = "UDP_R_VIEWER_CLIN_FRAME_T";
	//门急诊诊疗手术记录
	private static final String TBL_CLIN_OP = "UDP_R_VIEWER_CLIN_OP_RECO";
	//门急诊诊疗放射治疗记录
	private static final String TBL_CLIN_RAD = "UDP_R_VIEWER_CLIN_RAD_REC";
	//门急诊诊疗用药记录
	private static final String TBL_CLIN_DRUG = "UDP_R_VIEWER_CLIN_DRUG_REC";
	//门急诊诊疗诊断记录
	private static final String TBL_CLIN_DIAG = "UDP_R_VIEWER_CLIN_DIAG_REC";
	//门急诊诊疗费用结算
	private static final String TBL_CLIN_COST = "UDP_R_VIEWER_CLIN_COST";
	//门急诊诊疗输血记录
	private static final String TBL_CLIN_TRANSFU = "UDP_R_VIEWER_CLIN_TRANSFU";
	//门急诊诊疗死亡记录
	private static final String TBL_CLIN_DEATH = "UDP_R_VIEWER_CLIN_DEATH";
	//门急诊诊疗转诊记录-
	private static final String TBL_CLIN_TRA = "UDP_R_VIEWER_CLIN_TRA_REC";
	
	//cda中患者键名
	private static final String PATIENT_KEY = "UDP_R_VIEWER_PERSON_REG";
	
	// 摘要信息
	private static final String TBL_ABSTRACT = "UDP_R_VIEWER_EHR_ABSTRACT";

	@Override
	protected void saveBizData(Connection conn, Map<String, Object> bizData,
			String patientPersonId, String bussinessId) throws Exception {
		//患者
		bizData.remove(PATIENT_KEY);
		//门急诊症状
		Collection<Map<String, Object>> clinFrameTList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_FRAME_T);
		bizData.remove(TBL_CLIN_FRAME_T);
		//门急诊诊疗手术记录
		Collection<Map<String, Object>> clinOpList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_OP);
		bizData.remove(TBL_CLIN_OP);
		//门急诊诊疗放射治疗记录
		Collection<Map<String, Object>> clinRadList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_RAD);
		bizData.remove(TBL_CLIN_RAD);
		//门急诊诊疗用药记录
		Collection<Map<String, Object>> clinDrugTList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_DRUG);
		bizData.remove(TBL_CLIN_DRUG);
		//门急诊诊疗诊断记录
		Collection<Map<String, Object>> clinDiagList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_DIAG);
		bizData.remove(TBL_CLIN_DIAG);
		//门急诊诊疗费用结算
		Collection<Map<String, Object>> clinCostList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_COST);
		bizData.remove(TBL_CLIN_COST);
		//门急诊诊疗输血记录
		Collection<Map<String, Object>> clinTransfuList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_TRANSFU);
		bizData.remove(TBL_CLIN_TRANSFU);
		//门急诊诊疗死亡记录
		Collection<Map<String, Object>> clinDeathList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_DEATH);
		bizData.remove(TBL_CLIN_DEATH);
		//门急诊诊疗转诊记录
		Collection<Map<String, Object>> clinTraList = (Collection<Map<String, Object>>) bizData.get(TBL_CLIN_TRA);
		bizData.remove(TBL_CLIN_TRA);

		//门诊信息
		insertOutPatient(conn,bizData);
		//门急诊症状
		insertChildrenSimply(conn, clinFrameTList, TBL_CLIN_FRAME_T, TBL_OUT_PATIENT, patientPersonId);
		//门急诊诊疗手术记录
		insertChildrenSimply(conn, clinOpList, TBL_CLIN_OP, TBL_OUT_PATIENT, patientPersonId);
		//门急诊诊疗放射治疗记录
		insertChildrenSimply(conn, clinRadList, TBL_CLIN_RAD, TBL_OUT_PATIENT, patientPersonId);
		//门急诊诊疗用药记录
		insertChildrenSimply(conn, clinDrugTList, TBL_CLIN_DRUG, TBL_OUT_PATIENT, patientPersonId);
		//门急诊诊疗诊断记录
		insertChildrenSimply(conn, clinDiagList, TBL_CLIN_DIAG, TBL_OUT_PATIENT, patientPersonId);
		//门急诊诊疗费用结算
		insertChildrenSimply(conn, clinCostList, TBL_CLIN_COST, TBL_OUT_PATIENT, patientPersonId);
		//门急诊诊疗输血记录
		insertChildrenSimply(conn, clinTransfuList, TBL_CLIN_TRANSFU, TBL_OUT_PATIENT, patientPersonId);
		//门急诊诊疗死亡记录
		insertChildrenSimply(conn, clinDeathList, TBL_CLIN_DEATH, TBL_OUT_PATIENT, patientPersonId);
		//门急诊诊疗转诊记录-
		insertChildrenSimply(conn, clinTraList, TBL_CLIN_TRA, TBL_OUT_PATIENT, patientPersonId);
		
		insertAbstract(conn,patientPersonId, bizData, bussinessId, clinDrugTList, clinFrameTList, clinDiagList);


	}

	@Override
	protected void saveCDA(Connection conn, Map<String, Object> map,
			String patientPersonId, String bussinessId) throws Exception {
		// TODO Auto-generated method stub

	}
	
	
	private void insertOutPatient(Connection conn, Map<String, Object> outPatient) throws CdaProcessException{
		StringBuffer columns = new StringBuffer();
		StringBuffer values = new StringBuffer();
		//处理构造sql所需的参数
		List<Object> params = SqlMakeUtil.processMapForInsert(outPatient, columns, values);
		//columns.append("FIELD_PK");
		//values.append("?");
		//params.add(outPatient);
		columns.setLength(columns.length()-1);
		values.setLength(values.length()-1);
		
		//构造sql
		String sql = SqlMakeUtil.makeInsertSql(TBL_OUT_PATIENT, columns, values);
		//执行插入
		try {
			QueryHelper.insertSql(conn, sql.toString(), params.toArray());
		} catch (Exception e) {
			CdaProcessException cpe = new CdaProcessException(
					"insert [OutPatient] exception！", e);
			logger.error(cpe.getLocalizedMessage(), cpe);
			throw cpe;
		}
	}
	
	private void insertAbstract(Connection conn, String patientPersonId,Map<String, Object> outPatient,String bussinessId,Collection<Map<String, Object>> clinDrugTList,Collection<Map<String, Object>> clinFrameTList,Collection<Map<String, Object>> clinDiagList) throws CdaProcessException {
		String columns = "FIELD_PK,FIELD_PK_FK,ORGCODE,ORGNAME,DEPTCODE,DEPTNAME,SERVERNAME,ABST,LINKID,REGDATE,ABSTYPE";
		String values = "?,?,?,?,?,?,?,?,?,?,?";
		List<Object> params = new ArrayList<Object>(11);
		// 主键
		params.add(UUID.randomUUID().toString());
		// 人员或患者ID
		params.add(patientPersonId);
		// 机构代码
		params.add(outPatient.get("SEND_ORG_CODE"));
		// 机构名称
		params.add(outPatient.get("SEND_SYSTEM"));
		// DEPTCODE 科室代码
		params.add(outPatient.get("VISIT_DEPT_CODE"));
		// DEPTNAME 科室名称
		params.add(outPatient.get("VISIT_DEPT_NAME"));
		// SERVERNAME 服务人员姓名
		params.add(outPatient.get("SERVICER_NAME"));
		// ABST 摘要详细内容
		StringBuffer sb = new StringBuffer();
		sb.append("就诊医院：" + outPatient.get("SEND_SYSTEM") + "\n");
		sb.append(" 就诊科室：" + outPatient.get("VISIT_DEPT_NAME") + "\n");
		String visistDate = "";
		if (outPatient.get("VISIT_DATE_TS") != null) {
			visistDate = DateUtil.getDateStr((Date)outPatient.get("VISIT_DATE_TS"),"yyyy-MM-dd");
		}
		sb.append(" 就诊时间："+ visistDate + "\n");
		sb.append(" 就诊原因：" + outPatient.get("VISIT_REASON") + "\n");
		sb.append(" 主诉：" + outPatient.get("SUBJECTIVE") + "\n");
		// 用药
		StringBuffer drugSb = new StringBuffer();
		for (Map<String,Object> drug: clinDrugTList) {
			//drugSb.append("{");
			drugSb.append(drug.get("DRUG_NAME"));
			drugSb.append("*");
			drugSb.append(drug.get("AMOUNT"));
			drugSb.append("*");
			drugSb.append(drug.get("UNIT"));
			//drugSb.append("}");
			drugSb.append("；");
		}
		// 诊断
		StringBuffer diagSb = new StringBuffer();
		for (Map<String,Object> diag: clinDiagList) {
			//diagSb.append("{");
			diagSb.append(diag.get("DIAG_NAME"));
			diagSb.append("；");
		}
		// 症状
		StringBuffer frameSb = new StringBuffer();
		for (Map<String,Object> fram: clinFrameTList) {
			//frameSb.append("{");
			frameSb.append(fram.get("CLIN_SYMPTOM_NAME"));
			//frameSb.append("}");
			frameSb.append("；");
		}
		sb.append(" 症状：" + frameSb.toString() + "\n");
		sb.append(" 诊断：" + diagSb.toString()+ "\n");
		sb.append(" 用药：" + drugSb.toString()+ "\n");
		params.add(sb.toString());
		// LINKID 业务主键
		params.add(bussinessId);
		// REGDATE 就诊时间
		params.add(visistDate);
		// ABSTYPE 摘要业务类型
		params.add(OrgUtil.ABSTRACTOUTPATIENT);
		// 构造sql
		String sql = SqlMakeUtil.makeInsertSql(TBL_ABSTRACT, columns,values);
		//执行插入
			try {
				QueryHelper.insertSql(conn, sql.toString(), params.toArray());
			} catch (Exception e) {
				CdaProcessException cpe = new CdaProcessException(
						"insert [OutPatient Abstract] exception！", e);
				logger.error(cpe.getLocalizedMessage(), cpe);
				throw cpe;
			}
	}

}
