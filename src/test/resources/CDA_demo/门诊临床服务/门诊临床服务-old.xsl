<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<!-- CDA document -->
	<xsl:variable name="tableWidth">50%</xsl:variable>
	<xsl:variable name="title">
		<xsl:choose>
			<xsl:when test="/n1:ClinicalDocument/n1:title">
				<xsl:value-of select="/n1:ClinicalDocument/n1:title"/>
			</xsl:when>
			<xsl:otherwise>Clinical Document</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--<xsl:template match="/">
		<xsl:apply-templates select="n1:ClinicalDocument"/>
	</xsl:template>-->
	<xsl:template match="n1:ClinicalDocument">
		<html>
			<head>
				<!-- <meta name='Generator' content='&CDA-Stylesheet;'/> -->
				<xsl:comment>
                        Do NOT edit this HTML directly, it was generated via an XSLt
                        transformation from the original release 2 CDA Document.
                </xsl:comment>
				<title>
					<xsl:value-of select="$title"/>
				</title>
			</head>
			<xsl:comment>				
              Derived from HL7 Finland R2 Tyylitiedosto: Tyyli_R2_B3_01.xslt Updated by   Calvin E. Beebe,   Mayo Clinic - Rochester Mn.
        </xsl:comment>
			<body>
				<h2 align="center">
					<xsl:value-of select="$title"/>
				</h2>
				<table width="100%" border="1">
					<h3>患者信息</h3>
					<tr>
						<td width="10%">
							<big>
								<b>
									<xsl:text>患者: </xsl:text>
								</b>
							</big>
						</td>
						<td width="40%" styleCode="Bold">
							<big >
								<xsl:call-template name="getName">
									<xsl:with-param name="name" select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:name"/>
								</xsl:call-template>
							</big>
						</td>
						<td width="25%" align="right" >
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
				</table>
				<br/>
				<table width="100%" border="1">
					<h3>接诊信息</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>接诊医师: </xsl:text>
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
								<xsl:text>接诊时间: </xsl:text>
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
								<xsl:text>就诊科室名称: </xsl:text>
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
				</table>
				<br/>
				<table width="100%" border="1">
					<h3>病症章节</h3>
					<thead>
						<tr>
							<th><h4>病症</h4></th>
							<th><h4>病症开始时间</h4></th>
							<th><h4>病症持续时间</h4></th>
						</tr>
					</thead>
					<tbody align="center">
						<xsl:for-each select="/n1:component[1]/n1:section/..">				
							<tr>
								<td>
									<xsl:value-of select="n1:section/n1:entry[1]/n1:observation/n1:value[@codeSystem='SD.11.4.1']/@displayName">
									</xsl:value-of>
								</td>
								<td>
									<xsl:call-template name="formatDate">
										<xsl:with-param name="date" select="n1:section/n1:entry[2]/n1:observation/n1:value/@value">
										</xsl:with-param>
									</xsl:call-template>								
								</td>
								<td>
									<xsl:value-of select="n1:section/n1:entry[3]/n1:observation/n1:value/@value"/>
									<xsl:value-of select="n1:section/n1:entry[3]/n1:observation/n1:value/@unit"/>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<br/>
				<table width="100%" border="1">
					<h3>检查章节</h3>
					<thead>
						<tr>
							<th><h4>检查项目</h4></th>
							<th><h4>检查结果</h4></th>
						</tr>
					</thead>
					<tbody align="center">
						<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[2]/n1:section/..">
							<tr>
								<td>
									<xsl:value-of select="n1:section/n1:entry[1]/n1:observation/n1:text">
									</xsl:value-of>
								</td>
								<td>
									<xsl:value-of select="n1:section/n1:entry[2]/n1:observation/n1:text">
									</xsl:value-of>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<br/>
				<table width="100%" border="1">
					<h3>诊断记录</h3>
					<thead>
						<tr>
							<th><h4>诊断名称</h4></th>
							<th><h4>诊断时间</h4></th>
						</tr>
					</thead>
					<tbody align="center">
						<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[3]/n1:section/..">
							<tr>
								<td>
									<xsl:value-of select="n1:section/n1:entry[1]/n1:observation/n1:code/@displayName">
									</xsl:value-of>
								</td>
								<td>
									<xsl:call-template name="formatDate">
										<xsl:with-param name="date" select="n1:section/n1:entry/n1:observation/n1:effectiveTime/@value">
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
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
						<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[4]/n1:section/n1:entry/n1:substanceAdministration/..">
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
								</td ><td>
									<xsl:value-of select="n1:substanceAdministration/n1:entryRelationship[2]/n1:observation/n1:text">
									</xsl:value-of>
								</td >
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<br/>
				<table width="100%" border="1">
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
						<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[5]/n1:section/n1:entry/n1:procedure/..">
							<tr>
								<td>
									<xsl:value-of select="n1:procedure/n1:code[@codeSystem='SD.11.4.6']/@displayName">
									</xsl:value-of>
								</td>
								<td>
									<xsl:call-template name="formatDate">
										<xsl:with-param name="date" select="n1:procedure/n1:effectiveTime/@value">
										</xsl:with-param>
									</xsl:call-template>
								</td>
								<td>
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
				<table width="100%" border="1">
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
				<table width="100%" border="1">
					<h3>费用章节</h3>
					<thead>
						<tr>
							<th><h4>门诊费用分类名称</h4></th>
							<th><h4>医疗费用来源</h4></th>
							<th><h4>住院费用结算方式</h4></th>
						</tr>
					</thead>
					<tbody align="center">
						<xsl:for-each select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[7]/n1:section/..">
							<tr>
								<td>
									<xsl:value-of select="n1:section/n1:entry[1]/n1:observation/n1:text">
									</xsl:value-of>
								</td>
								<td>
									<xsl:value-of select="n1:section/n1:entry[3]/n1:observation/n1:value[@codeSystem='SD.11.1.197']/@displayName">
									</xsl:value-of>
								</td>
								<td>
									<xsl:value-of select="n1:section/n1:entry[4]/n1:observation/n1:value[@codeSystem='SD.11.1.198']/@displayName">
									</xsl:value-of>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<br/>
				<table width="100%">
					<h3>死亡章节</h3>
					<tr>
						<td width="10%">
							<b>
								<xsl:text>死亡原因: </xsl:text>
							</b>
						</td>
						<td width="40%">
							<xsl:value-of select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[8]/n1:section/n1:entry/n1:observation/n1:code/@displayName">
						</xsl:value-of>
						</td>
						<td width="25%" align="right">
							<b>
								<xsl:text>死亡时间: </xsl:text>
							</b>
						</td>
						<td width="25%">
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[8]/n1:section/n1:entry/n1:observation/n1:effectiveTime/@value">
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</table>
				<br/>
				<!--<xsl:apply-templates select="n1:component/n1:structuredBody"/> 
				<xsl:call-template name="bottomline"/>-->
			</body>
		</html>
	</xsl:template>
	<!-- Get a Name  -->
	<xsl:template name="getName">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$name/n1:family">
				<xsl:value-of select="$name/n1:given"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$name/n1:family"/>
				<xsl:text> </xsl:text>
				<xsl:if test="$name/n1:suffix">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="$name/n1:suffix"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--  Format Date 
		 outputs a date in Month Day, Year form
		 e.g., 19991207  ==> 1999年12月7日
	-->
	<xsl:template name="formatDate">
		<xsl:param name="date"/>
		<xsl:value-of select="substring ($date, 1, 4)"/>
		<xsl:text>年</xsl:text>
		<xsl:variable name="month" select="substring ($date, 5, 2)"/>
		<xsl:choose>
			<xsl:when test="$month='01'">
				<xsl:text>1月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='02'">
				<xsl:text>2月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='03'">
				<xsl:text>3月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='04'">
				<xsl:text>4月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='05'">
				<xsl:text>5月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='06'">
				<xsl:text>6月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='07'">
				<xsl:text>7月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='08'">
				<xsl:text>8月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='09'">
				<xsl:text>9月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='10'">
				<xsl:text>10月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='11'">
				<xsl:text>11月</xsl:text>
			</xsl:when>
			<xsl:when test="$month='12'">
				<xsl:text>12月</xsl:text>
			</xsl:when>
		</xsl:choose>
		
		<xsl:choose>
			<xsl:when test='substring ($date, 7, 1)="0"'>
				<xsl:value-of select="substring ($date, 8, 1)"/>
				<xsl:text>日</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring ($date, 7, 2)"/>
				<xsl:text>日</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- StructuredBody -->
	<xsl:template match="n1:component/n1:structuredBody">
		<xsl:apply-templates select="n1:component/n1:section"/>
	</xsl:template>
	<!-- Component/Section -->
	<xsl:template match="n1:component/n1:section">
		<xsl:apply-templates select="n1:title"/>
		<xsl:apply-templates select="n1:text"/>
		<xsl:apply-templates select="n1:component/n1:section"/>
	</xsl:template>
	<!--   Title  -->
	<xsl:template match="n1:title">
		<h3>
			<span style="font-weight:bold;">
				<xsl:value-of select="."/>
			</span>
		</h3>
	</xsl:template>
	<!--   Text   -->
	<xsl:template match="n1:text">
		<xsl:apply-templates/>
	</xsl:template>
	<!--   paragraph  -->
	<xsl:template match="n1:paragraph">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	<!--     Content w/ deleted text is hidden -->
	<xsl:template match="n1:content[@revised='delete']"/>
	<!--   content  -->
	<xsl:template match="n1:content">
		<xsl:apply-templates/>
	</xsl:template>
	<!--   list  -->
	<xsl:template match="n1:list">
		<xsl:if test="n1:caption">
			<span style="font-weight:bold; ">
				<xsl:apply-templates select="n1:caption"/>
			</span>
		</xsl:if>
		<ul>
			<xsl:for-each select="n1:item">
				<li>
					<xsl:apply-templates/>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<xsl:template match="n1:list[@listType='ordered']">
		<xsl:if test="n1:caption">
			<span style="font-weight:bold; ">
				<xsl:apply-templates select="n1:caption"/>
			</span>
		</xsl:if>
		<ol>
			<xsl:for-each select="n1:item">
				<li>
					<xsl:apply-templates/>
				</li>
			</xsl:for-each>
		</ol>
	</xsl:template>
	<!--   caption  -->
	<xsl:template match="n1:caption">
		<xsl:apply-templates/>
		<xsl:text>: </xsl:text>
	</xsl:template>
	<!--      Tables   -->
	<xsl:template match="n1:table/@*|n1:thead/@*|n1:tfoot/@*|n1:tbody/@*|n1:colgroup/@*|n1:col/@*|n1:tr/@*|n1:th/@*|n1:td/@*">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="n1:table">
		<table>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="n1:thead">
		<thead>
			<xsl:apply-templates/>
		</thead>
	</xsl:template>
	<xsl:template match="n1:tfoot">
		<tfoot>
			<xsl:apply-templates/>
		</tfoot>
	</xsl:template>
	<xsl:template match="n1:tbody">
		<tbody>
			<xsl:apply-templates/>
		</tbody>
	</xsl:template>
	<xsl:template match="n1:colgroup">
		<colgroup>
			<xsl:apply-templates/>
		</colgroup>
	</xsl:template>
	<xsl:template match="n1:col">
		<col>
			<xsl:apply-templates/>
		</col>
	</xsl:template>
	<xsl:template match="n1:tr">
		<tr>
			<xsl:apply-templates/>
		</tr>
	</xsl:template>
	<xsl:template match="n1:th">
		<th>
			<xsl:apply-templates/>
		</th>
	</xsl:template>
	<xsl:template match="n1:td">
		<td>
			<xsl:apply-templates/>
		</td>
	</xsl:template>
	<xsl:template match="n1:table/n1:caption">
		<span style="font-weight:bold; ">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<!--   RenderMultiMedia 

         this currently only handles GIF's and JPEG's.  It could, however,
	 be extended by including other image MIME types in the predicate
	 and/or by generating <object> or <applet> tag with the correct
	 params depending on the media type  @ID  =$imageRef     referencedObject
 -->
	<xsl:template match="n1:renderMultiMedia">
		<xsl:variable name="imageRef" select="@referencedObject"/>
		<xsl:choose>
			<xsl:when test="//n1:regionOfInterest[@ID=$imageRef]">
				<!-- Here is where the Region of Interest image referencing goes -->
				<xsl:if test='//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value[@mediaType="image/gif" or @mediaType="image/jpeg"]'>
					<br clear="all"/>
					<xsl:element name="img">
						<xsl:attribute name="src">graphics/
				<xsl:value-of select="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value/n1:reference/@value"/></xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- Here is where the direct MultiMedia image referencing goes -->
				<xsl:if test='//n1:observationMedia[@ID=$imageRef]/n1:value[@mediaType="image/gif" or @mediaType="image/jpeg"]'>
					<br clear="all"/>
					<xsl:element name="img">
						<xsl:attribute name="src">graphics/
				<xsl:value-of select="//n1:observationMedia[@ID=$imageRef]/n1:value/n1:reference/@value"/></xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 	Stylecode processing   
	  Supports Bold, Underline and Italics display

