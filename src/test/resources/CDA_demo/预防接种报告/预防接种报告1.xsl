<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:import href="../util.xsl "/>
	<xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<xsl:template match="/">
		<html>
			<title>预防接种报告</title>
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
				<td width="40%">
					<xsl:call-template name="IdSplit">
						<xsl:with-param name="id" select="n1:patient/n1:id/@extension"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>患者职业: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT6565}" width="40%">
					<xsl:value-of select="n1:patient/n1:occupationCode/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>患者工作单位: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:patient/n1:asEmployeeJob/n1:name">
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
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>监护人信息</h3>
			<thead>
				<tr>
					<th>
						<h4>家庭关系</h4>
					</th>
					<th>
						<h4>监护人姓名</h4>
					</th>
					<th>
						<h4>监护人电话号码</h4>
					</th>
					<th>
						<h4>监护人工作单位地址</h4>
					</th>
					<th>
						<h4>监护人出生日期</h4>
					</th>
					<th>
						<h4>监护人工作单位名称</h4>
					</th>
					<th>
						<h4>监护人证件号码</h4>
					</th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:guardian/n1:asGuardian/..">
					<tr>
						<td>
							<xsl:value-of select="n1:asGuardian/n1:code/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asGuardian/n1:guardianChoice/n1:guardianPerson/n1:name">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asGuardian/n1:telecom/n1:value/@value">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asGuardian/n1:addr/n1:streetName/@literal">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:asGuardian/n1:guardianChoice/n1:guardianPerson/n1:asGuardianBirthTime/@value"/>
							</xsl:call-template>
						</td>
						<td>
							<xsl:value-of select="n1:asGuardian/n1:guardianChoice/n1:guardianPerson/n1:asEmployeeJob/n1:name/@literal">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="IdSplit">
								<xsl:with-param name="id" select="n1:asGuardian/n1:guardianChoice/n1:guardianPerson/n1:asRelationPersonIdent/n1:code/@code"/>
							</xsl:call-template>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	<!--个人建档信息-->
	<xsl:template match="/n1:ClinicalDocument/n1:author[1]/n1:assignedAuthor">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>报告</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>报告医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:assignedAuthorChoice/n1:assignedPerson/n1:name/@literal"/>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>报告时间: </xsl:text>
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
						<xsl:text>报告科室: </xsl:text>
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
			<h3>搬迁信息</h3>
			<thead>
				<tr>
					<th>
						<h4>迁入日期</h4>
					</th>
					<th>
						<h4>迁出日期</h4>
					</th>
					<th>
						<h4>迁出原因</h4>
					</th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[1]/n1:section/n1:entry/n1:asRelocation/..">
					<tr>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:asRelocation/n1:asIn/n1:observation/n1:value/@value"/>
							</xsl:call-template>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:asRelocation/n1:asOut/n1:observation/n1:value/@value"/>
							</xsl:call-template>
						</td>
						<td>
							<xsl:value-of select="n1:asRelocation/n1:asOutReason/n1:observation/n1:value">
								</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>新生儿过往史信息</h3>
			<thead>
				<tr>
					<th>
						<h4>疫苗异常反应史</h4>
					</th>
					<th>
						<h4>接种禁忌</h4>
					</th>
					<th>
						<h4>传染病史</h4>
					</th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[2]/n1:section/n1:entry/n1:asNeonatalHis/..">
					<tr>
						<td>	
							<xsl:value-of  select="n1:asNeonatalHis/n1:asVaccineReaction/n1:observation/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asNeonatalHis/n1:asVaccinationContrain/n1:observation/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asNeonatalHis/n1:asInfectiousHis/n1:observation/n1:text">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table >
			<h3>接种章节</h3>
			<table border="{$border}" class="{$className}" style="{$tableWidth}">
				
		
		
			<h4>接种信息</h4>
			<thead>
				<tr>
					<th><h4>接种状态</h4></th>
					<th><h4>接种剂次</h4></th>
					<th><h4>接种部位</h4></th>
					<th><h4>接种医生</h4></th>
					<th><h4>接种机构</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry/n1:procedure/..">
					<tr>
						<td>	
							<xsl:value-of  select="n1:procedure/n1:statusCode/n1:observation/n1:text">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:procedure/n1:priorityCode">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:procedure/n1:targetSiteCode">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:procedure/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:procedure/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
				</table>
				
				<table border="{$border}" class="{$className}" style="{$tableWidth}">
				
		
		
			<h4>接种药物信息</h4>
			<thead>
				<tr>
					<th><h4>疫苗编号</h4></th>
					<th><h4>疫苗名称</h4></th>
					<th><h4>疫苗有效期</h4></th>
					<th><h4>疫苗批号</h4></th>
					<th><h4>疫苗生产厂商</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/n1:entry/n1:substanceAdministration/..">
					<tr>
						<td>	
							<xsl:value-of  select="n1:substanceAdministration/n1:code[1]/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:name">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:substanceAdministration/n1:effectiveTime/@value"/>
							</xsl:call-template>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:code/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:manufacturedDrugOrOtherMaterial/n1:manufacturedLabeledDrug/n1:manufacturerOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
				</table>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">		
			<h3>接种不良反应信息</h3>
			<thead>
				<tr>
					<th><h4>不良反应诊断</h4></th>
					<th><h4>不良反应发生日期</h4></th>
					<th><h4>不良反应处理结果</h4></th>
					<th><h4>引起预防接种后不良反应的可疑疫苗名称代码</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry/n1:asInoculatedAdverseInfor/..">
					<tr>
						<td>	
							<xsl:value-of  select="n1:asInoculatedAdverseInfor/n1:asAdverseCode/n1:observation/n1:code/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:asInoculatedAdverseInfor/n1:asAdverseDate/n1:observation/n1:value/@value"/>
							</xsl:call-template>
						</td>
						<td>
							<xsl:value-of select="n1:asInoculatedAdverseInfor/n1:asAdverseResult/n1:observation/n1:value">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asInoculatedAdverseInfor/n1:adInoculatedAdverseCode/n1:observation/n1:value">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
				</table>
	</xsl:template>
</xsl:stylesheet>
