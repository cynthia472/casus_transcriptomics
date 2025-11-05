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
Analyse die is uitgevoerd op synoviumbiopten van patiënten met reumatoïde artritis (RA) en gezonde controlepersonen. Het doel van deze analyses was om verschillen in genexpressie tussen beide groepen te identificeren en te onderzoeken welke biologische processen en pathways hierbij betrokken zijn. Er is gekeken naar de differentiële genexpressie, KEGG-patwayanalyse en de GO-termverrijking. De bijbehorende figuren en tabellen zijn opgenomen in de map [resultaten/](./resultaten/) van deze GitHub-repository.

De differentiële genexpressieanalyse uitgevoerd met DESeq1 gaf een dataset met 29.407 geanalyseerde genen met een aangepaste p-waarde <0.05 en een log2 fold change groter dan 1 hadden. De ![Volcano plot](./resultaten/volcano_plot.png) laat zien welke genen significant op en neerwaarts gereguleerd zijn. De genen in rood weergegeven zijn zowel statistisch als biologische significant. Enkele opvallende opgereguleerde genen zijn ANKRD30BL, BCL2A1, COL6A5, CXCR1, IGKV1-39, PTGFR.

![Figuur 2: Volcano plot van differentiële genexpressie tussen RA-patiënten en gezonde controles. De plot toont de log₂-fold change (horizontale as) tegenover de –log₁₀(p-waarde) (verticale as) van 29.407 genen. Rode punten geven genen weer die zowel significant zijn (p < 0,05) als een sterke expressieverandering vertonen (|log₂FC| > 1). Groene punten zijn genen met een significante expressieverandering, en grijze punten zijn niet significant.](https://github.com/cynthia472/casus_transcriptomics/blob/main/resultaten/volcano%20plot.png) *Figuur 2: Volcano plot van differentiële genexpressie tussen RA-patiënten en gezonde controles. De plot toont de log₂-fold change (horizontale as) tegenover de –log₁₀(p-waarde) (verticale as) van 29.407 genen. Rode punten geven genen weer die zowel significant zijn (p < 0,05) als een sterke expressieverandering vertonen (|log₂FC| > 1). Groene punten zijn genen met een significante expressieverandering, en grijze punten zijn niet significant.*

De KEGG patway-analyse toont de betrokken genen binnen het Reumatoide artritis pathway. Kleuren geven de mate van expressieverandering weer: rood de opregulatie en groen de downregulatie. Binnen dit pathway vallen vooral de genen IL6, IL1B, TNF, RANKL, MMP9, IFNG, CD28, CD80 en CTLA4 op als sterk opgereguleerd en genen als TGFβ, IL4, IL23 zijn neerwaarts gereguleerd. 

![
<img width="1398" height="754" alt="image" src="https://github.com/user-attachments/assets/94941877-3c32-46af-b03a-19d19366bb88" />
figuur 2:


De GO verrijkingsanalyse liet zien dat genen die differentieel tot expressie komen significant betrokken zijn bij de biologische processen die verband houden met het immuunsysteem. De top Go-termen (p-waarde < 0.05). 

<img width="588" height="600" alt="image" src="https://github.com/user-attachments/assets/0778faef-f968-4d06-9221-666a056309bb" />

figuur 3:   


# conclusie
Er is een data analyse uitgevoerd in R om afwijkende expressie van genen en pathways te vinden bij patiënten met Reumatoide artritis. Uit de anaylse blijkt dat RA gepaard gaat met een verstoring van immuun en ontstekingsroutes in het synoviale weefsel. De KEGG-pathwayanalyse toont opregulatie van centrale cytokinen, waaronder Il6, TNF, iL1B en IFNG, wat wijst op een verhoogde ontstekingsactiviteit.  Dit wordt ondersteund door de genexpressieanalyse (volconao plot), waarim meerrdere genen betrokken bij apoptose significant tot expressie kwamen.

De GO-termverrijkingsanalyse laat verder zien dat deze genen vooral betrokken zijn bij processen als immune response, immunoglobulin complex en antigen binding. Wat wijst op actieve betrokkenheid van zowel het adaptieve als aangeboren immuunsysteem.
Deze bevindingen sluiten aan bij bestaand onderzoek dat aantoont dat RA sterk wordt gekenmerkt door cytokine-afhankelijke ontsteking en autoantilichaamvorming [McInnes & Schett, 2011](https://www.nejm.org/doi/abs/10.1056/NEJMra1004965); [Smolen et al., 2016](https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(16)30173-8/abstract).
 
Aanbeveling
Voor vervolgonderzoek is het aan te raden het aantal groepen uit te breiden, meer controles en meer patiënten met RA, zodat de betrouwbaarheid van het onderzoek toeneemt. Daarnaast kan het ook waardevol zijn om te kijken naar het verschil tussen man en vrouw en hoe de genen zich zouden reguleren bij een patiënt die korter als 12 maanden gediagnosticeerd is met RA. Voor een vervolgonderzoek zou dit tot nieuwe inzichten leiden. 



