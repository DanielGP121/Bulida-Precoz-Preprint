#!/usr/bin/env bash
# SCRIPT: Creates small "mini-BAM" files for IGV visualization.
# This version is more robust as it pipes regions directly from the VCF to samtools,
# avoiding potential formatting issues with intermediate BED files.
set -euo pipefail

## ==================
## CONFIGURATION
## ==================

# --- Absolute paths to all required files and directories ---
BASE_PROJECT_DIR="/data/training2/analisis_TFM_Bulida_Precoz/TFM_Bulida_Precoz_Repository/7_Pre-print"
BAM_DIR="/data/training2/analisis_TFM_Bulida_Precoz/03_deduplication_picard"
VCF_CANDIDATES_FILE="/data/training2/analisis_TFM_Bulida_Precoz/08_parameter_change_analysis/mutect2_final_workflow/final_candidate_sets/mutect2_plus_propDP_15pct_strict_candidates.vcf.gz"

# Output directory
MINI_BAM_DIR="${BASE_PROJECT_DIR}/mini_bams_for_igv"

## ==================
## SCRIPT LOGIC
## ==================

echo "--- Starting Robust Mini-BAM creation workflow ---"

# Remove old directory to ensure a fresh start
rm -rf "${MINI_BAM_DIR}"
mkdir -p "${MINI_BAM_DIR}"

# Create a string of regions directly from the VCF for samtools
# The format is 'chr1:100-200 chr2:300-400 ...'
echo "Step 1: Extracting regions from VCF..."
REGIONS_STRING=$(zgrep -v "^#" "${VCF_CANDIDATES_FILE}" | awk '{start=$2-100; if(start<0) start=0; printf "%s:%s-%s ", $1, start, $2+100}')

if [ -z "${REGIONS_STRING}" ]; then
    echo "ERROR: Could not extract any regions from the VCF file. Please check the input VCF."
    exit 1
fi
echo "Regions extracted successfully."

# Loop to process each of the 8 samples
echo -e "\nStep 2: Subsetting BAM files..."
for sample in mt1 mt2 mt3 mt4 wt1 wt2 wt3 wt4; do
  echo "Creating mini-BAM for sample: ${sample}"

  INPUT_BAM="${BAM_DIR}/${sample}.dedup.bam"
  OUTPUT_BAM="${MINI_BAM_DIR}/${sample}.mini.bam"

  # Use the REGIONS_STRING directly with samtools view
  # This is more robust than using an intermediate BED file
  samtools view -b "${INPUT_BAM}" ${REGIONS_STRING} > "${OUTPUT_BAM}"

  # Index the new mini-BAM
  samtools index "${OUTPUT_BAM}"
done

echo -e "\nProcess complete! New Mini-BAMs should now contain data. They are located in: ${MINI_BAM_DIR}"