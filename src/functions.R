
## libs
library(HIBAG)
library(parallel)
library(data.table)
library(tidyverse)

## opts
options(stringsAsFactors=F)


# # -----------------------------------------
# # functions
# # -----------------------------------------

# conversion to imputed allele dosage table
imputation2dosage <- function(i.data, hla.gene, outfile) {
  
  # i.data    = HIBAG imputation result object
  # hla.gene  = HLA/MIC gene
  # outfile   = output VCF path/filename
  
  # list of alleles in input data
  allele.list <- i.data$value %>% .[, 2:3] %>% unlist %>% unique
  
  # posterior prob table
  i.data <- i.data$postprob
      
  # gene start positions in hg38 according to GRCh38.p14 (GRCh38:CM000668.2)
  hla.genepos <- data.frame(gene=c('E', 'F', 'G', 'MICA', 'MICB'), 
                            start=c(30.489509, 29.722775, 29.826967, 31.399784, 31.494881)*1e6) %>% 
    filter(gene==hla.gene)
  
  # collect imputed alleles
  out.alleles.pp <- map(allele.list, function(x) {
    num.alleles <- str_count(rownames(i.data), x)
    num.alleles <- num.alleles[num.alleles>0]
    allele.pp   <- i.data[str_detect(rownames(i.data), x), ] %>% data.frame 
    allele.pp   <- allele.pp*num.alleles # take into account heterozyg.
    allele.pp %>% colSums() %>% return()
  }) %>% do.call(cbind, .) %>% t()
    
  # plink dosage format
  out <- data.frame(POS=hla.genepos$start, # include position as the fisrt col
                    SNP=allele.list,
                    A1='<present>',
                    A2='<absent>',
                    out.alleles.pp)
  out$SNP <- paste0(hla.gene, '*', out$SNP)
  
  # plink fam file
  tmp.fam <- data.frame(colnames(out)[-c(1:4)], colnames(out)[-c(1:4)], 0, 0, 0, 0)
  
  # sample IDs to dosage file
  colnames(out)[-c(1:4)] <- paste(colnames(out)[-c(1:4)], colnames(out)[-c(1:4)]) 
  
  # write to tmp
  fwrite(out,     'tmp/tmp.dosage', sep='\t')
  fwrite(tmp.fam, 'tmp/tmp.dosage.fam', sep='\t', col.names=F)
  
  # coversion to plink dosage
  plinkCommand <- paste0("module load plink;plink2 --import-dosage tmp/tmp.dosage single-chr=6 ref-first skip0=1 ",
                "pos-col-num=1 --fam tmp/tmp.dosage.fam --recode A --out ", outfile)
  system(plinkCommand)
  
  # coversion to VCF
  # imputation dosage PP information is included in the GP field
  plinkCommand2 <- paste0("module load plink;plink2 --import-dosage tmp/tmp.dosage single-chr=6 ref-first skip0=1 ",
                         "pos-col-num=1 --fam tmp/tmp.dosage.fam --export vcf vcf-dosage=GP --out ", outfile)
  system(plinkCommand2)

}

