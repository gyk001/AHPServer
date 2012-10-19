<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:import href="../util.xsl "/>
	<xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<xsl:template match="/">
		<html>
			<title>病例摘要</title>
			<body>
				<!--个人基本信息-->
				<xsl:apply-templates select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole"/>
				<!--个人建档信息-->
				<xsl:apply-templates select="/n1:ClinicalDocument/n1:author/n1:assignedAuthor"/>
				<!--个人章节-->
				<xsl:apply-templates select="/n1:ClinicalDocument/n1:component/n1:structuredBody"/>
			</body>
		</html>
	</xsl:template>
	<!--个人基本信息-->
	<xsl:template match="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>患者信息</h3>
				<tr>
					<td width="10%">
						<big>
							<b>
								<xsl:text>患者: </xsl:text>
							</b>
						</big>
					</td>
					<td width="40%">
						<big>
							<xsl:call-template name="getName">
								<xsl:with-param name="name" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name"/>
							</xsl:call-template>
						</big>
					</td>
					<td width="25%" align="right">
						<b>
							<xsl:text>患者身份证号: </xsl:text>
						</b>
					</td>
					<td width="25%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:id/@extension">
						</xsl:value-of>
					</td>
				</tr>
				<tr>
					<td width="10%">
						<b>
							<xsl:text>出生日期: </xsl:text>
						</b>
					</td>
					<td width="40%">
						<xsl:call-template name="formatDate">
							<xsl:with-param name="date" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:birthTime/@value"/>
						</xsl:call-template>
					</td>
					<td width="25%" align="right">
						<b>
							<xsl:text>性别: </xsl:text>
						</b>
					</td>
					<td width="25%">
						<xsl:variable name="sex" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:administrativeGenderCode/@code"/>
						<xsl:choose>
							<xsl:when test="$sex='1'">男</xsl:when>
							<xsl:when test="$sex='2'">女</xsl:when>
						</xsl:choose>
					</td>
				</tr>
				<tr>
					<td width="10%">
						<b>
							<xsl:text>地址: </xsl:text>
						</b>
					</td>
					<td width="40%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:addr/n1:state/@literal"/>
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:addr/n1:city/@literal"/>
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:addr/n1:county/@literal"/>
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:addr/n1:streetName/@literal"/>
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:addr/n1:houseNumber/@literal"/>
					</td>
					<td width="25%" align="right">
						<b>
							<xsl:text>邮政编码: </xsl:text>
						</b>
					</td>
					<td width="25%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:addr/n1:postalCode/@literal"/>
					</td>
				</tr>
				<tr>
					<td width="10%">
						<b>
							<xsl:text>电话号码: </xsl:text>
						</b>
					</td>
					<td width="40%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:telecom/@value">
						</xsl:value-of>
					</td>
					<td width="25%" align="right">
						<b>
							<xsl:text>邮箱: </xsl:text>
						</b>
					</td>
					<td width="25%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:telecom[2]/@value">
						</xsl:value-of>
					</td>
				</tr>
				<tr>
					<td width="10%">
						<b>
							<xsl:text>婚姻状况: </xsl:text>
						</b>
					</td>
					<td width="40%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:maritalStatusCode[@codeSystem='SD.11.3.5']/@displayName">
						</xsl:value-of>
					</td>
					<td width="25%" align="right">
						<b>
						<xsl:text>民族类别: </xsl:text>
							</b>
					</td>
					<td width="25%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:ethnicGroupCode[@codeSystem='SD.11.3.3']/@displayName">
						</xsl:value-of>
					</td>
				</tr>
				<tr>
					<td width="10%">
						<b>
							<xsl:text>患者学历: </xsl:text>
						</b>
					</td>
					<td width="40%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:asEducationLevelCode/n1:value[@code='17']/@displayName">
						</xsl:value-of>
					</td>
					<td width="25%" align="right">
						<b>
							<xsl:text>医保卡号: </xsl:text>
						</b>
					</td>
					<td width="25%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:asMedicalInsuranceCode[@codeSystem='SD.4.14']/@displayName">
						</xsl:value-of>
					</td>
				</tr>
				<tr>
					<td width="10%">
						<b>
							<xsl:text>国籍: </xsl:text>
						</b>
					</td>
					<td width="40%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:asNationality/n1:code/@displayName">
						</xsl:value-of>
					</td>
					<td width="25%" align="right">
						<b>
							<xsl:text>患者职业: </xsl:text>
						</b>
					</td>
					<td width="25%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:occupationCode/n1:value[@codeSystem='SD.11.3.7']/@displayName">
						</xsl:value-of>
					</td>
				</tr>
				<tr>
					<td width="10%">
						<b>
							<xsl:text>患者所在行政区划: </xsl:text>
						</b>
					</td>
					<td width="40%">
						<xsl:value-of select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:asServiceDeliveryLocation/n1:location/n1:code/@displayName">
						</xsl:value-of>
					</td>
				</tr>
			</table>
		</xsl:template>
				<table width="100%" border="1">
					<h3>随访信息</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>随访人员: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:choose>
								<xsl:when test="/n1:ClinicalDocument/n1:author/n1:assignedAuthor/n1:assignedAuthorChoice/n1:assignedPerdon/n1:name">
									<xsl:call-template name="getName">
										<xsl:with-param name="name" select="/n1:ClinicalDocument/n1:author/n1:assignedAuthor/n1:assignedAuthorChoice/n1:assignedPerdon/n1:name"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="getName">
										<xsl:with-param name="name" select="/n1:ClinicalDocument/n1:author/n1:assignedAuthor/n1:assignedAuthorChoice/n1:assignedPerdon/n1:name"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</td>
							<td width="25%" align="right">
							<b>
								<xsl:text>随访时间: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="/n1:ClinicalDocument/n1:author[1]/n1:time/@value"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>					
						<td width="10%">
							<b>
								<xsl:text>随访医生科室名称: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:author[1]/n1:assignedAuthor/n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>上报机构名称: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:author[2]/n1:assignedAuthor/n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>
					</tr>
					<tr>					
						<td width="10%">
							<b>
								<xsl:text>上报机构地址: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:author[2]/n1:assignedAuthor/n1:representedOrganization/n1:addr/n1:streetName/@literal">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>上报系统名称: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:author[2]/n1:assignedAuthor/n1:assignedAuthoringDevice/n1:code/@extension">
							</xsl:value-of>
						</td>	
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>文档管理机构名称: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name/@literal">
						</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>文档管理机构机构地址: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:addr/n1:city/@literal">
						</xsl:value-of>
						</td>
					</tr>
					
				</table>
				<br/>
				<table width="100%">
					<h3>随访事件章节</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>随访方式: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[1]/n1:section/n1:entry/n1:observation/n1:value[@codeSystem='SD.11.1.183']/@displayName"/>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>随访时间: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[1]/n1:section/n1:entry/n1:observation/n1:effectiveTime/@value"/>
							</xsl:call-template>
						</td>
					</tr>
				</table>
				<br/>
				<table width="100%">
					<h3>病症章节</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>病症描述: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[2]/n1:section/n1:entry[2]/n1:observation/n1:text">
						</xsl:value-of>
						</td>
					</tr>
				</table>
				<br/>
				<table width="100%">
					<h3>生命体征章节</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>收缩压: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[1]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[1]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>舒张压: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[2]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>体重: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[3]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[3]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>体质指数: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[4]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>足背动脉搏动标志: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[5]/n1:observation/n1:value/@displayName">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>其他阳性体征: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry[6]/n1:observation/n1:text">
							</xsl:value-of>
						</td>
					</tr>
				</table>
				<br/>
				<table width="100%">
					<h3>生活方式章节</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>日吸烟量: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[1]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[1]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>日饮酒量: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[2]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>身体活动频率: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[3]/n1:observation/n1:value/@displayName">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>每次锻炼时间: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[4]/n1:observation/n1:value/n1:width/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[4]/n1:observation/n1:value/n1:width/@unit">
							</xsl:value-of>
						</td>
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>日主食量: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[5]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[5]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>心理调整: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[6]/n1:observation/n1:value/@displayName">
							</xsl:value-of>
						</td>
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>遵医行为: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry[7]/n1:observation/n1:value/@displayName">
							</xsl:value-of>
						</td>
					</tr>
				</table>
				<br/>
				<table width="100%">
					<h3>实验室章节</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>空腹血糖: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry[1]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry[1]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>糖化血红蛋白值: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry[2]/n1:observation/n1:value/@unit">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>测试时间: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry[2]/n1:observation/n1:effectiveTime/@value">
						</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>辅助检查项目: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry[3]/n1:observation/n1:text">
							</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>检查时间: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry[3]/n1:observation/n1:effectiveTime/@value">
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>检查结果: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry[4]/n1:observation/n1:text">
							</xsl:value-of>
						</td>
					</tr>
				</table>
				<br/>
				<table width="100%" border="1">
					<h3>用药记录</h3>
					<thead>
						<tr>
							<th><h4>用药途径</h4></th>
							<th><h4>用药剂量</h4></th>
							<th><h4>用药频率</h4></th>
							<th><h4>药品名称</h4></th>
							<th><h4>服药情况</h4></th>
							<th><h4>药物不良反应</h4></th>
						</tr>
					</thead>
					<tbody align="center">
						<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[6]/n1:section/n1:entry/n1:substanceAdministration/..">
							<tr>
								<td>
									<xsl:value-of select="n1:substanceAdministration/n1:routeCode[@codeSystem='SD.11.1.158']/@displayName">
									</xsl:value-of>
								</td >
								<td>
									<xsl:value-of select="n1:substanceAdministration/n1:doseQuantity/@value">
									</xsl:value-of>
									<xsl:value-of select="n1:substanceAdministration/n1:doseQuantity/@unit">
									</xsl:value-of>
								</td >
								<td>
									<xsl:value-of select="n1:substanceAdministration/n1:rateQuantity/@value">
									</xsl:value-of>
									<xsl:value-of select="n1:substanceAdministration/n1:rateQuantity/@unit">
									</xsl:value-of>
								</td >
								<td>
									<xsl:value-of select="n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:manufacturedLabeledDrug/n1:name">
									</xsl:value-of>
								</td >
								<td>
									<xsl:value-of select="n1:substanceAdministration/n1:entryRelationship[1]/n1:observation/n1:value[@codeSystem='SD.11.2.12']/@displayName">
									</xsl:value-of>
								</td >
								<td>
									<xsl:value-of select="n1:substanceAdministration/n1:entryRelationship[2]/n1:observation/n1:text">
									</xsl:value-of>
								</td >
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<table width="100%">
					<tr>
					<td width="10%">
							<b>
								<xsl:text>低血糖反应: </xsl:text>
							</b>	
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[6]/n1:section/n1:entry[3]/n1:observation/n1:value/@displayName">
							</xsl:value-of>	
						</td>
					</tr>
				</table>
				<br/>
				<table width="100%">
					<h3>随访评估章节</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>随访评估结果: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[7]/n1:section/n1:entry/n1:observation/n1:value/@displayName">
						</xsl:value-of>
						</td>
					</tr>
				</table>
				<br/>
				<table width="100%" border="1">
					<h3>转诊建议章节</h3>
						<thead>
							<tr>
								<th><h4>转诊原因</h4></th>
								<th><h4>转诊时间</h4></th>
								<th><h4>接诊科室</h4></th>
								<th><h4>接诊医院</h4></th>
							</tr>
						</thead>
						<tbody align="center">
							<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[8]/n1:section/n1:entry/n1:observation/n1:entryRelationship/n1:act/..">
								<tr>
									<td>
										<xsl:value-of select="n1:act/n1:text">
										</xsl:value-of>
									</td>
									<td>
										<xsl:call-template name="formatDate">
											<xsl:with-param name="date" select="n1:act/n1:performer/n1:time/@value">
											</xsl:with-param>
										</xsl:call-template>
									</td>
									<td>
										<xsl:value-of select="n1:act/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
										</xsl:value-of>
									</td>
									<td>
										<xsl:value-of select="n1:act/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:asOrganizationPartOf/n1:wholeOrganization/n1:name/@literal">
						</xsl:value-of>	
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					
				</table>
				<br/>
				<table width="100%">
					<h3>下次随访安排</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>下次随访日期: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[9]/n1:section/n1:entry[1]/n1:observation/n1:effectiveTime/@value">
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</table>
				

