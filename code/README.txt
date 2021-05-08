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


(1) assemble de novo (unicycler)
Assembly with unmtached breseq out put, witout paired read data.
$ sbatch code/uni_assemble.sh