-->
	<xsl:template match="//n1:*[@styleCode]">
		<xsl:if test="@styleCode='Bold'">
			<xsl:element name="b">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="@styleCode='Italics'">
			<xsl:element name="i">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="@styleCode='Underline'">
			<xsl:element name="u">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@styleCode,'Bold') and contains(@styleCode,'Italics') and not (contains(@styleCode, 'Underline'))">
			<xsl:element name="b">
				<xsl:element name="i">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@styleCode,'Bold') and contains(@styleCode,'Underline') and not (contains(@styleCode, 'Italics'))">
			<xsl:element name="b">
				<xsl:element name="u">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@styleCode,'Italics') and contains(@styleCode,'Underline') and not (contains(@styleCode, 'Bold'))">
			<xsl:element name="i">
				<xsl:element name="u">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@styleCode,'Italics') and contains(@styleCode,'Underline') and contains(@styleCode, 'Bold')">
			<xsl:element name="b">
				<xsl:element name="i">
					<xsl:element name="u">
						<xsl:apply-templates/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!-- 	Superscript or Subscript   -->
	<xsl:template match="n1:sup">
		<xsl:element name="sup">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="n1:sub">
		<xsl:element name="sub">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<!--  Bottomline  -->
	<xsl:template name="bottomline">
		<b>
			<xsl:text>Signed by: </xsl:text>
		</b>
		<xsl:call-template name="getName">
			<xsl:with-param name="name" select="/n1:ClinicalDocument/n1:legalAuthenticator/n1:assignedEntity/n1:assignedPerson/n1:name"/>
		</xsl:call-template>
		<xsl:text> on </xsl:text>
		<xsl:call-template name="formatDate">
			<xsl:with-param name="date" select="//n1:ClinicalDocument/n1:legalAuthenticator/n1:time/@value"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
