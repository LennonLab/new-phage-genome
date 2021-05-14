#!/bin/bash
#SBATCH --mail-user=danschw@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --time=06:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --job-name=map2assembly

#### Load modules ####

module load bowtie2
module load samtools
module load bedtools

##### Define paths #####
PARENT=/N/slate/danschw/new-phage-genome
ODIR=${PARENT}/assembly/bowtie2assembly
mkdir -p ${ODIR}
cd ${ODIR}

# sequencing data
R1=${PARENT}/data/*R1*fastq.gz
R2=${PARENT}/data/*R2*fastq.gz

# reference genome (assembly)
REF=${PARENT}/assembly/uni-cycler/assembly.fasta


# create an index for the Lambda phage reference genome
bowtie2-build -f $REF assembly
#### Assemble ####
(bowtie2 --very-fast -x assembly -1 ${R1} -2 ${R2} -S $ODIR/assembly.sam --un-gz $ODIR/unmapped) 2> log.txt

#### get coverage ####

samtools view -S -b assembly.sam > assembly.bam
samtools sort assembly.bam -o assembly-sorted.bam
bedtools genomecov -ibam  assembly-sorted.bam > assembly.cvg



	
