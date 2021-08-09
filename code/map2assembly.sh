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
ODIR=${PARENT}/assembly/map2assembly
mkdir -p ${ODIR}
# sequencing data
R1=${PARENT}/assembly/map2host/data/*R1*unmatched.fastq
R2=${PARENT}/assembly/map2host/data/*R2*unmatched.fastq

# reference genome
REF=/N/slate/danschw/new-phage-genome/annotation/phanotate/phanotate.gb


#### Assemble ####
breseq -j 12 -r $REF -o ${ODIR} ${R1} ${R2} 
	
