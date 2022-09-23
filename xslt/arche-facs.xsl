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
        <xsl:variable name="facsConstants">
            <xsl:for-each select=".//node()[parent::acdh:RepoObject[@type='facs-res']]">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="TopColId">
            <xsl:value-of select="data(.//acdh:TopCollection/@rdf:about)"/>
        </xsl:variable>
        <rdf:RDF xmlns:acdh="https://vocabs.acdh.oeaw.ac.at/schema#">
            
            <xsl:for-each select="collection('../data/editions')//tei:TEI">
                <xsl:variable name="id">
                    <xsl:value-of select="concat($TopColId, '/', @xml:id)"/>
                </xsl:variable>
                <xsl:variable name="facsColId">
                    <xsl:value-of select="replace($id, '.xml', '')"/>
                </xsl:variable>
                
                <xsl:for-each select=".//tei:surface[./tei:graphic[@url]]">
                    <xsl:variable name="cur_id">
                        <xsl:value-of select="replace(@xml:id, 's', '')"/>
                    </xsl:variable>
                    <xsl:variable name="filename">
                        <xsl:value-of select="concat($cur_id, '.tif')"/>
                    </xsl:variable>
                    <acdh:Resource>
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="concat($TopColId, '/', $filename)"/>
                        </xsl:attribute>
                        <acdh:isPartOf rdf:resource="{$facsColId}"/>
                        <acdh:hasTitle xml:lang="de">
                            <xsl:value-of select="concat($filename, '; ', data(./@n))"/>
                        </acdh:hasTitle>
                        <acdh:hasCategory rdf:resource="https://vocabs.acdh.oeaw.ac.at/archecategory/image"/>
                        <acdh:isSourceOf rdf:resource="{$id}"></acdh:isSourceOf>
                        <xsl:copy-of select="$facsConstants"/>
                    </acdh:Resource>
                </xsl:for-each>
                

                
            </xsl:for-each>
        </rdf:RDF>
    </xsl:template>   
</xsl:stylesheet>