#!/bin/bash
#SBATCH --mail-user=danschw@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --time=06:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --job-name=uniCyc

#### Load modules for fastQC ####

module load unicycler

##### Define paths #####
PARENT=/N/slate/danschw/new-phage-genome
ODIR=${PARENT}/assembly/uni-cycler
mkdir -p ${ODIR}
# sequencing data
R1=${PARENT}/assembly/map2host/data/*R1*unmatched.fastq
R2=${PARENT}/assembly/map2host/data/*R2*unmatched.fastq


#### Assemble ####
unicycler -s ${R1} -s ${R2}  -o ${ODIR} -t 12 --keep 2 --mode normal
	

### if pairing would work could run this:
#	# sequencing data
#	R1=${PARENT}/assembly/pair-unmatched/*R1*unmatched*paired.fq
#	R2=${PARENT}/assembly/pair-unmatched/*R2*unmatched*paired.fq
#
#
#	#### Assemble ####
#	unicycler -1 ${R1} -2 ${R2}  -o ${ODIR} -t 12 --keep 2 --mode normal
	
