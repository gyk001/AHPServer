<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:import href="../util.xsl "/>
	<xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<xsl:template match="/">
		<html>
			<title>门诊临床服务</title>
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
						<xsl:value-of select="n1:patient/n1:name"/>
					</big>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>患者身份证号: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="IdSplit">
						<xsl:with-param name="id" select="n1:patient/n1:id/@extension"/>
					</xsl:call-template>
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
						<xsl:with-param name="date" select="n1:patient/n1:birthTime/@value"/>
					</xsl:call-template>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>性别: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT2261.1}" width="25%">
					<xsl:variable name="sex" select="n1:patient/n1:administrativeGenderCode/@code"/>
					<!--					<xsl:choose>
						<xsl:when test="$sex='1'">男</xsl:when>
						<xsl:when test="$sex='2'">女</xsl:when>
					</xsl:choose>-->
				</td>
			</tr>
		
		
			<tr>
				<td width="10%">
					<b>
						<xsl:text>婚姻状况: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT2261.2}" width="40%">
					<xsl:value-of select="n1:patient/n1:maritalStatusCode[@codeSystem='SD.11.3.5']/@displayName">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>民族类别: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GB3304}" width="25%">
					<xsl:value-of select="n1:patient/n1:ethnicGroupCode[@codeSystem='SD.11.3.3']/@displayName">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>患者所在行政区划: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT2260}">
					<xsl:value-of select="n1:patient/n1:asServiceDeliveryLocation/n1:location/n1:code/@displayName">
						</xsl:value-of>
				</td>
			</tr>
				
			
		</table>
		<br/>
	</xsl:template>
	<!--个人建档信息-->
	<xsl:template match="/n1:ClinicalDocument/n1:author[1]/n1:assignedAuthor">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>会诊建档信息</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>会诊人员: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:assignedAuthorChoice/n1:assignedPerson/n1:name/@literal"/>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>会诊时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="/n1:ClinicalDocument/n1:effectiveTime/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>会诊机构名称: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:representedOrganization/n1:name/@literal">
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
		
		</table>
		<br/>
	</xsl:template>
	<!--个人章节-->
	<xsl:template match="/n1:ClinicalDocument/n1:component/n1:structuredBody">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>病症章节</h3>
			<thead>
				<tr>
					<th><h4>病症</h4></th>
					<th><h4>病症开始时间</h4></th>
					<th><h4>病症持续时间</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="n1:component[1]/n1:section/n1:entry/n1:asDisease/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:asDisease/n1:asDiseaseCode/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:asDisease/n1:asDiseaseStartDate/n1:observation/n1:value/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td>
							<xsl:value-of select="n1:asDisease/n1:asDiseaseTime/n1:observation/n1:value/@value"/>
							<xsl:value-of select="n1:asDisease/n1:asDiseaseTime/n1:observation/n1:value/@unit"/>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>检查章节</h3>
			<thead>
				<tr>
					<th><h4>检查项目</h4></th>
					<th><h4>检查结果</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="n1:component[2]/n1:section/n1:entry/n1:asExamination/..">
					<tr>
						<td>
							<xsl:value-of select="n1:asExamination/n1:asExaminationItem/n1:observation/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asExamination/n1:asExaminationResult/n1:observation/n1:text">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>诊断记录</h3>
			<thead>
				<tr>
					<th><h4>诊断名称</h4></th>
					<th><h4>诊断时间</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="n1:component[3]/n1:section/n1:entry/n1:asDiagnose/..">
					<tr>
						<td>
							<xsl:value-of select="n1:asDiagnose/n1:asDiagnoseName/n1:observation/n1:code/@displayName">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:asDiagnose/n1:asDiagnoseName/n1:observation/n1:effectiveTime/@value">
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
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
				<xsl:for-each select="n1:component[4]/n1:section/n1:entry/n1:substanceAdministration/..">
					<tr>
						<td codeSystem="{$CV06.00.102}">
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
						<td codeSystem="{}">
							<xsl:value-of select="n1:substanceAdministration/n1:entryRelationship[1]/n1:observation/n1:value[@codeSystem='SD.11.2.12']/@displayName">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:entryRelationship[2]/n1:observation/n1:text">
							</xsl:value-of>
						</td >
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>手术章节</h3>
			<thead>
				<tr>
					<th><h4>手术部位</h4></th>
					<th><h4>手术时间</h4></th>
					<th><h4>麻醉方法</h4></th>
					<th><h4>手术医生</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="n1:component[5]/n1:section/n1:entry/n1:procedure/..">
					<tr>
						<td codeSystem="{$ICD9CM}">
							<xsl:value-of select="n1:procedure/n1:code[@codeSystem='SD.11.4.6']/@displayName">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:procedure/n1:effectiveTime/@value">
								</xsl:with-param>
							</xsl:call-template>
						</td>
						<td codeSystem="{$CV06.00.103}">
							<xsl:value-of select="n1:procedure/n1:entryRelationship[1]/n1:observation/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:procedure/n1:entryRelationship[3]/n1:act/n1:proformer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>转诊章节</h3>
			<thead>
				<tr>
					<th><h4>转诊原因</h4></th>
					<th><h4>转诊时间</h4></th>
					<th><h4>接诊医生</h4></th>
					<th><h4>接诊科室</h4></th>
					<th><h4>接诊医院</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[6]/n1:section/n1:entry/n1:observation/..">
					<tr>
						<td>
							<xsl:value-of select="n1:observation/n1:entryRelationship[1]/n1:act/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:observation/n1:entryRelationship[1]/n1:act/n1:performer/n1:time/@value">
								</xsl:with-param>
							</xsl:call-template>
						</td>
						<td>
							<xsl:value-of select="n1:observation/n1:entryRelationship[1]/n1:act/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:observation/n1:entryRelationship[1]/n1:act/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">	
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:observation/n1:entryRelationship[1]/n1:act/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:asOrganizationPartOf/n1:wholeOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>费用章节</h3>
			<thead>
				<tr>
					<th><h4>门诊费用</h4></th>
					<th><h4>医疗付款方式</h4></th>
					<th><h4>医疗费用结箅方式</h4></th>
					<th><h4>医疗费用</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="n1:component[7]/n1:section/n1:entry/n1:asMedicalFee/..">
					<tr>
						<td codeSystem="{$CV07.10.001}">
							<xsl:value-of select="n1:asMedicalFee/n1:asMedicalFeeCode/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td codeSystem="{$CV07.10.003}">
							<xsl:value-of select="n1:asMedicalFee/n1:asMedicalPaymentCode/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td codeSystem="{$CV07.10.004}">
							<xsl:value-of select="n1:asMedicalFee/n1:asMedicalPaymentType/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asMedicalFee/n1:asMedicalPaymentType/n1:observation/n1:value/@value">
							</xsl:value-of>
							<xsl:value-of select="n1:asMedicalFee/n1:asMedicalPaymentType/n1:observation/n1:value/@currency">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>死亡章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>死亡原因: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[8]/n1:section/n1:entry/n1:observation/n1:code/@displayName">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>死亡时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[8]/n1:section/n1:entry/n1:observation/n1:effectiveTime/@value">
						</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
