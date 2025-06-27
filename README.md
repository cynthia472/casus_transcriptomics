# Transcriptomics Analyse van Reumatoïde Artritis (RA)
Welkom op deze GitHub-repository, waarin een complete RNA-seq analyse wordt uitgevoerd op synoviumbioplten van patiënten met Reumatoïde Artriis en gezonde controles. waarin een complete RNA-seq analyse wordt uitgevoerd op synoviumbiopten van patiënten met Reumatoïde Artritis (RA) en gezonde controles. Deze analyse richt zich op het identificeren van differentieel tot expressie gebrachte genen en betrokken biologische pathways.

# Inhoud/structuur
data/raw/ - onbewerkte data van Reumatoïde Artritis en controle 
scripts/ - om het onderzoek reproduceerbaar te maken
resultaten/ - grafieken en tabellen 
bronnen? - de gebruikte bronnen 
README.md - document om de teks in github te genereren 
assets/ - overige documenten
data_stewardship - Om de competentie beheren aan te tonen


# aanleiding

Reumatoïde Artritis (RA) is een systemische auto-immuunziekte waarbij het immuunsysteem lichaamseigen weefsels aanvalt. Een belangrijk kenmerk van RA is synovitis, een ontsteking van het gewrichtsslijmvlies, wat leidt tot gewrichtsschade (Radu & Bungau, 2021). De precieze oorzaak is nog onbekend, maar genetische aanleg, omgevingsfactoren en een ontspoord immuunsysteem spelen waarschijnlijk een rol.

Een vroege diagnose is belangrijk om onomkeerbare gewrichtsschade te voorkomen. Door de aanwezigheid van klinische symptonen en aanwezigheid van autoanistoffen, zoals ACPA (anti-CCP), dat aanwezig is bij RA-patiënten. Er bestaat geen genezing voor RA, maar het ziekteproces kan worden afgeremd met medicatie.

Transcriptomics, het analyseren van genexpressie, kan inzicht geven in de onderliggende biologische processen van RA. In dit onderzoek worden RNA-seq-data van synoviumbiopten geanalyseerd van vier RA-patiënten (ACPA-positief, diagnose >12 maanden) en vier controlepersonen (ACPA-negatief). De dataset is afkomstig uit een eerder onderzoek van Platzer et al. (2019). Met behulp van R-software wordt onderzocht welke genen significant anders tot expressie komen bij RA, wat kan bijdragen aan een beter begrip van het ziektemechanisme en mogelijk nieuwe aanknopingspunten voor behandeling oplevert.



# Methoden
In dit onderzoek is een RNA‑seq‑analyse uitgevoerd op synoviaal weefsel van vier reumatoïde artritis (RA)‑patiënten en vier gezonde controles. De volledige analyse is geautomatiseerd via een Nextflow-pipeline en gescript in R (versie 4.5.0). 

De workflow omvat zes opeenvolgende stappen. als eerste werd de kwaliteit van de ruwe FASTQ-bestanden beoordeeld met de FastQC (v0.11.9), samengevat met MultiQC (v1.14). Hierna volgde kwaliteits- en adaptertrimming. De opgeschoonde reads zijn vervolgens uitgelijnd op het humane referentiegenoom (GRCh38) met behulp van de 2-pass aligner (v2.7.11a).

De kwantisering van genexpressie werd uitgevoerd met featureCounts (Subread v2.0.3), waarmee het aantal reads per gen werd bepaald. Voor de differentiële genexpressie-analyse is gebruikgemaakt van het R-pakket DESeq2 (v1.40). Genen werden als significant beschouwd bij een adjusted p-waarde < 0,05 en |log₂ fold change| > 1.

Ten slotte werd functionele verrijking uitgevoerd met clusterProfiler (v4.8), gericht op Gene Ontology (GO)-termen en KEGG-pathways. Genannotatie werd opgehaald via org.Hs.eg.db (v3.18).



# resultaten


De gebruikte scripts bevinden zich in de map /scripts, zijn modulair opgebouwd en voorzien van duidelijke documentatie. De gehele pipeline is tevens visueel weergegeven als stroomschema in figures/pipeline.svg.

