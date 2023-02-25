<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Template des pages HTML -->
    
    <xsl:template match="/">
        
        <!-- Déclaration de variables pour appeler les pages HTML -->
        <xsl:variable name="index_personnages">
            <xsl:text>index_personnages.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="index_lieux">
            <xsl:text>index_lieux.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="accueil">
            <xsl:text>accueil.html</xsl:text>
        </xsl:variable>
        
        <!-- Déclaration de variables pour appeler divers éléments -->
        
        <!-- Pour appeler le titre du document encodé -->
        <xsl:variable name="titre">
            <xsl:value-of select="//fileDesc/titleStmt/title"/>
        </xsl:variable>
        
        <!-- Pour appeler le nom de l'auteur du texte encodé -->
        <xsl:variable name="JV">
            <xsl:value-of
                select="concat(//fileDesc/titleStmt//forename, ' ', //fileDesc/titleStmt//surname)"
            />
        </xsl:variable>
        
        <!-- Pour appeler le nom de la responsable de l'encodage -->
        <xsl:variable name="AE">
            <xsl:value-of select="concat(//respStmt//forename, ' ', //respStmt//surname)"/>
        </xsl:variable>
        
        <!-- Pour appeler la description de l'édition numérique XML-TEI -->
        <xsl:variable name="edition_numerique">
            <xsl:value-of select="//editionStmt/edition"/>
        </xsl:variable>
        
        <!-- Pour appeler la description de l'encodage XML-TEI -->
        <xsl:variable name="description">
            <xsl:value-of select="//encodingDesc/p"/>
        </xsl:variable>
        
        <!-- Pour appeler le nom de l'éditeur -->
        <xsl:variable name="editeur">
            <xsl:value-of select="//biblFull/publicationStmt/publisher"/>
        </xsl:variable>
        
        <!-- Pour appeler l'adresse de l'éditeur -->
        <xsl:variable name="editeur_adresse">
            <xsl:value-of
                select="concat(', ', //biblFull/descendant::address/street, ', ', //biblFull/descendant::address/settlement)"
            />
        </xsl:variable>
        
        <!-- Pour appeler la date de publication -->
        <xsl:variable name="date_publication">
            <xsl:value-of select="//sourceDesc//date"/>
        </xsl:variable>
        
        <!-- Pour appeler la BNF -->
        <xsl:variable name="bnf">
            <xsl:value-of select="//publicationStmt/distributor"/>
        </xsl:variable>
        
        <!-- Pour appeler le lien vers Gallica -->
        <xsl:variable name="facsimile">
            <xsl:value-of select="//biblFull/publicationStmt/distributor/@facs"/>
        </xsl:variable>
        
        <!-- Pour appeler la licence liée à la BNF -->
        <xsl:variable name="bnf_licence">
            <xsl:value-of select="concat(', ', //sourceDesc//availability)"/>
        </xsl:variable>
        
        <!-- Pour appeler le titre du roman-feuilleton -->
        <xsl:variable name="titre_roman-feuilleton">
            <xsl:value-of select="//seriesStmt/biblScope[@unit = 'book']"/>
        </xsl:variable>
        
        <!-- Pour appeler le titre du chapitre -->
        <xsl:variable name="chapitre">
            <xsl:value-of select="//seriesStmt/title"/>
        </xsl:variable>
        
        <!-- Pour appeler la page du journal -->
        <xsl:variable name="page">
            <xsl:value-of select="//seriesStmt/biblScope[@unit = 'page']"/>
        </xsl:variable>
        
        
        <!-- Sortie de la page d'accueil -->
        <xsl:result-document href="pages/{$accueil}" method="html" indent="yes">
            <html>
                <head>
                    <!-- Appel du template head HTML -->
                    <xsl:call-template name="head"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' | ', 'Accueil')"/>
                    </title>
                </head>
                
                <body>
                    <!-- Appel du template barre de navigation -->
                    <xsl:call-template name="navbar"/>
                    
                    <div type="container">
                        <h1 class="text-center">
                            <xsl:value-of
                                select="concat('Encodage XML-TEI d''un extrait de ', $titre, ' de ', $JV)"
                            />
                        </h1>
                        <div class="text-center" style="display: block; ">
                            <!-- Intégration du journal numérisé via Gallica -->
                            <iframe style="width:910px; height: 650px; border: 0;"
                                src="https://gallica.bnf.fr/ark:/12148/bpt6k2251979/f1.item"/>
                        </div>
                        <p class="text-center"><i>Le tour du monde en quatre-vingts jours</i> est un
                            roman-feuilleton écrit par Jules Verne est publié pour la première fois 
                            du 6 novembre au 22 décembre 1872 dans le feuilleton du journal 
                            <i><xsl:value-of select="$editeur"/></i>, 
                            avec des interruptions régulières.
                             L'encodage porte sur le chapitre XIV, paru dans le numéro du
                            <xsl:value-of select="$date_publication"/>. <xsl:value-of
                                select="$description"/></p>
                        <div>
                            <h2>Source de l'encodage :</h2>
                            <ul>
                                <li>
                                    <b>Titre du roman-feuilleton : </b>
                                    <xsl:value-of select="$titre_roman-feuilleton"/>
                                </li>
                                <li>
                                    <b>Chapitre : </b>
                                    <xsl:value-of select="$chapitre"/>
                                </li>
                                <li>
                                    <b>Pages : </b>
                                    <xsl:value-of select="$page"/>
                                </li>
                                <li>
                                    <b>Date originale de publication : </b>
                                    <xsl:value-of select="$date_publication"/>
                                </li>
                                <li>
                                    <b>Publié chez : </b>
                                    <i>
                                        <xsl:value-of select="$editeur"/>
                                    </i>
                                    <xsl:value-of select="$editeur_adresse"/>
                                </li>
                                <li>
                                    <b>Facsimilé : </b>
                                    <a href="{$facsimile}">
                                        <xsl:value-of select="$bnf"/>
                                    </a>
                                    <xsl:value-of select="$bnf_licence"/>
                                </li>
                            </ul>
                        </div>
                        <div>
                            <h2>L'encodage :</h2>
                            <p>
                                <xsl:value-of select="/$edition_numerique"/>
                                <a
                                    href="https://github.com/AudeEych/XML-TEI_LeTemps/blob/main/Documentation/ODD_XML-TEI_JVerne.html"
                                    >Voir l'ODD correspondante.</a>
                            </p>
                            <p>Transformation XSL réalisée dans le cadre du cours "Techniques et
                                chaîne de publication électronique" de Mme Ségolène Albouy du Master
                                TNAH de l'Ecole nationale des chartes.</p>
                            <p>La transformation XSL permet de mettre en valeur les lieux et
                                personnages évoqués dans le texte au travers de la constitution
                                d'index.</p>
                        </div>
                        <div class="text-center">
                            <xsl:value-of select="concat($AE, ', 2023')"/>
                            <a class="github"
                                href="https://github.com/AudeEych/Projet_XSLT_Jules_Verne">
                                <img width="28" height="28" src="../images/GitHub-Mark-32px.png"
                                    alt="Voir le projet sur GitHub"
                                    title="Voir le projet sur Github"/>
                            </a>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    
</xsl:stylesheet>