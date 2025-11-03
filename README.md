# Transcriptomics Analyse van Reumatoïde Artritis (RA)
Welkom op deze GitHub-repository, waarin een complete RNA-seq analyse wordt uitgevoerd op synoviumbioplten van patiënten met Reumatoïde Artritis (RA) en gezonde controles. Deze analyse richt zich op het identificeren van differentieel tot expressie gebrachte genen (DEGs) en de betrokken biologische pathways.

# Inhoud/structuur
data/raw/ - originele dataset 
data/ - verwerkte data die gebruikt is
scripts/ - om het onderzoek reproduceerbaar te maken
figuren/ - grafieken en tabellen 
bronnen/ - de gebruikte bronnen 
README.md - het verslag
assets/ - overige documenten
data_stewardship/ - files om de competentie beheren aan te tonen


# Inleiding
Reumatoïde artritis(RA) is een chronische auto-immuunziekte, die zich kenmerkt door door ontsteking van het synovium in gewrichten. Dit leidt vaak tot gewrichtsschade, functieverlies of een vermindere kwaliteit van leven . 

Reumatoïde Artritis (RA) is een chronische auto-immuunziekte waarbij het immuunsysteem lichaamseigen weefsels aanvalt. Een belangrijk kenmerk van RA is synovitis, een ontsteking van het gewrichtsslijmvlies, wat leidt tot gewrichtsschade. De precieze oorzaak is nog onbekend, maar genetische aanleg, omgevingsfactoren en een ontspoord immuunsysteem spelen waarschijnlijk een rol.

Een vroege diagnose is belangrijk om onomkeerbare gewrichtsschade te voorkomen. Door de aanwezigheid van klinische symptonen en aanwezigheid van autoanistoffen, zoals ACPA (anti-CCP), dat aanwezig is bij RA-patiënten. Er bestaat geen genezing voor RA, maar het ziekteproces kan worden afgeremd met medicatie.

Transcriptomics, het analyseren van genexpressie, kan inzicht geven in de onderliggende biologische processen van RA. In dit onderzoek worden RNA-seq-data van synoviumbiopten geanalyseerd van vier RA-patiënten (ACPA-positief, diagnose >12 maanden) en vier controlepersonen (ACPA-negatief). De dataset is afkomstig uit een eerder onderzoek van Platzer et al. (2019). Met behulp van R-software wordt onderzocht welke genen significant anders tot expressie komen bij RA, wat kan bijdragen aan een beter begrip van het ziektemechanisme en mogelijk nieuwe aanknopingspunten voor behandeling oplevert.

De hoofdvraag van het onderzoek is: Welke genen en biologische pathways zijn verschillend tot expressie gebracht in het synovium van personen met reumatoïde artritis in vergelijking met gezonde controlepersonen?

# Methoden
In dit onderzoek is een RNA‑seq‑analyse uitgevoerd op synoviaal weefsel van vier reumatoïde artritis (RA)‑patiënten en vier gezonde controles. De samples zijn verkregen met behulp van een synoviumbiopt: weefsel afkomstig uit gewrichtsslijmvlies. De volledige analyse is geautomatiseerd via een Nextflow-pipeline en gescript in R (versie 4.5.0). 

De workflow omvat zes opeenvolgende stappen. als eerste werd de kwaliteit van de ruwe FASTQ-bestanden beoordeeld met de FastQC (v0.11.9), samengevat met MultiQC (v1.14). Hierna volgde kwaliteits- en adaptertrimming. De opgeschoonde reads zijn vervolgens uitgelijnd op het humane referentiegenoom (GRCh38) met behulp van de 2-pass aligner (v2.7.11a).

De kwantisering van genexpressie werd uitgevoerd met featureCounts (Subread v2.0.3), waarmee het aantal reads per gen werd bepaald. Voor de differentiële genexpressie-analyse is gebruikgemaakt van het R-pakket DESeq2 (v1.40). Genen werden als significant beschouwd bij een adjusted p-waarde < 0,05 en |log₂ fold change| > 1.

Ten slotte werd functionele verrijking uitgevoerd met clusterProfiler (v4.8), gericht op Gene Ontology (GO)-termen en KEGG-pathways. Genannotatie werd opgehaald via org.Hs.eg.db (v3.18).

# Resultaten
Er is in dit onderzoek gekeken naar RA, waarbij meerdere analyses zijn uitgevoerd. Er is gekeken naar de differentiële genexpressie, KEGG-patwayanalyse en de GO-termverrijking. 
De volcano plot laat zien welke genen significant andere tot expressie kwamen bij RA. Hierbij zijn de genen zowel statistisch als biologisch relevant zijn weergegeven in het rood. Genen met een hoge expressie zijn ANKRD30BL, BCL2A1, COL6A5, CXCR1, IGKV1-39, PTGFR. Er werden in totoaal 29.407 genen geanaylseerd, waarvan een groot deel differentieel tot expressie is gebracht. 

De pathway analyse toont de betrokken genen binnen het RA-pathway. De kleuren geven de mate van de expressieverandering weer. rood is de opregulatie en groen de downregulatie. De opvallende genen binnen dit pathway zijn Opgereguleerd: IL6, IL1B, TNF, RANKL, MMP9, IFNG, CD28, CD80, CTLA4 en neerwaarts gereguleerd: TGFβ, IL4, IL23

De GO verrijkingsanalyse toont aan de genen die differentieel tot expressie komen significant betrokken zijn bij de biologische processien die verband houden met het immuunsysteem. De top Go-termen (FDR < 0.05). 


# conclusie
Uit de anaylse is gebleken dat RA gepaard gaat met een verstoring van immuun en ontstekingsroutes. De KEGG-pathway toont opregulatie van centrale cytokinen, als Il6, TNF, iL1B en IFNG. Dit duidt op een versterkte ontsteking binnen het synoviale weefsel. Dit wordt ondersteund met de volcano plot, waarin meerdere genen met een rol in apoptose. De GO-termverrijking laat verder zien dat termen als immune response, immunoglobulin complex en antigen binding sterk verrijkt zijn, wat wijst op actieve betrokkenheid van zowel het adaptieve als aangeboren immuunsysteem.
Deze resultaten sluiten aan bij bestaand onderzoek dat aantoont dat RA sterk wordt gekenmerkt door cytokine-afhankelijke ontsteking en autoantilichaamvorming (McInnes & Schett, 2011; Smolen et al., 2016).
 
Aanbeveling
Op basis van de gevonden resultaten zou het bij een vervolgonderzoek beter zijn om de groepen uit te breiden, meer controles en meer met RA. Ook is het interessant om te gaan kijken naar het verschil tussen man en vrouw, en hoe de genen zich zouden reguleren bij een patiënt die korter als 12 maanden gediagnosticeerd is met RA. Voor een vervolgonderzoek zou dit tot nieuwe inzichten leiden. 





