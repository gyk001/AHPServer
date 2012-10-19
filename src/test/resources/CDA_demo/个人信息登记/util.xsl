<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<!--对于字典表的处理 在需要字典表转换的地方添加 codeSystem="表名"-->
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
	<!--变量参数定义-->
	<xsl:variable name="tableWidth">width:100%</xsl:variable>
	<xsl:variable name="border">0</xsl:variable>
	<xsl:variable name="className">test</xsl:variable>
	<!--定义字典表取值-->
	<!--生理性别代码表-->
	<xsl:variable name="GBT2261.1">GBT2261.1</xsl:variable>
	<!--婚姻状况代码表-->
	<xsl:variable name="GBT2261.2">GBT2261.2</xsl:variable>
	<!--民族类别代码表-->
	<xsl:variable name="GB3304">GB3304</xsl:variable>
	<!--学历代码表-->
	<xsl:variable name="GBT4658">GBT4658</xsl:variable>
	<!--职业类别代码表-->
	<xsl:variable name="GBT6565">GBT6565</xsl:variable>
	<!--家庭关系代码表-->
	<xsl:variable name="GBT4761">GBT4761</xsl:variable>
	<!--血缘关系代码表-->
	<xsl:variable name="CVO2.01.201">CVO2.01.201</xsl:variable>
	<!--行政区划代码表-->
	<xsl:variable name="GBT2260">GBT2260</xsl:variable>
	<!--ABO血型代码表-->
	<xsl:variable name="CVO4.50.005">CVO4.50.005</xsl:variable>
	<!--Rh血型代码表暂无-->
	
</xsl:stylesheet>
