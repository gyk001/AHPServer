package cn.com.sinosoft.ie.ahp.server.service;

public enum BizResultCode {
	SUCCESS, /* 成功 */
	CDA_PARSE_ERROR, /* CDA解析错误 */
	DATA_SAVE_ERROR, /* 保存业务数据错误 */
	CDA_SAVE_ERROR, /* 保存CDA错误 */
	UNKNOWN_ERROR/* 未知错误 */
}
