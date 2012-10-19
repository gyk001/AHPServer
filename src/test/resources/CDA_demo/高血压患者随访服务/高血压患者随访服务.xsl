<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:import href="../util.xsl "/>
	<xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<xsl:template match="/">
		<html>
			<title>高血压患者随访服务</title>
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
						<xsl:text>健康档案标识号: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="IdSplit">
						<xsl:with-param name="id" select="n1:id/@extension"/>
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
						<xsl:text>地址: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:addr/n1:state/@literal"/>
					<xsl:value-of select="n1:addr/n1:city/@literal"/>
					<xsl:value-of select="n1:addr/n1:county/@literal"/>
					<xsl:value-of select="n1:addr/n1:streetName/@literal"/>
					<xsl:value-of select="n1:addr/n1:houseNumber/@literal"/>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>邮政编码: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:addr/n1:postalCode/@literal"/>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>电话号码: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:telecom[1]/n1:value/@value">
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
						<xsl:text>婚姻状况: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT2261.2}" width="40%">
					<xsl:value-of select="n1:patient/n1:maritalStatusCode[@codeSystem='SD.11.3.5']/@displayName">
						</xsl:value-of>
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
						<xsl:text>患者学历: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT4658}" width="40%">
					<xsl:value-of select="n1:patient/n1:asEducationLevelCode/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>国籍: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:patient/n1:asNationality/n1:code/@displayName">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>职业: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT6565}" width="40%">
					<xsl:value-of select="n1:patient/n1:occupationCode/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>患者所在行政区划: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT2260}" width="25%">
					<xsl:value-of select="n1:patient/n1:asServiceDeliveryLocation/n1:location/n1:code/@displayName">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>医保卡号: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:patient/n1:asMedicalInsuranceCode[@codeSystem='SD.4.14']/@displayName">
						</xsl:value-of>
				</td>
				
			</tr>
		</table>
		<br/>
	</xsl:template>
<!--个人建档信息-->
	<xsl:template match="/n1:ClinicalDocument/n1:author[1]/n1:assignedAuthor">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>随访</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>随访医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:assignedAuthorChoice/n1:assignedPerson/n1:name/@literal"/>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>随访时间: </xsl:text>
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
						<xsl:text>随访科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>上报机构: </xsl:text>
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
						<xsl:text>文档管理机构名称: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="/n1:ClinicalDocument/n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name/@literal">
							</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>文档管理机构电话号码: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="/n1:ClinicalDocument/n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:telecom/n1:value/@value">
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
	</xsl:template>
	<!--个人章节-->
	<xsl:template match="/n1:ClinicalDocument/n1:component/n1:structuredBody">	
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>随访事件章节</h3>
			<thead>
				<tr>
					<th><h4>随访时间</h4></th>
					<th><h4>随访方式</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[1]/n1:section/n1:entry/n1:asFollowupEvent/..">				
					<tr>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:asFollowupEvent/n1:asFollowupType/n1:observation/n1:effectiveTime/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td codeSystem="{$CV06.00.207}">
							<xsl:value-of select="n1:asFollowupEvent/n1:asFollowupType/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>症状章节</h3>
			<thead>
				<tr>
					<th><h4>症状代码</h4></th>	
					<th><h4>症状描述</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[2]/n1:section/n1:entry/n1:asDiabetesSymbo/..">				
					<tr>
						<td codeSystem="{$ICD10R}">
							<xsl:value-of select="n1:asDiabetesSymbo/n1:asDiabetesSymboCode/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asDiabetesSymbo/n1:asDiabetesSymboName/n1:observation/n1:text">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>生命体征章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>收缩压: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[1]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[1]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>舒张压：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[2]/n1:observation/n1:value/@unit">
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
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>体质指数：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>心率: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[5]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[5]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>其他阳性体征：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[6]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>生活方式章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>日吸烟量: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[1]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[1]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>日饮酒量：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[2]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>锻炼频率: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[3]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>每次锻炼时间：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>摄盐情况: </xsl:text>
					</b>
				</td>
				<td codeSystem="{}" width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[5]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>心理调整：</xsl:text>
					</b>
				</td>
				<td codeSystem="{}" width="25%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[6]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>遵医行为: </xsl:text>
					</b>
				</td>
				<td codeSystem="{}" width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[7]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>检查章节</h3>
			<thead>
				<tr>
					<th><h4>辅助检查项目</h4></th>
					<th><h4>检查时间</h4></th>
					<th><h4>辅助检查结果</h4></th>
					<th><h4>检查人员</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry/n1:asLaboratoryTest/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:asLaboratoryTest/n1:asSupplementalTest/n1:observation/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:asLaboratoryTest/n1:asSupplementalTest/n1:observation/n1:effectiveTime/@value"/>
							</xsl:call-template>
						</td>
						<td>
							<xsl:value-of select="n1:asLaboratoryTest/n1:asSupplementalResult/n1:observation/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asLaboratoryTest/n1:asSupplementalTest/n1:observation/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>用药章节</h3>
			<thead>
				<tr>
					<th><h4>药品名称</h4></th>
					<th><h4>用药途径</h4></th>
					<th><h4>用药剂量-单次</h4></th>
					<th><h4>用药频率</h4></th>
					<th><h4>服药依存性</h4></th>
					<th><h4>药物不良反应</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[6]/n1:section/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:section/n1:entry/n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:manufacturedLabeledDrug/n1:name">
							</xsl:value-of>
						</td>
						<td codeSystem="{$CV06.00.102}">
							<xsl:value-of select="n1:section/n1:entry/n1:substanceAdministration/n1:routeCode/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:section/n1:entry/n1:substanceAdministration/n1:doseQuantity/@value">
							</xsl:value-of>
							<xsl:value-of select="n1:section/n1:entry/n1:substanceAdministration/n1:doseQuantity/@unit">
							</xsl:value-of>							
						</td>
						<td>
							<xsl:value-of select="n1:section/n1:entry/n1:substanceAdministration/n1:rateQuantity/@value">
							</xsl:value-of>
							<xsl:value-of select="n1:section/n1:entry/n1:substanceAdministration/n1:rateQuantity/@unit">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:section/n1:entry/n1:substanceAdministration/n1:entryRelationship[1]/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:section/n1:entry/n1:substanceAdministration/n1:entryRelationship[2]/n1:observation/n1:text">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>随访评估章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>随访评价结果: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV05.10.012}" width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>转诊章节</h3>
			<thead>
				<tr>
					<th><h4>转诊原因</h4></th>
					<th><h4>转诊时间</h4></th>
					<th><h4>转诊科室</h4></th>
					<th><h4>转诊医院</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[8]/n1:section/n1:entry/n1:observation/n1:entryRelationship/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:entryRelationship/n1:act/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:entryRelationship/n1:act/n1:performer/n1:time/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td>
							<xsl:value-of select="n1:entryRelationship/n1:act/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:entryRelationship/n1:act/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:asOrganizationPartOf/n1:wholeOrganization/n1:name">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>下次随访安排</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>下次随访日期: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[9]/n1:section/n1:entry/n1:observation/n1:effectiveTime/@value">
						</xsl:with-param>
					</xsl:call-template>	
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
