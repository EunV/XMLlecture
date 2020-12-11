<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- 
    <xsl:template match="/people/name">
        <name>
            <xsl:apply-templates select="@*" />
        </name>
    </xsl:template> -->

    <xsl:template match="/">
        <people>
            <xsl:apply-templates select="//name" />
        </people>
    </xsl:template>

    <xsl:template match="name">
        <name>
            <xsl:apply-templates select="@*" />
        </name>
    </xsl:template>

    <xsl:template match="@*">
        <!-- 현재 노드의 값 : {.}-->
        <!-- 현재 노드의 이름 : {local-name()}-->
        <xsl:element name="{local-name()}">
            <xsl:value-of select="." />
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>