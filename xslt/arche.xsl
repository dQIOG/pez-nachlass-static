<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:acdh="https://vocabs.acdh.oeaw.ac.at/schema#"
    version="2.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:variable name="constants">
            <xsl:for-each select=".//node()[parent::acdh:RepoObject]">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="TopColId">
            <xsl:value-of select="data(.//acdh:TopCollection/@rdf:about)"/>
        </xsl:variable>
        <rdf:RDF xmlns:acdh="https://vocabs.acdh.oeaw.ac.at/schema#">
            <acdh:TopCollection>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select=".//acdh:TopCollection/@rdf:about"/>
                </xsl:attribute>
                <xsl:for-each select=".//node()[parent::acdh:TopCollection]">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </acdh:TopCollection>
            
            
            <xsl:for-each select=".//node()[parent::acdh:MetaAgents]">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select=".//acdh:Collection">
                <acdh:Collection>
                    <xsl:attribute name="rdf:about"><xsl:value-of select="@rdf:about"/></xsl:attribute>
                    <xsl:for-each select=".//node()">
                        <xsl:copy-of select="."/>
                    </xsl:for-each>
                </acdh:Collection>
            </xsl:for-each>
            <xsl:for-each select="collection('../data/editions')//tei:TEI">

                <xsl:variable name="partOf">
                    <xsl:value-of select="$TopColId"/>
                </xsl:variable>
                <xsl:variable name="id">
                    <xsl:value-of select="concat($partOf, '/', @xml:id)"/>
                </xsl:variable>
                <xsl:variable name="date">
                    <xsl:choose>
                        <xsl:when test=".//tei:date[1]/@when">
                            <acdh:hasCoverageStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date"><xsl:value-of select="data(.//tei:date/@when)"/></acdh:hasCoverageStartDate>
                            <acdh:hasCoverageEndDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date"><xsl:value-of select="data(.//tei:date[1]/@when)"/></acdh:hasCoverageEndDate>
                        </xsl:when>
                        <xsl:when test=".//tei:date[1]/@notBefore and .//tei:date[1]/@notAfter">
                            <acdh:hasCoverageStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date"><xsl:value-of select="data(.//tei:date[1]/@notBefore)"/></acdh:hasCoverageStartDate>
                            <acdh:hasCoverageEndDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date"><xsl:value-of select="data(.//tei:date[1]/@notAfter)"/></acdh:hasCoverageEndDate>
                        </xsl:when>
                        <xsl:when test=".//tei:date[1]/@notBefore">
                            <acdh:hasCoverageStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date"><xsl:value-of select="data(.//tei:date[1]/@notBefore)"/></acdh:hasCoverageStartDate>
                        </xsl:when>
                        <xsl:when test=".//tei:date[1]/@notAfter">
                            <acdh:hasCoverageEndDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date"><xsl:value-of select="data(.//tei:date[1]/@notAfter)"/></acdh:hasCoverageEndDate>
                        </xsl:when>
                    </xsl:choose>
                </xsl:variable>
                
                <acdh:Resource rdf:about="{$id}">
                    <acdh:hasPid><xsl:value-of select=".//tei:idno[@type='handle']/text()"/></acdh:hasPid>
                    <acdh:hasTitle xml:lang="de"><xsl:value-of select=".//tei:title[@type='main'][1]/text()"/></acdh:hasTitle>
                    <acdh:hasDescription xml:lang="de"><xsl:value-of select="string-join(.//tei:summary//text())"/></acdh:hasDescription>
                    <!--<acdh:hasCoverage xml:lang="de"><xsl:value-of select="$datum"/></acdh:hasCoverage>-->
                    <acdh:hasAccessRestriction rdf:resource="https://vocabs.acdh.oeaw.ac.at/archeaccessrestrictions/public"/>
                    <acdh:hasCategory rdf:resource="https://vocabs.acdh.oeaw.ac.at/archecategory/text/tei"/>
                    <acdh:hasLanguage rdf:resource="https://vocabs.acdh.oeaw.ac.at/iso6393/deu"/>
                    <acdh:isPartOf rdf:resource="{$partOf}"/>
                    <acdh:hasSubject xml:lang="de"><xsl:value-of select=".//tei:classCode/text()"/></acdh:hasSubject>
                    <acdh:hasNote xml:lang="de"><xsl:value-of select="normalize-space(string-join(.//tei:foliation//text()))"/></acdh:hasNote>
                    <acdh:hasNonLinkedIdentifier><xsl:value-of select="concat('unidam-verz_einh: ', data(.//tei:idno[@type='unidam-verz_einh'][1]))"/></acdh:hasNonLinkedIdentifier>
                    <xsl:for-each select="$date">
                        <xsl:copy-of select="."></xsl:copy-of>
                    </xsl:for-each>
                    
                    
                    
                    <xsl:copy-of select="$constants"/>
                    
                    
                    
                </acdh:Resource>
            </xsl:for-each>
        </rdf:RDF>
    </xsl:template>   
</xsl:stylesheet>