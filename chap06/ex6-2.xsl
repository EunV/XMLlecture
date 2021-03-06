<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- 처음-->
    <xsl:template match="/">
        <p>Pre Test </p>
    </xsl:template>

    <!-- 중간-->
    <xsl:template match="/">
        <HTML>
            <HEAD>
                <TITLE>XML 문서의 내용을 테이블 형태로 보여주기</TITLE>
            </HEAD>
            <BODY>
                <BR />
                <P>핸드폰 리스트</P>
                <BR/>
                <TABLE>
                    <THEAD>
                        <TR>
                            <TH>모델명</TH>
                            <TH>통신사</TH>
                            <TH>구입형태</TH>
                            <TH>제조사</TH>
                            <TH>색상</TH>
                            <TH>판매량</TH>
                            <TH>가격</TH>
                        </TR>
                    </THEAD>
                    <TBODY>
                        <xsl:apply-templates select="/제품/핸드폰"/>
                    </TBODY>
                </TABLE>
            </BODY>
        </HTML>
    </xsl:template>

    <!-- 끝 -->
    <xsl:template match="/">
    <p>Post Test</p>
    </xsl:template>

    <xsl:template match="/제품/핸드폰">
        <TR>
            <TD><p><xsl:value-of select="모델명"/></p></TD>
            <TD><p><xsl:value-of select="통신사"/></p></TD>
            <TD><p><xsl:value-of select="구입형태"/></p></TD>
            <TD><p><xsl:value-of select="제조사"/></p></TD>
            <TD><p><xsl:value-of select="색상"/></p></TD>
            <TD><p><xsl:value-of select="판매량"/></p></TD>
            <TD><p><xsl:value-of select="가격"/></p></TD>
        </TR>
    </xsl:template>
</xsl:stylesheet>