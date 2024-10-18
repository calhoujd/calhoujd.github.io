#!/bin/bash
#SBATCH -A p32502
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 0:20:00 
#SBATCH --mem=12gb 
                       
# usage ## sbatch jellyfish_script_e37_v1.sh CB 1 1 ampseq_May2024
# script will generalize across all TSC2_exon42cp ampSeq runs; always name sub-folder TSC2_exon37

####
                        
module purge all
module load jellyfish/2.3.0

####

# adjustment from e17 template code: add myID3

myID1=$1
myID2=$2
myID3=$3 
ampSeqPath=/projects/b1073/Ampseq/$4/TSC2_exon37

####

# change directory

cd $ampSeqPath
mkdir jellyfish

# read 1 
## did this manually ## commented out
#gunzip ${myID1}${myID2}_S${myID3}_L001_R1_001.fastq.gz

# paired end
#jellyfish bc -m 43 -s 1G -t 4 -o homo_sapiens${myID1}${myID2}.bc -C ${myID1}${myID2}_S${myID3}_L001_R1_001.fastq
#jellyfish count -m 43 -s 1G -t 4 -o mer_counts${myID1}${myID2}.jf --bc homo_sapiens${myID1}${myID2}.bc --if /projects/b1073/Ampseq/ampSEQ_19aug2023/TSC2_exon37/TSC2_e37_kmerLIB.fasta -C ${myID1}${myID2}_S${myID3}_L001_R1_001.fastq

# single end
jellyfish bc -m 43 -s 1G -t 4 -o homo_sapiens${myID1}${myID2}.bc -C ${myID1}${myID2}_S${myID3}_R1_001.fastq
jellyfish count -m 43 -s 1G -t 4 -o mer_counts${myID1}${myID2}.jf --bc homo_sapiens${myID1}${myID2}.bc --if /projects/b1073/Ampseq/ampSEQ_19aug2023/TSC2_exon37/TSC2_e37_kmerLIB.fasta -C ${myID1}${myID2}_S${myID3}_R1_001.fastq

jellyfish dump mer_counts${myID1}${myID2}.jf > mer_counts_dumps${myID1}${myID2}.fa
mv mer_counts_dumps${myID1}${myID2}.fa jellyfish/${myID1}${myID2}_R1_kmerCount.fa

#cleanup
rm homo_sapiens${myID1}${myID2}.bc
rm mer_counts${myID1}${myID2}.jf


# read 2 ## this example dataset is only SE150 so these lines are commented out

#gunzip ${myID1}${myID2}_S${myID3}_L001_R2_001.fastq.gz

#jellyfish bc -m 43 -s 1G -t 4 -o homo_sapiens${myID1}${myID2}.bc -C ${myID1}${myID2}_S${myID3}_L001_R2_001.fastq

#jellyfish count -m 43 -s 1G -t 4 -o mer_counts${myID1}${myID2}.jf --bc homo_sapiens${myID1}${myID2}.bc --if /projects/b1073/Ampseq/ampSEQ_19aug2023/TSC2_exon37/TSC2_e37_kmerLIB.fasta -C ${myID1}${myID2}_S${myID3}_L001_R2_001.fastq

#jellyfish dump mer_counts${myID1}${myID2}.jf > mer_counts_dumps${myID1}${myID2}.fa
#mv mer_counts_dumps${myID1}${myID2}.fa jellyfish/${myID1}${myID2}_R2_kmerCount.fa

#cleanup
#rm homo_sapiens${myID1}${myID2}.bc
#rm mer_counts${myID1}${myID2}.jf

exit

# end of script
