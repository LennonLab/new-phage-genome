#!/bin/bash
#SBATCH --mail-user=danschw@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --time=06:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --job-name=pair

#### Load modules ####

# local intalation of fastq-pair
FQPAIR=/geode2/home/u020/danschw/Carbonate/my_tools/fastq-pair/build

##### Define paths #####
PARENT=/N/slate/danschw/new-phage-genome
ODIR=${PARENT}/assembly/pair-unmatched
mkdir -p ${ODIR}
# sequencing data
R1=${PARENT}/assembly/map2host/data/*R1*unmatched.fastq
R2=${PARENT}/assembly/map2host/data/*R2*unmatched.fastq

cp $R1 $ODIR
cp $R2 $ODIR

R1=${ODIR}/*R1*unmatched.fastq
R2=${ODIR}/*R2*unmatched.fastq

#### Pair ####
cd ${FQPAIR}
./fastq_pair -t 500000 ${R1} ${R2}  

