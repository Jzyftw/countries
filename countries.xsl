<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:math="http://exslt.org/math"
                extension-element-prefixes="math">
    <xsl:output method="html" encoding="utf-8" indent="yes" />

    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="countries">
        <html>
            <head>
                <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"
                      integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
                      crossorigin="anonymous"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous"/>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"/>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"/>
                <link rel="stylesheet" type="text/css" href="CSS/style.css"/>
                <title>Démographie mondiale</title>
            </head>
            <body>
                <h1> Démographie mondiale </h1>
                <div id="wrapper">
                    <div id="sidebar-wrapper">
                        <!-- ordre alphabétique -->
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                Par ordre alphabétique
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <xsl:apply-templates mode="menu"/>
                            </ul>
                        </div>
                        <!-- par superficie -->
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                Par superficie
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <xsl:apply-templates mode="menu"><xsl:sort select="@area" order="descending" data-type="number"/></xsl:apply-templates>
                            </ul>
                        </div>
                        <!-- par population -->
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                Par population
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <xsl:apply-templates mode="menu"><xsl:sort select="@population" order="descending" data-type="number"/></xsl:apply-templates>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <xsl:apply-templates mode="body"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- menu -->
    <xsl:template match="country" mode="menu">
        <li>
            <a>
            <xsl:attribute name="href">
                #<xsl:value-of select="generate-id()"/>
            </xsl:attribute>
            <xsl:value-of select="@name" />
            </a>
        </li>
    </xsl:template>
    <!-- fin menu -->

    <!-- pays -->
    <xsl:template match="country" mode="body">
        <div class="country">
            <xsl:attribute name="id">
                <xsl:value-of select="generate-id()" />
            </xsl:attribute>
            <div class="name">
                <xsl:value-of select="@name" />
            </div>
            <table>
                <tr>
                    <th> Population </th>
                    <th> Superficie </th>
                </tr>
                <tr>
                    <td><xsl:value-of select="@population"/></td>
                    <td><xsl:value-of select="@area"/> km² </td>
                </tr>
            </table>
            <div class="languages">
                <xsl:if test="language">
                    <h2>Langues</h2>
                    <svg width="200" height="20">
                        <rect width="100" height="20" style="fill:rgb(24,40,232);stroke-width:2;stroke:rgb(0,0,0)" />
                        <xsl:apply-templates select="language"/>
                    </svg>
                </xsl:if>
            </div>
            <div class="cities">
                <xsl:if test="city">
                    <h2>Villes et pourcentage de population</h2>
                    <xsl:apply-templates select="city"/>
                </xsl:if>
            </div>
        </div>
    </xsl:template>


    <!-- langues -->
    <xsl:template match="language">
        <xsl:if test=".">


                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@percentage"/>%
                <!--<svg width="200" height="20">
                    <rect width="100" height="20" style="fill:rgb(24,40,232);stroke-width:2;stroke:rgb(0,0,0)" />-->
                    <xsl:variable name="xpos" select="0"/>
                    <rect width="{@percentage}" x="{preceding-sibling}" height="20" style="fill:rgb(50,147,255);stroke-width:1;stroke:rgb(0,0,0)" />
                <!--</svg> -->

        </xsl:if>
    </xsl:template>

    <!-- ville -->
    <xsl:template match="city">
        <div class="city">
            <xsl:value-of select="name"/>
            <xsl:variable name="totalpop" select="../@population" />
            <xsl:variable name="citypop" select="population"/>
            <svg width="200" height="20">
                <rect width="200" height="20" style="fill:rgb(49,232,28);stroke-width:2;stroke:rgb(0,0,0)" />
                <rect width="{$citypop*500 div $totalpop}" height="20" style="fill:rgb(146,255,54);stroke-width:1;stroke:rgb(0,0,0)" />
            </svg>
        </div>
    </xsl:template>
</xsl:stylesheet>
