<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:import href="util.xsl "/>
	<xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<xsl:template match="/">
		<html>
			<title>个人信息登记</title>
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
					<xsl:value-of select="n1:id/@extension"/>
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
				<td codeSystem="{$GBT2261.1}" width="25%" align="right">
					<b>
						<xsl:text>性别: </xsl:text>
					</b>
				</td>
				<td width="25%">
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
					<xsl:value-of select="n1:telecom[@code='DE02.01.010.00']/@value">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>邮箱: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:telecom[@code='DE02.01.012.00']/@value">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td codeSystem="{$GBT2261.2}" width="10%">
					<b>
						<xsl:text>婚姻状况: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:patient/n1:maritalStatusCode[@codeSystem='SD.11.3.5']/@displayName">
						</xsl:value-of>
				</td>
				<td codeSystem="{$GB3304}" width="25%" align="right">
					<b>
						<xsl:text>民族类别: </xsl:text>
					</b>
				</td>
				<td width="25%">
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
				<td codeSystem="{$GBT4658}" width="25%" align="right">
					<b>
						<xsl:text>患者学历: </xsl:text>
					</b>
				</td>
				<td width="25%">
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
				<td width="40%">
					<xsl:value-of select="n1:patient/n1:occupationCode/n1:value[@codeSystem='SD.11.3.7']/@displayName">
						</xsl:value-of>
				</td>
				<td codeSystem="{$GBT2260}" width="25%" align="right">
					<b>
						<xsl:text>患者所在行政区划: </xsl:text>
					</b>
				</td>
				<td width="25%">
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
					<xsl:value-of select="n1:patient/n1:id/@extension">
						</xsl:value-of>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!--个人建档信息-->
	<xsl:template match="/n1:ClinicalDocument/n1:author[1]/n1:assignedAuthor">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>建档信息</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>建档人员: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:assignedAuthorChoice/n1:assignedPerson/n1:name/@literal"/>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>建档时间: </xsl:text>
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
						<xsl:text>建档机构名称: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:representedOrganization/n1:name/@literal">
							</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>建档机构地址: </xsl:text>
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
					<xsl:value-of select="/n1:ClinicalDocument/n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:telecom/@value">
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
	</xsl:template>
	<!--个人章节-->
	<xsl:template match="/n1:ClinicalDocument/n1:component/n1:structuredBody">
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>实验室章节</h3>
			<tr>
				<td codeSystem="{$CVO4.50.005}" width="10%">
					<b>
						<xsl:text>ABO血型: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[1]/n1:section/n1:entry/n1:organizer/n1:component[1]/n1:observation/n1:value[@codeSystem='SD.11.1.85']/@displayName"/>
				</td>
				<td codeSystem="" width="25%" align="right">
					<b>
						<xsl:text>Rh血型: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[1]/n1:section/n1:entry/n1:organizer/n1:component[2]/n1:observation/n1:value[@codeSystem='SD.11.2.1']/@displayName">
							</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>费用章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>医疗费用来源: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[2]/n1:section/n1:entry/n1:observation/n1:value[@codeSystem='SD.11.1.197']/@displayName">
						</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>药物过敏是章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>药物过敏: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[3]/n1:section/n1:entry/n1:act/n1:entryRelationship/n1:observation/n1:value[@codeSystem='SD.11.1.137']/@displayName">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>药物过敏时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[3]/n1:section/n1:entry/n1:act/n1:entryRelationship/n1:observation/n1:effectiveTime/@value">
						</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>职业病暴露史章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>职业暴露危险因素种类: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[2]/n1:observation/n1:value[@codeSystem='SD.11.1.31']/@displayName">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>有危害因素接触职业描述: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[3]/n1:observation/n1:text">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>从事有危害因素职业时长: </xsl:text>
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
						<xsl:text>职业暴露危险因素种类: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[5]/n1:observation/n1:value[@codeSystem='SD.11.2.45']/@displayName">
					</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>职业暴露危险因素名称: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[4]/n1:section/n1:entry[6]/n1:observation/n1:text">
							</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>既往病史章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>既往病史: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[5]/n1:section/n1:entry[1]/n1:observation/n1:value[@codeSystem='SD.11.1.12']/@displayName">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>发病时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[5]/n1:section/n1:entry[1]/n1:observation/n1:effectiveTime/n1:low/@value">
						</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>手术史: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[5]/n1:section/n1:entry[2]/n1:observation/n1:entryRelationship/n1:observation/n1:text">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>手术时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[5]/n1:section/n1:entry[2]/n1:observation/n1:effectiveTime/n1:low/@value">
						</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>外伤史: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[5]/n1:section/n1:entry[3]/n1:observation/n1:entryRelationship/n1:observation/n1:text">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>外伤时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[5]/n1:section/n1:entry[3]/n1:observation/n1:effectiveTime/n1:low/@value">
						</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>输血史: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[5]/n1:section/n1:entry[4]/n1:observation/n1:entryRelationship/n1:observation/n1:text">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>输血时间: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="date" select="n1:component[5]/n1:section/n1:entry[4]/n1:observation/n1:effectiveTime/n1:low/@value">
						</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>家族史章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>家庭关系: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[6]/n1:section/n1:entry/n1:organizer/n1:subject/n1:relatedSubject/n1:code[@codeSystem='SD.11.3.8']/@displayName">
						</xsl:value-of>
				</td>
				<td codeSystem="{$GB3304}" width="25%" align="right">
					<b>
						<xsl:text>关系人性别: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[6]/n1:section/n1:entry/n1:organizer/n1:subject/n1:relatedSubject/n1:subject/n1:administrativeGenderCode[@codeSystem='SD.11.3.4']/@displayName">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>既往常见病史: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[6]/n1:section/n1:entry/n1:organizer/n1:component/n1:observation/n1:value[@codeSystem='SD.11.1.12']/@displayName">
						</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>遗传病史章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>遗传病名称: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[7]/n1:section/n1:entry/n1:observation/n1:value">
						</xsl:value-of>
				</td>
			</tr>
		</table>
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>残疾史章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>残疾情况: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[8]/n1:section/n1:entry/n1:observation/n1:value/@displayName">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>残疾时间: </xsl:text>
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
		<br/>
		<table border="{$border}" class="{$className}" style="{$tableWidth}">
			<h3>家庭生活章节</h3>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>家庭厨房排风设施类别: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[1]/n1:observation/n1:value[@codeSystem='SD.11.2.41']/@displayName">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>家庭燃料类型类别类别: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[2]/n1:observation/n1:value[@codeSystem='SD.11.2.42']/@displayName">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>家庭饮水类别: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[3]/n1:observation/n1:value[@codeSystem='SD.11.2.43']/@displayName">
						</xsl:value-of>
				</td>
				<td width="25%" align="right">
					<b>
						<xsl:text>家庭厕所类别: </xsl:text>
					</b>
				</td>
				<td width="25%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[4]/n1:observation/n1:value[@codeSystem='SD.11.2.44']/@displayName">
						</xsl:value-of>
				</td>
			</tr>
			<tr>
				<td width="10%">
					<b>
						<xsl:text>家庭禽畜栏类别: </xsl:text>
					</b>
				</td>
				<td width="40%">
					<xsl:value-of select="n1:component[9]/n1:section/n1:entry[5]/n1:observation/n1:value[@codeSystem='SD.11.2.2']/@displayName">
						</xsl:value-of>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
