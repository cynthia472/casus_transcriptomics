
#working directory instellen
setwd("C:/Users/cynthia/OneDrive - NHL Stenden/transcriptonomics/ncbi_dataset/uitwerking casus trans")

#controleren of working directory goed is ingesteld
getwd()

#bekijken welke bestanden in de map staan
list.files()

#zipbestand uitpakken
unzip("Data_RA_raw (1).zip", exdir = "data_reuma")

#installeren Rsubread en bioconductor
install.packages("BiocManager")
BiocManager::install("Rsubread")
library(Rsubread)
browseVignettes("Rsubread")

unzip ("ncbi_dataset.referentie_genoom.zip", exdir = "ref_human")

list.files("ref_human", recursive = TRUE, full.names = TRUE)

"ref_human/ncbi_dataset/data/GCF_000001405.40/GCF_000001405.40_GRCh38.p14_genomic.fna"

# Indexeren van het referentiegenoom
buildindex(
  basename = "ref_human",
  reference = "ref_human/ncbi_dataset/data/GCF_000001405.40/GCF_000001405.40_GRCh38.p14_genomic.fna",
  memory = 4000,
  indexSplit = TRUE
)


# Pad naar de map met de reads
read_path <- "data_reuma"

# Mapping per monster
align(index = "ref_human", readfile1 = file.path(read_path, "Data_RA_raw/SRR4785819_1_subset40k.fastq"), readfile2 = file.path(read_path, "Data_RA_raw/SRR4785819_2_subset40k.fastq"), output_file = "control1.BAM")
align(index = "ref_human", readfile1 = file.path(read_path, "Data_RA_raw/SRR4785820_1_subset40k.fastq"), readfile2 = file.path(read_path, "Data_RA_raw/SRR4785820_2_subset40k.fastq"), output_file = "control2.BAM")
align(index = "ref_human", readfile1 = file.path(read_path, "Data_RA_raw/SRR4785828_1_subset40k.fastq"), readfile2 = file.path(read_path, "Data_RA_raw/SRR4785828_2_subset40k.fastq"), output_file = "control3.BAM")
align(index = "ref_human", readfile1 = file.path(read_path, "Data_RA_raw/SRR4785831_1_subset40k.fastq"), readfile2 = file.path(read_path, "Data_RA_raw/SRR4785831_2_subset40k.fastq"), output_file = "control4.BAM")

align(index = "ref_human", readfile1 = file.path(read_path, "Data_RA_raw/SRR4785979_1_subset40k.fastq"), readfile2 = file.path(read_path, "Data_RA_raw/SRR4785979_2_subset40k.fastq"), output_file = "reuma1.BAM")
align(index = "ref_human", readfile1 = file.path(read_path, "Data_RA_raw/SRR4785980_1_subset40k.fastq"), readfile2 = file.path(read_path, "Data_RA_raw/SRR4785980_2_subset40k.fastq"), output_file = "reuma2.BAM")
align(index = "ref_human", readfile1 = file.path(read_path, "Data_RA_raw/SRR4785986_1_subset40k.fastq"), readfile2 = file.path(read_path, "Data_RA_raw/SRR4785986_2_subset40k.fastq"), output_file = "reuma3.BAM")
align(index = "ref_human", readfile1 = file.path(read_path, "Data_RA_raw/SRR4785988_1_subset40k.fastq"), readfile2 = file.path(read_path, "Data_RA_raw/SRR4785988_2_subset40k.fastq"), output_file = "reuma4.BAM")

#Rsamtools installeren en inladen
if (!requireNamespace("Rsamtools", quietly = TRUE)) {
  BiocManager::install("Rsamtools")
}

library(Rsamtools)

# Bestandsnamen van de monsters
samples <- c('control1', 'control2', 'control3', 'control4', 'reuma1', 'reuma2', 'reuma3', 'reuma4')

# Voor elk monster: sorteer en indexeer de BAM-file
# Sorteer BAM-bestanden
lapply(samples, function(s) {
  sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))
  indexBam(file = paste0(s, '.sorted.bam'))
})


#bestandsnamen in vector zetten
allsamples <- c(  "control1.BAM", "control2.BAM", "control3.BAM", "control4.BAM", "reuma1.BAM", "reuma2.BAM", "reuma3.BAM", "reuma4.BAM")

install.packages("readr")  # Run this only once to install the package
library(readr)

gff <- read_tsv("ncbi_dataset/data/GCF_000001405.40/genomic.gtf", comment = "#", col_names = FALSE)


# Kolomnamen toevoegen
colnames(gff) <- c("seqid", "source", "type", "start", "end", "score", "strand", "phase", "attributes")

install.packages("dplyr")   # Run once to install
library(dplyr) 

# Alleen genregels selecteren
gff_gene <- gff %>% filter(type == "gene")

# 'type' aanpassen naar 'exon' zodat featureCounts het accepteert
gff_gene$type <- "exon"

# Extraheer de chromosoomnaam uit BAM-header
bam_chr <- names(scanBamHeader("reuma1.BAM")[[1]]$targets)[1]
gff_gene$seqid <- bam_chr

samtools quickcheck -v contr1.BAM




count_matrix <- featureCounts(
  files = allsamples,
  annot.ext = "ncbi_dataset/data/GCF_000001405.40/genomic.gtf",
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE)

head(count_matrix$annotation)
head(count_matrix$counts)

# Bekijk eerst de structuur van het object
str(count_matrix)

# enkel de tellingen eruit halen
counts <- count_matrix$counts


colnames(counts) <- c( "Contr1", "Contr2", "Contr3", "Contr4", "Reuma1", "Reuma2", "Reuma3", "Reuma4")
rownames(counts) <- counts[, 1]

write.csv(counts, "bewerkt_countmatrix.csv")

