# Transcriptomics Analyse van Reumatoïde Artritis (RA)
Welkom op deze GitHub-repository, waarin een complete RNA-seq analyse wordt uitgevoerd op synoviumbioplten van patiënten met Reumatoïde Artritis (RA) en gezonde controles. Deze analyse richt zich op het identificeren van differentieel tot expressie gebrachte genen (DEGs) en de betrokken biologische pathways.

## 📁 Inhoud & Structuur

**data/raw/**  - Originele dataset  
**data/**  - Verwerkte data die gebruikt is  
**scripts/** - Om het onderzoek reproduceerbaar te maken  
**figuren/**  - Grafieken en tabellen  
**bronnen/**  - De gebruikte bronnen  
**README.md**  - Het verslag  
**assets/**  - Overige documenten  
**data_stewardship/**  - Files om de competentie *Beheren* aan te tonen


# Inleiding
Reumatoide artritis(RA) is een chronische auto-immuunziekte, die zich kenmerkt door door ontsteking van het synovium in gewrichten. Dit leidt vaak tot gewrichtsschade, functieverlies of een vermindere kwaliteit van leven [Tanaka, 2020](https://inflammregen.biomedcentral.com/articles/10.1186/s41232-020-00133-8) RA komt wereldwijd voor bij ongeveer 0.24 - 1% van de bevolking [Gabriel, 2001](https://pubmed.ncbi.nlm.nih.gov/11396092/) en komt 2-3 keer zo vaak voor bij vrouwen als bij mannen [Favalli et al., 2019](https://pubmed.ncbi.nlm.nih.gov/29372537/). Het wordt veroorzaakt door een combinatie van omgevingsfactoren, genetica en immuunreacties [Firestein en Mclness, 2017](https://pubmed.ncbi.nlm.nih.gov/28228278/). 
Een vroege diagnose is belangrijk om onomkeerbare gewrichtsschade te voorkomen. Door de aanwezigheid van klinische symptonen en aanwezigheid van autoanistoffen, zoals ACPA (anti-CCP), dat aanwezig is bij RA-patiënten. Er bestaat geen genezing voor RA, maar het ziekteproces kan worden afgeremd met medicatie.

NOG>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Transcriptomics, het analyseren van genexpressie, kan inzicht geven in de onderliggende biologische processen van RA. In dit onderzoek worden RNA-seq-data van synoviumbiopten geanalyseerd van vier RA-patiënten (ACPA-positief, diagnose >12 maanden) en vier controlepersonen (ACPA-negatief). De dataset is afkomstig uit een eerder onderzoek van Platzer et al. (2019). Met behulp van R-software wordt onderzocht welke genen significant anders tot expressie komen bij RA, wat kan bijdragen aan een beter begrip van het ziektemechanisme en mogelijk nieuwe aanknopingspunten voor behandeling oplevert.

De hoofdvraag van het onderzoek is: Welke genen en biologische pathways zijn verschillend tot expressie gebracht in het synovium van personen met reumatoïde artritis in vergelijking met gezonde controlepersonen?

# Methoden
In dit onderzoek is een RNA‑seq‑analyse uitgevoerd op synoviaal weefsel van vier reumatoïde artritis (RA)‑patiënten en vier gezonde controles. De samples zijn verkregen met behulp van een synoviumbiopt dit is weefsel afkomstig uit gewrichtsslijmvlies. De volledige analyse is geautomatiseerd via een Nextflow-pipeline en gescript in R (versie 4.5.0). 

De workflow omvat zes opeenvolgende stappen. als eerste werd de kwaliteit van de ruwe FASTQ-bestanden beoordeeld met de FastQC (v0.11.9), samengevat met MultiQC (v1.14). Hierna volgde kwaliteits- en adaptertrimming. De opgeschoonde reads zijn vervolgens uitgelijnd op het humane referentiegenoom (GRCh38) met behulp van de 2-pass aligner (v2.7.11a).

De kwantisering van genexpressie werd uitgevoerd met featureCounts (Subread v2.0.3), waarmee het aantal reads per gen werd bepaald. Voor de differentiële genexpressie-analyse is gebruikgemaakt van het R-pakket DESeq2 (v1.40). Genen werden als significant beschouwd bij een adjusted p-waarde < 0,05 en |log₂ fold change| > 1.

Ten slotte werd functionele verrijking uitgevoerd met clusterProfiler (v4.8), gericht op Gene Ontology (GO)-termen en KEGG-pathways. Genannotatie werd opgehaald via org.Hs.eg.db (v3.18).

<img width="1403" height="738" alt="image" src="https://github.com/user-attachments/assets/d86e36f1-b75e-4eed-8970-8226800d6c73" />
figuur 1: Flowchart van het verwerken van de data in R

# Resultaten
Een analyse die is uitgevoerd op synoviumbiopten van patiënten met reumatoïde artritis (RA) en gezonde controlepersonen. Er is gekeken naar de differentiële genexpressie, KEGG-patwayanalyse en de GO-termverrijking. 
De volcano plot weergegeven in figuur 2 laat zien welke genen significant andere tot expressie kwamen bij RA. Hierbij zijn de genen zowel statistisch als biologisch relevant zijn weergegeven in het rood. Genen met een hoge expressie zijn ANKRD30BL, BCL2A1, COL6A5, CXCR1, IGKV1-39, PTGFR. Er werden in totoaal 29.407 genen geanaylseerd, waarvan een groot deel differentieel tot expressie is gebracht.

<img width="1443" height="729" alt="image" src="https://github.com/user-attachments/assets/1ba9bfe5-aaf5-4bbd-aeeb-292d31626053" />
Figuur 2: 

De pathway analyse toont de betrokken genen binnen het RA-pathway. De kleuren geven de mate van de expressieverandering weer. rood is de opregulatie en groen de downregulatie. De opvallende genen binnen dit pathway zijn Opgereguleerd: IL6, IL1B, TNF, RANKL, MMP9, IFNG, CD28, CD80, CTLA4 en neerwaarts gereguleerd: TGFβ, IL4, IL23.

<img width="1398" height="754" alt="image" src="https://github.com/user-attachments/assets/94941877-3c32-46af-b03a-19d19366bb88" />
figuur 2:


De GO verrijkingsanalyse toont aan de genen die differentieel tot expressie komen significant betrokken zijn bij de biologische processien die verband houden met het immuunsysteem. De top Go-termen (FDR < 0.05). 

<img width="588" height="600" alt="image" src="https://github.com/user-attachments/assets/0778faef-f968-4d06-9221-666a056309bb" />

figuur 3:   


# conclusie
Uit de anaylse is gebleken dat RA gepaard gaat met een verstoring van immuun en ontstekingsroutes. De KEGG-pathway toont opregulatie van centrale cytokinen, als Il6, TNF, iL1B en IFNG. Dit duidt op een versterkte ontsteking binnen het synoviale weefsel. Dit wordt ondersteund met de volcano plot, waarin meerdere genen met een rol in apoptose. De GO-termverrijking laat verder zien dat termen als immune response, immunoglobulin complex en antigen binding sterk verrijkt zijn, wat wijst op actieve betrokkenheid van zowel het adaptieve als aangeboren immuunsysteem.
Deze resultaten sluiten aan bij bestaand onderzoek dat aantoont dat RA sterk wordt gekenmerkt door cytokine-afhankelijke ontsteking en autoantilichaamvorming (McInnes & Schett, 2011; Smolen et al., 2016).
 
Aanbeveling
Op basis van de gevonden resultaten zou het bij een vervolgonderzoek beter zijn om de groepen uit te breiden, meer controles en meer met RA. Ook is het interessant om te gaan kijken naar het verschil tussen man en vrouw, en hoe de genen zich zouden reguleren bij een patiënt die korter als 12 maanden gediagnosticeerd is met RA. Voor een vervolgonderzoek zou dit tot nieuwe inzichten leiden. 





