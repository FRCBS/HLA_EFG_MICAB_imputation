# HLA-E/F/G and MICA/B imputation from SNP data

Repository for code, summary statistics and imputation reference panels for MICA, MICB, HLA-E, HLA-F, and HLA-G

Tammi S, Koskela S, Blood Service Biobank, Hyvärinen K, Partanen J, Ritari J: Accurate multi-population imputation of MICA, MICB, HLA-E, HLA-F and HLA-G alleles from genome SNP data

## code (./src)

`imputation.R` example of running imputations for MICA, MICB, HLA-E, HLA-F, HLA-G, HLA-G 3'UTR and HLA-G 5'UTR

`functions.R` function for converting imputation results to dosage VCF

## reference panels (./models/)

# 1000/FIN (./models/1000G_FIN/)
Trained MICA, MICB, HLA-E, HLA-F, HLA-G and HLA-G UTR imputation models in human genome build hg38. Models for MICA, MICB, HLA-E and HLA-F have been trained using Finnish and 1000 Genomes reference data in difference data compositions I-VII. Models for HLA-G, HLA-G 3'UTR and HLA-G 5'UTR have been trained using Finnish reference data only (data composition I) . The reference data compositions and SNP sets used in the training of the models are summarized in `Model_summary_statistics.xlsx`, sheet `1000_FIN_models`.

If imputing non-Finnish data, we recommend using models V-VII. For Finnish data, we recommend using models I or VI.

# GSA (./models/GSA/)
Models fitted for the Illumina Global Screening Array (GSA) SNP content in human genome build hg38.
Models for MICA, MICB, HLA-E and HLA-F have been trained using the Finnish and 1000 Genomes reference data. Models for HLA-G, HLA-G 3'UTR and HLA-G 5'UTR have been trained using Finnish reference data only. The SNP sets used in the training of the models are summarized in `Model_summary_statistics.xlsx`, sheet `GSA_models`.

# PMRA (./models/PMRA/)
Models fitted for the ThermoFisher Precision Medicine Research Array SNP content in human genome build hg38.
Models for MICA, MICB, HLA-E and HLA-F have been trained using the Finnish and 1000 Genomes reference data. Models for HLA-G, HLA-G 3'UTR and HLA-G 5'UTR have been trained using Finnish reference data only. The SNP sets used in the training of the models are summarized in `Model_summary_statistics.xlsx`, sheet `PMRA_models`.

