#!/bin/bash
#SBATCH --mail-user=danschw@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --time=06:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --job-name=map2host

#### Load modules for fastQC ####

module load breseq

##### Define paths #####
PARENT=/N/slate/danschw/new-phage-genome
ODIR=${PARENT}/assembly/map2host
mkdir -p ${ODIR}
# sequencing data
R1=${PARENT}/data/*R1*fastq.gz
R2=${PARENT}/data/*R2*fastq.gz

# get reference genome
cd ${ODIR}
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/025/825/GCF_000025825.1_ASM2582v1/GCF_000025825.1_ASM2582v1_genomic.gbff.gz
gunzip GCF_000025825.1_ASM2582v1_genomic.gbff.gz


#### Assemble ####
breseq -j 12 -r GCF_000025825.1_ASM2582v1_genomic.gbff ${R1} ${R2} 
	
