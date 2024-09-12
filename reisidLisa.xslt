<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

	<xsl:output method="html" indent="yes" encoding="utf-8"/>

	<xsl:template match="/">
		<html>
			<head>
				<style>
					h1 {
					color: #333;
					font-size: 24px;
					margin-top: 20px;
					border-bottom: 1px solid #ddd;
					}
					ul {
					list-style-type: disc;
					margin: 20px 0;
					font-size: 18px;
					}
					li {
					margin-bottom: 10px;
					}
					.highlight {
					background-color: yellow;
					}
					.high-price {
					color: red;
					font-weight: bold;
					}
					th, td {
					border: 1px solid black;
					padding: 8px;
					text-align: left;
					}
					tr:nth-child(odd) {
					background-color: #f2f2f2;
					}
					tr:nth-child(even) {
					background-color: #ffffff;
					}
					th {
					background-color: #4CAF50;
					color: white;
					}
				</style>
			</head>
			<body>
				<details>
					<summary>
						<h1>Harjutused 1-4</h1>
					</summary>
					<xsl:for-each select="//Reis">
						<h1>
							<xsl:value-of select="Lõpp_Koht" />
						</h1>
						<ul>
							<li>
								Reisi kuupäev: <xsl:value-of select="Kuupaev" />
							</li>

							<!-- если цена больше 500  - выделяется-->
							<li>
								Hind:
								<xsl:choose>
									<xsl:when test="Hind &gt; 500">
										<span class="high-price">
											<xsl:value-of select="Hind" />
										</span>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="Hind" />
									</xsl:otherwise>
								</xsl:choose>
							</li>

							<li>
								Lennujaam:
								<span class="highlight">
									<xsl:value-of select="Lennujaam/@Name" />
								</span>
							</li>
						</ul>
					</xsl:for-each>
				</details>

				<details>
					<summary>
						<h1>5. Kuva iga reisi kogumaksumuse, liites transport, majutuse, ekskursioonide ja muude kulude hinnad kokku.</h1>
					</summary>
					<xsl:for-each select="//Reis">
						<h1>
							<xsl:value-of select="Lõpp_Koht" />
						</h1>
						<ul>
							<li>
								Reisi kuupäev: <xsl:value-of select="Hind" />
							</li>


							<li>
								Reisi kuupäev: <xsl:value-of select="Ekskursioonid" />
							</li>
							<li>
								Reisi kuupäev: <xsl:value-of select="Majutus" />
							</li>


							<li>
								Kokku hind:

								<xsl:value-of select="number(Hind) + number(Ekskursioonid) + number(Majutus)" />

							</li>
						</ul>
					</xsl:for-each>
				</details>

				<details>
					<summary>
						<h1>6. Kokku hind vähem 3000</h1>
					</summary>
					<xsl:for-each select="//Reis">

						<xsl:variable name="totalCost">
							<xsl:value-of select="Hind + Ekskursioonid + Majutus"/>
						</xsl:variable>


						<xsl:if test="$totalCost &lt; 3000">
							<h2>
								<xsl:value-of select="Lõpp_Koht" />
							</h2>
							<ul>
								<li>
									Reisi kuupäev: <xsl:value-of select="Hind" />
								</li>
								<li>
									Ekskursioonid: <xsl:value-of select="Ekskursioonid" />
								</li>
								<li>
									Majutus: <xsl:value-of select="Majutus" />
								</li>
								<li>
									Kokku hind: <xsl:value-of select="$totalCost" />
								</li>
							</ul>
						</xsl:if>
					</xsl:for-each>
				</details>


				<details>
					<summary>
						<h1>7. Sorteerimine ettevõtte reitingu järgi</h1>
					</summary>
			
					<xsl:for-each select="//Reis">
					
						<xsl:sort select="Firma" order="ascending"/>

						<h2>
							<xsl:value-of select="Lõpp_Koht" />
						</h2>
						<ul>
							<li>
								Reisi kuupäev: <xsl:value-of select="Hind" />
							</li>
							<li>
								Ekskursioonid: <xsl:value-of select="Ekskursioonid" />
							</li>
							<li>
								Majutus: <xsl:value-of select="Majutus" />
							</li>
							<li>
								Kokku hind: <xsl:value-of select="Hind + Ekskursioonid + Majutus" />
							</li>
							<li>
								Firma: <xsl:value-of select="Firma" />
							</li>
						</ul>
					</xsl:for-each>
				</details>

				<details>
					<summary><h1>Reisid</h1></summary>
				<table>
					<tr>
						<th>Firma</th>
						<th>Transport</th>
						<th>Lennujaam</th>
						<th>Kuupaev</th>
						<th>Hind</th>
						<th>Algus Koht</th>
						<th>Lõpp Koht</th>
						<th>Firma Rating</th>
						<th>Ekskursioonid</th>
						<th>Majutus</th>
					</tr>

					<xsl:for-each select="//Reis">
						<tr>

							<td>
								<xsl:value-of select="Firma"/>
							</td>
							<td>
								<xsl:value-of select="../Transport/@Type"/>
							</td>
							<td>
								<xsl:value-of select="Lennujaam/@Name"/>
							</td>
							<td>
								<xsl:value-of select="Kuupaev"/>
							</td>
							<td>
								<xsl:value-of select="Hind"/>
							</td>
							<td>
								<xsl:value-of select="Algus_Koht"/>
							</td>
							<td>
								<xsl:value-of select="Lõpp_Koht"/>
							</td>
							<td>
								<xsl:value-of select="FirmaRating"/>
							</td>
							<td>
								<xsl:value-of select="Ekskursioonid"/>
							</td>
							<td>
								<xsl:value-of select="Majutus"/>
							</td>
						</tr>
					</xsl:for-each>
				</table></details>
			
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
