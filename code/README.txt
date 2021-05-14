(1) map to host genome (breseq)
This is done to rempve host gDNA prior to assembly.
We use a close relative of the host (Bacillus megaterium KM BGSC) is Bacillus megaterium QM B1551. We can then use leftover reads for phage assembly.
To run breseq submit job:
$ sbatch code/map2host.sh

(2) Sychronizing paired reads after breseq (fastq_pair) # not working #
To take advantage of paired reads in assembly.
Using fastq_pair: https://github.com/linsalrob/fastq-pair/blob/master/INSTALLATION.md
Install fastq_pair in directory of choice:
$ git clone https://github.com/linsalrob/fastq-pair.git
$ cd fastq-pair
$ mkdir build && cd build
$ gcc -std=gnu99   ../main.c ../robstr.c ../fastq_pair.c ../is_gzipped.c  -o fastq_pair

#Do not run this, does not work!!
$ sbatch code/pair-unmatched.sh
# Breseq modifies the pair names so the pairing iss lost :(


(3) assemble de novo (unicycler)
Assembly with unmtached breseq out put, witout paired read data.
$ sbatch code/uni_assemble.sh

(4) gene calling
# installing Phanotate 1.5.0
pip3 install --user phanotate

#dependency
module load trnascan
# path to phanotate
PHAN=/geode2/home/u020/danschw/Carbonate/.local/bin/phanotate.py
# assembled fasta
IN=/N/slate/danschw/new-phage-genome/assembly/uni-cycler/assembly.fasta 
OUT=/N/slate/danschw/new-phage-genome/annotation/phanotate
mkdir -p $OUT
cd $OUT
$PHAN $IN > phanotate.tsv
$PHAN -f genbank $IN > phanotate.gb
$PHAN -f fasta $IN > phanotate.fa


(5)annotation
module unload python/3.6.8
module load anaconda/python3.7/2019.03 
module unload perl
module load hmmer/3.1 
module load prokka
# prokka version 1.14.6 loaded.
FASTA=/N/slate/danschw/new-phage-genome/assembly/uni-cycler/assembly.fasta
OUT=/N/slate/danschw/new-phage-genome/annotation/prokka

prokka --compliant --centre IU --outdir "${OUT}" --usegenus --genus Caudovirales --prefix vB_Bmeg_DW2 --locustag DW2g "${FASTA}"

FASTA=/N/slate/danschw/new-phage-genome/assembly/uni-cycler/assembly.fasta
PHANS=/N/slate/danschw/new-phage-genome/annotation/phanotate/phanotate.fa
OUT=/N/slate/danschw/new-phage-genome/annotation/prokka3
prokka --cpus 0 --compliant --centre IU --outdir "${OUT}" --prefix vB_Bmeg_DW2 --locustag DW2g --proteins $PHANS $FASTA


(6) map reads to assembled (phannotae gbk as ref)
sbatch code/map2assembly.sh

map reads to assembled (bowtie2)
bash sbatch code/bowtie2assembly.sh
#plot
module load r
Rscript code/plot-cvg.R 
(7) 
 blastn -db nt -query phanotate.fa -out results-blastn.out -remote

