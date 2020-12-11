<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
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
                            <TH>순번</TH>
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
                        <xsl:apply-templates select="/제품/핸드폰">
                            <xsl:sort order="ascending" select="통신사" data-type="text"/>
                            <xsl:sort order="ascending" select="가격" data-type="number"/>
                        </xsl:apply-templates>
                    </TBODY>
                </TABLE>
            </BODY>
        </HTML>
    </xsl:template>

    <xsl:template match="/제품/핸드폰">
        <TR>
            <!-- XML 파일에 들어있던 순서. Sortig시, 순서가 바뀔 수도 있음-->
            <TD><p><xsl:number format = "1"/></p></TD>
            
            <!-- Position함수를 통한 로마  숫자 표기-->
            <!-- <TD><p><xsl:value-of select= "position"/></p></TD> -->

            <!-- Sorting 된 후의 순서 -->
            <!-- <TD><p><xsl:value-of select= "position"/></p></TD> -->
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