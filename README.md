# HLA_EFG_MICAB_imputation

Repository for code, summary statistic and imputation reference panels for HLA-E, -F, -G and MICAB

Tammi S, Koskela S, Blood Service Biobank, Hyvärinen K, Partanen J, Ritari J: Accurate imputation of non-classical HLA-E, -F and -G and MICA and MICB alleles from genome SNP data

## code (./src)

`imputation.R` example of running imputation using models VI for MICA, MICB, HLA-E, HLA-F and models I for HLA-G, HLA-G 3'UTR and HLA-G 5'UTR

`functions.R` function for converting imputation results to dosage VCF

## reference panels (./models)
Trained MICA, MICB, HLA-E, HLA-F, HLA-G and HLA-G UTR imputation models for hg38 human genome build. Models for MICA, MICB, HLA-E and HLA-F have been trained using Finnish and 1000 Genomes reference data in difference data compositions I-VII. Models for HLA-G, HLA-G 3'UTR and HLA-G 5'UTR have been trained using Finnish reference data only (data composition I) . The reference data compositions and SNP sets used in the training of the models are summarized in `Model_summary_statistics.xlsx`.