head(counts)

countsgroot <- read.table("count_matrix (1).txt", row.names = 1)
getwd()

head(countsgroot)

groepering <- c("controle", "controle", "controle", "controle", "Reuma", "Reuma", "Reuma", "Reuma")
treatment_table <- data.frame(groepering)
rownames(treatment_table) <- c('SRR4785819', 'SRR4785820', 'SRR4785828', 'SRR4785831', 'SRR4785979', 'SRR4785980', 'SRR4785986', 'SRR4785988')

BiocManager::install('DESeq2')
BiocManager::install('KEGGREST')

library(DESeq2)
library(KEGGREST)

countsgroot <- round(countsgroot)

# Maak DESeqDataSet aan
dds <- DESeqDataSetFromMatrix(countData = countsgroot,
                              colData = treatment_table,
                              design = ~ groepering)

# DESeq analyse uitvoeren
dds <- DESeq(dds)
resultaten <- results(dds)

# Resultaten opslaan in een bestand
#Bij het opslaan van je tabel kan je opnieuw je pad instellen met `setwd()` of het gehele pad waar je de tabel wilt opslaan opgeven in de code.

write.table(resultaten, file = 'ResultatenCasus.csv', row.names = TRUE, col.names = TRUE)

sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm = TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm = TRUE)

# hoogste en laagste genen bekijken
hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]

head(laagste_p_waarde)

if (!requireNamespace("EnhancedVolcano", quietly = TRUE)) {
  BiocManager::install("EnhancedVolcano")
}
library(EnhancedVolcano)

EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj')

# Alternatieve plot zonder p-waarde cutoff (alle genen zichtbaar)
EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0)


dev.copy(png, 'VolcanoplotWC.png', 
         width = 8,
         height = 10,
         units = 'in',
         res = 500)
dev.off()


BiocManager::install("goseq", force = TRUE)
BiocManager::install("org.Hs.eg.db", force = TRUE)  
BiocManager::install("geneLenDataBase", force = TRUE)  
BiocManager::install("BiocParallel", force = TRUE)  
BiocManager::install("GO.db", force = TRUE)



library(geneLenDat)
library(goseq)
library(org.Dm.eg.db)
library(g)
library(BiocParallel)




head(resultaten)

library(dplyr)

# Convert to data frame
res_df <- as.data.frame(resultaten)

# Now filter works
DEG <- res_df %>%
  filter(padj < 0.05)

DEG <- as.data.frame(resultaten) %>%
  filter(padj < 0.05)
ALL <- rownames(resultaten)

DEG <- resultaten %>%
  filter(padj < 0.05)

DEG_names <- rownames(res_df %>% filter(padj < 0.05))

DEG <- rownames(DEG)

DEG

gene.vector <- as.integer(ALL %in% DEG)
names(gene.vector) <- ALL

pwf <- nullp(gene.vector, "hg19", "geneSymbol")  # of "ensGene" als je Ensembl gebruikt

GO.wall <- goseq(pwf, "hg19", "geneSymbol")
# of "ensGene" afhankelijk van je gen-ID's

enriched.GO <- GO.wall$category[GO.wall$over_represented_pvalue < 0.05]
length(enriched.GO)

enriched.GO.fdr <- GO.wall$category[p.adjust(GO.wall$over_represented_pvalue, method = "BH") < 0.05]

library(ggplot2)
library(dplyr)
library(GO.db)

GO.wall$FDR <- p.adjust(GO.wall$over_represented_pvalue, method = "BH")
top_GO <- GO.wall[GO.wall$FDR < 0.05, ]  
top_GO <- top_GO[order(top_GO$FDR), ][1:20, ]
library(GO.db)

top_GO$Term <- sapply(top_GO$category, function(go_id) {
  term <- tryCatch(Term(GOTERM[[go_id]]), error = function(e) NA)
  ifelse(is.na(term), go_id, term)
})

library(ggplot2)

#het maken van een barplot
print(
  ggplot(top_GO, aes(x = reorder(Term, -log10(FDR)), y = -log10(FDR))) +
    geom_bar(stat = "identity", fill = "steelblue") +
    coord_flip() +
    labs(
      title = "Top verrijkte GO-termen (FDR < 0.05)",
      x = "GO-term",
      y = expression(-log[10](FDR))
    ) +
    theme_minimal(base_size = 13)
)

plot(1:10)
head(top_GO)
summary(top_GO$FDR)
sum(is.na(top_GO$FDR))

str(top_GO$FDR)
summary(top_GO$FDR)

dev.off()

if (!requireNamespace("pathview", quietly = TRUE)) {
  BiocManager::install("pathview")
}
library(pathview)

if (!requireNamespace("KEGGREST", quietly = TRUE)) {
  BiocManager::install("KEGGREST")
}
library(KEGGREST)

resultaten[1] <- NULL
resultaten[2:5] <- NULL

pathview(
  gene.data = resultaten,
  pathway.id = "hsa05323",  # KEGG ID voor Biofilm formation – E. coli
  species = "hsa",          # 'eco' = E. coli in KEGG
  gene.idtype = "SYMBOL",     # Geef aan dat het KEGG-ID's zijn
  limit = list(gene = 5)    # Kleurbereik voor log2FC van -5 tot +5
)





library(pathview)

# Maak een named vector van log2FC
gene.data <- resultaten$log2FoldChange
names(gene.data) <- rownames(resultaten)

# Plot van de pathway
pathview(
  gene.data = gene.data,
  pathway.id = "hsa05323",     
  species = "hsa",
  gene.idtype = "SYMBOL",      
  limit = list(gene = 5)
)


getwd()


library(png)
library(grid)

img <- readPNG("hsa05323.pathview.png")
grid::grid.raster(img)
