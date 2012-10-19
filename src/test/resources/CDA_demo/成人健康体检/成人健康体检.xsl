<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:import href="../util.xsl "/>
	<xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<xsl:template match="/">
		<html>
			<title>成人健康体检</title>
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
						<xsl:text>邮箱: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:telecom[2]/@value">
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
						<xsl:text>患者出生地: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:patient/n1:birthplace/n1:place/n1:addr/n1:city/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>患者学历: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT4658}" width="25%">
					<xsl:value-of select="n1:patient/n1:asEducationLevelCode/n1:value[@code='17']/@displayName">
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
						<xsl:text>国籍: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:patient/n1:asNationality/n1:code/@displayName">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>患者职业: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$GBT6565}" width="40%">
					<xsl:value-of select="n1:patient/n1:occupationCode/n1:value[@codeSystem='SD.11.3.7']/@displayName">
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
						<xsl:text>患者身份证号: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:call-template name="IdSplit">
						<xsl:with-param name="id" select="n1:patient/n1:id/@extension"/>
					</xsl:call-template>
				</td>
			</tr>
		</table>
		<br/>
	</xsl:template>
	
	<!--个人建档信息-->
	<xsl:template match="/n1:ClinicalDocument/n1:author[1]/n1:assignedAuthor">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>建档信息</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查人员: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:assignedAuthorChoice/n1:assignedPerson/n1:name/@literal"/>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
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
						<xsl:text>检查科室名称: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查科室地址: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:representedOrganization/n1:addr/n1:city/@literal">
							</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>上报机构名称: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="/n1:ClinicalDocument/n1:author[2]/n1:assignedAuthor/n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>上报机构地址: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="/n1:ClinicalDocument/n1:author[2]/n1:assignedAuthor/n1:representedOrganization/n1:addr/n1:streetName/@literal">
							</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>上报系统名称: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="/n1:ClinicalDocument/n1:author[2]/n1:assignedAuthor/n1:assignedAuthoringDevice/n1:code/@extension">
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
					<xsl:value-of select="/n1:ClinicalDocument/n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:addr/n1:streetName/@literal">
							</xsl:value-of>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!--个人章节-->
	<xsl:template match="/n1:ClinicalDocument/n1:component/n1:structuredBody">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>病症章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>症状代码: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$ICD10R}" width="40%">
					<xsl:value-of select="n1:component[1]/n1:section/n1:entry/n1:observation/n1:value[@codeSystem='SD.11.4.1']/@code"/>
				</td>
				<td codeSystem="" width="25%" align="right">
					<b>
						<xsl:text>症状描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[1]/n1:section/n1:entry/n1:observation/n1:text">
							</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>生命体征章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[2]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
					
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>身高: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[2]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>体重：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>体重指数: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>腰围：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[5]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[5]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>臀围: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[6]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[6]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>腰臀比例：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[7]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[7]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>体质指数: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[8]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[8]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>体温：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[9]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[9]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>皮肤巩膜检查结果: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[10]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[10]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>脉率：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[11]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[11]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>呼吸频次: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[12]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[12]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>左侧收缩压：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[13]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[13]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>右侧收缩压: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[14]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[14]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>左侧舒张压：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[15]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[15]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>右侧舒张压: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[16]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[16]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>心率：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[17]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[17]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>一秒钟用力呼气量: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[18]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[18]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>一秒钟用力呼气量/最大肺活量比值：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[19]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[19]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>六分钟步行距离: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[20]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry[20]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>口腔、咽喉和牙齿章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[3]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>口唇外观检查结果: </xsl:text>
					</b>
				</td>
				<td width="40%" codeSystem="{$CV04.10.007}">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[2]/n1:observation/n1:value[@codeSystem='SD.11.1.61']/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>口唇紫绀标志：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>齿列类别: </xsl:text>
					</b>
				</td>
				<td width="40%" codeSystem="{$CV04.10.010}">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[4]/n1:observation/n1:value[@codeSystem='SD.11.1.64']/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>齿列描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[5]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>咽部检查结果: </xsl:text>
					</b>
				</td>
				<td width="40%" codeSystem="">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[6]/n1:observation/n1:value[@codeSystem='SD.11.2.6']/@displayName">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>咳嗽标志：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[7]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>咳痰标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[8]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>哮鸣音种类代码：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry[9]/n1:observation/n1:value">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>眼章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[4]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>左眼裸眼远视力值: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[2]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>左眼矫正远视力值：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>右眼矫正远视力值: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>眼底检查结果异常标志：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[5]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>眼底检查结果异常描述: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[6]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>巩膜检查结果代码：</xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.006}" width="25%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[7]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>耳章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[5]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[5]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[5]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>听力检测结果: </xsl:text>
					</b>
				</td>
				<td codeSystem="" width="40%">
					<xsl:value-of select="n1:component[5]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>胸章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[6]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[6]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[6]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>胸廓类别: </xsl:text>
					</b>
				</td>
				<td codeSystem="" width="40%">
					<xsl:value-of select="n1:component[6]/n1:section/n1:entry[2]/n1:observation/n1:value">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>腹部章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[7]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>腹部压痛标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>腹部压痛描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[3]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>腹部包块标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>腹部包块描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[5]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>腹部移动性浊音标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[6]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>腹部移动性浊音描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[7]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>肝大标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[8]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>肝大描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[9]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>脾大标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[10]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>脾大描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[11]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>肾区叩痛标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry[12]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>功能检查章节</h3>
						<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[8]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[8]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[8]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>运动功能状态: </xsl:text>
					</b>
				</td>
				<td codeSystem="" width="40%">
					<xsl:value-of select="n1:component[8]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>心脏章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[9]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>心率类别: </xsl:text>
					</b>
				</td>
				<td codeSystem="" width="40%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>心脏杂音标志：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>心脏杂音描述: </xsl:text>
					</b>
				</td>
				<td codeSystem="" width="40%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[4]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>血管章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[10]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[10]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[10]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>足背动脉搏动: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.015}" width="40%">
					<xsl:value-of select="n1:component[10]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>颈静脉怒张标志：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[10]/n1:section/n1:entry[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>呼吸系统章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[11]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>肺部异常呼吸音标志: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.015}" width="40%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>肺部异常呼吸音描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[3]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>肺部罗音标志: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.015}" width="40%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>肺部罗音描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[5]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>肺部罗音标志: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.015}" width="40%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>肺部罗音描述：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[5]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>桶状胸标志: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.015}" width="40%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[6]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>呼吸困难症状类别：</xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[11]/n1:section/n1:entry[7]/n1:observation/n1:value">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>皮肤系统章节</h3>
						<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[12]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[12]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[12]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>皮肤检查结果: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.004}" width="40%">
					<xsl:value-of select="n1:component[12]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>淋巴系统章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[13]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[13]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[13]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>淋巴结检查结果: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.011}" width="40%">
					<xsl:value-of select="n1:component[13]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>淋巴结检查结果描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[13]/n1:section/n1:entry[3]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>四肢章节</h3>
						<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[14]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[14]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[14]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>下肢水肿检查结果: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.014}" width="40%">
					<xsl:value-of select="n1:component[14]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>直肠章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[15]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[15]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[15]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>肛门指诊检查结果: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.013}" width="40%">
					<xsl:value-of select="n1:component[15]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>肛门指诊检查结果异常描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[15]/n1:section/n1:entry[3]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>前列腺章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[16]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[16]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[16]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>前列腺异常标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[16]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>前列腺异常描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[16]/n1:section/n1:entry[3]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>乳腺章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[17]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[17]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[17]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>乳腺检查结果: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.10.012}" width="40%">
					<xsl:value-of select="n1:component[17]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>生殖器章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[18]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>外阴异常标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>外阴异常描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[3]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>阴道异常标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>阴道异常描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[5]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>宫颈异常标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[6]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>宫颈异常描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[7]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
				<tr>
				<td width="10%">
					<b>
						<xsl:text>宫体异常标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[8]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>宫体异常描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[9]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
				<tr>
				<td width="10%">
					<b>
						<xsl:text>附件异常标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[10]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>附件异常描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[18]/n1:section/n1:entry[11]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>实验室章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[19]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			
			<tr align="left">
				<th><h4>血常规</h4></th>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>血氧饱和度: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[2]/n1:organizer/n1:component[1]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[2]/n1:organizer/n1:component[1]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>血红蛋白: </xsl:text>
					</b>
				</td>
				<td width="25%">
						<xsl:value-of select="n1:component[19]/n1:section/n1:entry[2]/n1:organizer/n1:component[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[2]/n1:organizer/n1:component[2]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>白细胞: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[2]/n1:organizer/n1:component[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[2]/n1:organizer/n1:component[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>血小板: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[2]/n1:organizer/n1:component[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[2]/n1:organizer/n1:component[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
		
			<tr align="left">
				<th><h4>尿常规</h4></th>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>尿比重: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[1]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[1]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>尿蛋白: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.50.015}" width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[2]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>尿蛋白定量检测值: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>尿糖: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>尿酮体: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[5]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[5]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>尿潜血: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[6]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[6]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>尿液酸碱度: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[7]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[3]/n1:organizer/n1:component[7]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			
			<tr align="left">
				<th><h4>肝功能</h4></th>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>血清谷丙转氨酶: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[1]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[1]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>血清谷草转氨酶: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[2]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>白蛋白: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>总胆红素: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>结合胆红素: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[5]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[4]/n1:organizer/n1:component[5]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			
			<tr align="left">
				<th><h4>肾功能</h4></th>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>血清肌酐: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[5]/n1:organizer/n1:component[1]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[5]/n1:organizer/n1:component[1]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>血尿素氮: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[5]/n1:organizer/n1:component[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[5]/n1:organizer/n1:component[2]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>血钾浓度: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[5]/n1:organizer/n1:component[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[5]/n1:organizer/n1:component[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>血钠浓度: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[5]/n1:organizer/n1:component[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[5]/n1:organizer/n1:component[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
		
			<tr align="left">
				<th><h4>血脂</h4></th>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>总胆固醇: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[6]/n1:organizer/n1:component[1]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[6]/n1:organizer/n1:component[1]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>甘油三酯: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[6]/n1:organizer/n1:component[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[6]/n1:organizer/n1:component[2]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>血清低密度酯蛋白胆固醇: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[6]/n1:organizer/n1:component[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[6]/n1:organizer/n1:component[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>血清高密度酯蛋白胆固醇: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[6]/n1:organizer/n1:component[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[6]/n1:organizer/n1:component[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			
			<tr align="left">
				<th><h4>乙型肝炎病毒</h4></th>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>乙型肝炎表面抗原: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[7]/n1:organizer/n1:component[1]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>乙型肝炎表面抗体: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[7]/n1:organizer/n1:component[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>乙型肝炎e抗原: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[7]/n1:organizer/n1:component[3]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>乙型肝炎e抗体: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[7]/n1:organizer/n1:component[4]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>乙型肝炎核心抗体: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[7]/n1:organizer/n1:component[5]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
			
			<tr align="left">
				<th><h4>血型</h4></th>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>ABO血型: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.50.005}" width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[8]/n1:organizer/n1:component[1]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>Rh血型: </xsl:text>
					</b>
				</td>
				<td codeSystem="" width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[8]/n1:organizer/n1:component[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
			
			<tr align="left">
				<th><h4>阴道分泌物</h4></th>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>阴道分泌物: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.50.019}" width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[9]/n1:organizer/n1:component[1]/n1:observation/n1:value/@code">
					</xsl:value-of>
					
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>其他解释: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[9]/n1:organizer/n1:component[1]/n1:observation/n1:value[2]">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>阴道清洁度: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV04.50.010}" width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[9]/n1:organizer/n1:component[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
			
			<tr align="left">
				<th><h4>其他项目</h4></th>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>空腹血糖: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[10]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[10]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>餐后两小时血糖: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[11]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[11]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td codeSystem="" width="10%">
					<b>
						<xsl:text>梅毒血清学试验: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[12]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>抗体检测: </xsl:text>
					</b>
				</td>
				<td codeSystem="" width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[13]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>甲胎蛋白值: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[14]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[14]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>癌胚抗原浓度值: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[15]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[19]/n1:section/n1:entry[15]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>辅助检查章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查医生: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[20]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>检查时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[20]/n1:section/n1:entry[1]/n1:performer/n1:time/@value"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>检查科室: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[20]/n1:section/n1:entry[1]/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>胸部X线: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[20]/n1:section/n1:entry[2]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>胸部X线补充说明: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[20]/n1:section/n1:entry[2]/n1:observation/n1:value">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>心电图: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[20]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>B超: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[20]/n1:section/n1:entry[5]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>宫颈涂片: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[20]/n1:section/n1:entry[6]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table>
			
			<h3>诊断章节</h3>
			<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h4>诊断人员信息</h4>
			<thead>
				<tr>
					<th><h4>诊断医生</h4></th>
					<th><h4>诊断时间</h4></th>
					<th><h4>诊断机构</h4></th>
				
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[21]/n1:section/n1:entry/n1:performer/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:performer/n1:time/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td>
							<xsl:value-of select="n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h4>诊断信息</h4>
			<thead>
				<tr>
					
					<th><h4>现存主要健康问题</h4></th>
					<th><h4>中医体质分类</h4></th>
					<th><h4>中医体质分类判定结果</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[21]/n1:section/n1:entry/n1:asDiagnose/..">				
					<tr>
						
						<td codeSystem="{$ICD10R}">
							<xsl:value-of select="n1:asDiagnose/n1:asDiagnoseCode/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td codeSystem="{$CV05.01.005}">
							<xsl:value-of select="n1:asDiagnose/n1:asTMC/n1:observation/n1:value/@code">
							</xsl:value-of>								
						</td>
						<td codeSystem="">
							<xsl:value-of select="n1:asDiagnose/n1:asTMCResult/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
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
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[22]/n1:section/n1:entry/n1:substanceAdministration/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:manufacturedLabeledDrug/n1:name">
							</xsl:value-of>
						</td>
						<td codeSystem="{$CV06.00.102}">
							<xsl:value-of select="n1:substanceAdministration/n1:routeCode/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:doseQuantity/@value">
							</xsl:value-of>
							<xsl:value-of select="n1:substanceAdministration/n1:doseQuantity/@unit">
							</xsl:value-of>							
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:rateQuantity/@value">
							</xsl:value-of>
							<xsl:value-of select="n1:substanceAdministration/n1:rateQuantity/@unit">
							</xsl:value-of>
						</td>
						<td codeSystem="{}">
							<xsl:value-of select="n1:substanceAdministration/n1:entryRelationship[1]/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:entryRelationship[2]/n1:observation/n1:text">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>家族史章节</h3>
			<thead>
				<tr>
					<th><h4>家庭关系</h4></th>
					<th><h4>性别</h4></th>
					<th><h4>既往常见病史</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[23]/n1:section/n1:entry/n1:organizer/..">				
					<tr>
						<td codeSystem="{$GBT4761}">
							<xsl:value-of select="n1:organizer/n1:subject/n1:relatedSubject/n1:code/@code">
							</xsl:value-of>
						</td>
						<td codeSystem="{$GBT2261.1}">
							<xsl:value-of select="n1:organizer/n1:subject/n1:relatedSubject/n1:subject/n1:administrativeGenderCode/@code">
							</xsl:value-of>								
						</td>
						<td codeSystem="{$CV02.10.005}">
							<xsl:value-of select="n1:organizer/n1:component/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>住院史章节</h3>
			<thead>
				<tr>
					<th><h4>入院时间</h4></th>
					<th><h4>出院时间</h4></th>
					<th><h4>医院名称</h4></th>
					<th><h4>住院原因</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[24]/n1:section/n1:entry/n1:encounter/..">				
					<tr>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:encounter/n1:effectiveTime/n1:low/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:encounter/n1:effectiveTime/n1:high/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td>
							<xsl:value-of select="n1:encounter/n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name">
							</xsl:value-of>								
						</td>
						<td>
							<xsl:value-of select="n1:encounter/n1:entryRelationship/n1:observation/n1:value">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table>	
		<h3>非免疫规划预防接种史章节</h3>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h4>接种人员信息</h4>
			<thead>
				<tr>
					<th><h4>接种医生</h4></th>
					<th><h4>接种时间</h4></th>
					<th><h4>接种科室</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[25]/n1:section/n1:entry/n1:performer/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:performer/n1:time/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td>
							<xsl:value-of select="n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>
						
					</tr>
				</xsl:for-each>
			</tbody>
		</table>		
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h4>疫苗信息</h4>
			<thead>
				<tr>
					
					<th><h4>疫苗名称</h4></th>
					<th><h4>免疫剂次</h4></th>
					<th><h4>接种部位</h4></th>
					<th><h4>疫苗批次</h4></th>
					<th><h4>疫苗的生产厂家</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[25]/n1:section/n1:entry/n1:substanceAdministration/..">	
					<tr>
						<td codeSystem="{$CV08.50.001}">
							<xsl:value-of select="n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:manufacturedMaterial/n1:name">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:repeatNumber/@value">
							</xsl:value-of>								
						</td>
						<td codeSystem="{$ICD9CM}">
							<xsl:value-of select="n1:substanceAdministration/n1:approachSiteCode/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:manufacturedMaterial/n1:lotNumberText">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:manufacturerOrganization/n1:name">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>职业暴露史章节</h3>
			<thead>
				<tr align="left">
					<th><h4>职业暴露危险因素种类</h4></th>
				</tr>
			</thead>
			<tbody align="left">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[26]/n1:section/n1:entry/n1:asOccupationExposure/..">	
					<tr>
						<td codeSystem="{$CV03.00.203}">
							<xsl:value-of select="n1:asOccupationExposure/n1:asOccupationExposureType/n1:observation/n1:value/@code">
							</xsl:value-of>								
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>生活方式章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>锻炼频率: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV03.00.111}" width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[2]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>每次锻炼时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[3]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[3]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>坚持锻炼时间: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[4]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[4]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>锻炼方式: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[5]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>饮食习惯: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV03.00.107}" width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[6]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>吸烟状况: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[7]/n1:observation/n1:text">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>日吸烟量: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[8]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[8]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>开始吸烟年龄: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[9]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[9]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>戒烟年龄: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[10]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[10]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>饮酒频率: </xsl:text>
					</b>
				</td>
				<td codesystem="{$CV03.00.104}" width="25%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[11]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>日饮酒量: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[12]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[12]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>开始饮酒年龄: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[13]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[13]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>			
			<tr>
				<td width="10%">
					<b>
						<xsl:text>醉酒标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[14]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>饮酒种类: </xsl:text>
					</b>
				</td>
				<td codeSystem="{$CV03.00.105}" width="25%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[15]/n1:observation/n1:value/@code">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>戒酒标志: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[16]/n1:observation/n1:value/@value">
					</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>戒酒年龄: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[17]/n1:observation/n1:value/@value">
					</xsl:value-of>
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[17]/n1:observation/n1:value/@unit">
					</xsl:value-of>
				</td>
			</tr>	
			<tr>
				<td width="10%">
					<b>
						<xsl:text>生活质量: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[27]/n1:section/n1:entry[18]/n1:observation/n1:value/@literal">
					</xsl:value-of>
				</td>
			</tr>							
		</table>
		<br/>
		<table>
		
		<h3>健康评估章节</h3>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h4>评估人员信息</h4>
			<thead>
				<tr>
					<th><h4>评估医生</h4></th>
					<th><h4>评估时间</h4></th>
					<th><h4>评估机构</h4></th>
					
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[28]/n1:section/n1:entry/n1:performer/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:performer/n1:time/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td>
							<xsl:value-of select="n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
			</table>
			<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h4>评估信息</h4>
			<thead>
				<tr>
					<th><h4>老年人健康状态自我评估</h4></th>
					<th><h4>老年人生活自理能力评估</h4></th>
					<th><h4>老年人认知状态粗筛结果分类</h4></th>
					<th><h4>老年人认知功能评分</h4></th>
					<th><h4>老年人情感状态粗筛结果</h4></th>
					<th><h4>老年人抑郁评分</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[28]/n1:section/n1:entry/n1:asHealthAssessment/..">		
					<tr>		
						<td codeSystem="{$CV04.01.013}">
							<xsl:value-of select="n1:asHealthAssessment/n1:asHealthAssessmentStatus/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td codeSystem="{$CV04.01.014}">
							<xsl:value-of select="n1:asHealthAssessment/n1:asLivingSkill/n1:observation/n1:value/@code">
							</xsl:value-of>								
						</td>
						<td codeSystem="">
							<xsl:value-of select="n1:asHealthAssessment/n1:asAcknowledge/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asHealthAssessment/n1:asAcknowledge/n1:observation/n1:entryRelationship/n1:observation/n1:value/@value">
							</xsl:value-of>
						</td>
						<td codeSystem="">
							<xsl:value-of select="n1:asHealthAssessment/n1:asEmotionalDistress/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td>
							<xsl:value-of select="n1:asHealthAssessment/n1:asEmotionalDistress/n1:observation/n1:entryRelationship/n1:observation/n1:value/@value">
							</xsl:value-of>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
		</table>
		<br/>
		<table>
			<h3>健康指导章节</h3>
		
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h4>指导人员信息</h4>
			<thead>
				<tr>
					<th><h4>指导医生</h4></th>
					<th><h4>指导时间</h4></th>
					<th><h4>指导机构</h4></th>	
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[29]/n1:section/n1:entry/n1:performer/..">				
					<tr>
						<td>
							<xsl:value-of select="n1:performer/n1:assignedEntity/n1:assignedPerson/n1:name/@literal">
							</xsl:value-of>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="n1:performer/n1:time/@value">
								</xsl:with-param>
							</xsl:call-template>								
						</td>
						<td>
							<xsl:value-of select="n1:performer/n1:assignedEntity/n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
						</td>	
					</tr>
				</xsl:for-each>
			</tbody>	
		</table>
			<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h4>指导信息</h4>
			<thead>
				<tr>
					
					<th><h4>健康指导</h4></th>
					<th><h4>危险因素控制建议</h4></th>
				</tr>
			</thead>
			<tbody align="center">
				<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[29]/n1:section/n1:entry/n1:asHealthGuidance/..">				
					<tr>
					
						<td codeSystem="">
							<xsl:value-of select="n1:asHealthGuidance/n1:asHealthGuidanceCode/n1:observation/n1:value/@code">
							</xsl:value-of>
						</td>
						<td codeSystem="{$CV06.00.218}">
							<xsl:value-of select="n1:asHealthGuidance/n1:asRiskFactors/n1:observation/n1:value/@code">
							</xsl:value-of>								
						</td>
					</tr>
				</xsl:for-each>
			</tbody>	
		</table>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>体检结果章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>体检结果: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[30]/n1:section/n1:entry/n1:observation/n1:value/@literal">
					</xsl:value-of>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
