
# -------------------------------------------------------------------------------------------------------------------------# 

## HLA-E, HLA-F, HLA-G, MICA and MICB imputation

# -------------------------------------------------------------------------------------------------------------------------#

# functions and libraries
source('src/functions.R')

# computing nodes
cl <- makeCluster(4)


## Read MHC genotype data 

genotypes <- hlaBED2Geno(bed.fn='/full/path/to/data/MHC.bed', 
                          bim.fn='/full/path/to/data/MHC.bim', 
                          fam.fn='/full/path/to/data/MHC.fam', 
                          assembly='hg38')

## imputation

# load models
model_MICA <- hlaModelFromObj(get(load('models/path_to_model_MICA.RData')))
model_MICB <- hlaModelFromObj(get(load('models/path_to_model_MICB.RData')))
model_HLA_E <- hlaModelFromObj(get(load('models/path_to_model_HLA_E.RData')))
model_HLA_F <- hlaModelFromObj(get(load('models/path_to_model_HLA_F.RData')))
model_HLA_G <- hlaModelFromObj(get(load('models/path_to_model_HLA_G.RData')))
model_HLA_G_3UTR <- hlaModelFromObj(get(load('models/path_to_model_HLA_G_3UTR.RData')))
model_HLA_G_5UTR <- hlaModelFromObj(get(load('models/path_to_model_HLA_G_5UTR.RData')))

# run imputation
imputed_MICA  <- predict(model_MICA, genotypes, type='response+prob', match.type='Position', cl=cl)
imputed_MICB  <- predict(model_MICB, genotypes, type='response+prob', match.type='Position', cl=cl)
imputed_HLA_E  <- predict(model_HLA_E, genotypes, type='response+prob', match.type='Position', cl=cl)
imputed_HLA_F  <- predict(model_HLA_F, genotypes, type='response+prob', match.type='Position', cl=cl)
imputed_HLA_G  <- predict(model_HLA_G, genotypes, type='response+prob', match.type='Position', cl=cl)
imputed_HLA_G_3UTR  <- predict(model_HLA_G_3UTR, genotypes, type='response+prob', match.type='Position', cl=cl)
imputed_HLA_G_5UTR  <- predict(model_HLA_G_5UTR, genotypes, type='response+prob', match.type='Position', cl=cl)

# save results in table format
write.table(imputed_MICA$value, 'results/MICA_imputed.tsv', quote=F, sep='\t', row.names=F)
write.table(imputed_MICB$value, 'results/MICB_imputed.tsv', quote=F, sep='\t', row.names=F)
write.table(imputed_HLA_E$value, 'results/HLA_E_imputed.tsv', quote=F, sep='\t', row.names=F)
write.table(imputed_HLA_F$value, 'results/HLA_F_imputed.tsv', quote=F, sep='\t', row.names=F)
write.table(imputed_HLA_G$value, 'results/HLA_G_imputed.tsv', quote=F, sep='\t', row.names=F)
write.table(imputed_HLA_G_3UTR$value, 'results/HLA_G_3UTR_imputed.tsv', quote=F, sep='\t', row.names=F)
write.table(imputed_HLA_G_5UTR$value, 'results/HLA_G_5UTR_imputed.tsv', quote=F, sep='\t', row.names=F)

# save full results
saveRDS(imputed_MICA, file='results/MICA_imputed.rds')
saveRDS(imputed_MICB, file='results/MICB_imputed.rds')
saveRDS(imputed_HLA_E, file='results/HLA_E_imputed.rds')
saveRDS(imputed_HLA_F, file='results/HLA_F_imputed.rds')
saveRDS(imputed_HLA_G, file='results/HLA_G_imputed.rds')
saveRDS(imputed_HLA_G_3UTR, file='results/HLA_G_3UTR_imputed.rds')
saveRDS(imputed_HLA_G_5UTR, file='results/HLA_G_5UTR_imputed.rds')


## convert imputed data to dosage with imputation PP info

# imputed_MICA <- readRDS('results/MICA_imputed.rds')
# imputed_MICB <- readRDS('results/MICB_imputed.rds')
# imputed_HLA_E <- readRDS('results/HLA_E_imputed.rds')
# imputed_HLA_F <- readRDS('results/HLA_F_imputed.rds')
# imputed_HLA_G <- readRDS('results/HLA_G_imputed.rds')
# imputed_HLA_G_3UTR <- readRDS('results/HLA_G_3UTR_imputed.rds')
# imputed_HLA_G_5UTR <- readRDS('results/HLA_G_5UTR_imputed.rds')

imputation2dosage(imputed_MICA, 'MICA', 'results/MICA_imputed')
imputation2dosage(imputed_MICB, 'MICB', 'results/MICB_imputed')
imputation2dosage(imputed_HLA_E, 'E', 'results/HLA_E_imputed')
imputation2dosage(imputed_HLA_F, 'F', 'results/HLA_F_imputed')
imputation2dosage(imputed_HLA_G, 'G', 'results/HLA_G_imputed')
imputation2dosage(imputed_HLA_G_3UTR, 'G', 'results/HLA_G_3UTR_imputed')
imputation2dosage(imputed_HLA_G_5UTR, 'G', 'results/HLA_G_5UTR_imputed')




