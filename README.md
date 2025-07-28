# A stop-gained mutation in a Peroxiredoxin gene underlies the low-chill phenotype of the apricot spontaneous mutant ‘Búlida Precoz’

**Author:** Daniel González Palazón  
**Thesis Project:** Work carried out at Estación Experimental de Aula Dei (EEAD-CSIC) and the University of Murcia.

## Project Overview

This repository contains the bioinformatic workflow for this pre-print, which builds upon and expands the foundational analysis developed for a Master's Thesis project focused on identifying the causal somatic mutations responsible for the early-flowering, low-chill phenotype of the 'Búlida Precoz' apricot (*Prunus armeniaca*) variant.

The analysis is centered on a somatic variant calling pipeline using **GATK Mutect2**, with results cross-validated by **GATK HaplotypeCaller**, followed by rigorous filtering, annotation, and comparative analysis based on whole-genome sequencing (WGS) data from mutant and wild-type replicates.

---

## Repository Structure and Documentation

All scripts used in this project are organized into directories corresponding to the main phases of the analysis.

**For a detailed explanation of the purpose, logic, and execution of each script, please refer to the included document: `Anexo_TFM_DanielGonzalezPalazon.pdf`.**

The repository is organized as follows:

* **`1_Initial_Data_Processing/`**: Contains all scripts related to the initial pre-processing of raw sequencing data, including quality control (FastQC), adapter trimming (Skewer), alignment (BWA-MEM), and duplicate marking (Picard).

* **`2_Variant_Calling/`**: Contains the scripts for the two primary variant calling pipelines using GATK HaplotypeCaller (for germline variants) and GATK Mutect2 (for somatic variants), including the creation of a Panel of Normals.

* **`3_GATK_Filtering_Workflow/`**: Contains the scripts for the experimental filtering workflow applied to the GATK HaplotypeCaller results, including the iterative proportional depth filtering and the final strict biological filtering.

* **`4_Mutect2_Analysis_Workflow/`**: Contains the scripts for the parallel filtering workflow applied to the Mutect2 results, including default GATK filters and the enhanced proportional depth filter.

* **`5_Functional_Annotation/`**: Contains all scripts related to the final biological analysis of the candidate genes, including protein sequence extraction, local BLAST searches, InterProScan analysis, and GO term annotation.

* **`6_Final_Analysis_Notebooks/`**: Contains the final Jupyter Notebook and R Markdown files used for the comprehensive comparative analysis, visualization (Venn diagrams, VAF plots), and Gene Ontology (GO) enrichment analysis.

* **`Anexo_TFM_DanielGonzalezPalazon.pdf`**: The complete annex of the thesis, which provides detailed documentation for every script in this repository.