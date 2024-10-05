#!/bin/bash
#SBATCH -A b1042
#SBATCH -p genomics
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 4:00:00
#SBATCH --mem=24gb

module purge all

module load bcl2fastq

##### IMPORTANT: update all paths as they will be specific to your computer or HPC
##### USAGE: nano bcl2fastq.sh, copy and paste this file, then either run sh bcl2fastq.sh or sbatch bcl2fastq.sh depending of if you are running on your computer or directly on HPC login node or submitting to scheduler

INdirectory=/path/to/input_folder # this will be the parent folder of the run, like /path/to/231026_MN00494_0066_A000H5TWGJ ## you can check it is the right folder by running the ls -lah command in Unix, you should see folders like 'Data', 'Images', and 'Logs' among other folders and files
OUTdirectory=/path/to/output_folder

mkdir ${OUTdirectory}
cd ${OUTdirectory}

# in this case the sample sheet contains all of the necessary information for demultiplexing ## while for running on an Illumina platform, both the library kit tsv and the sample sheet csv are necessary
bcl2fastq -r 8 -p 8 -w 8 --runfolder-dir ${INdirectory} --sample-sheet /path/to/SampleSheet_v1_example.csv --output-dir ${directory}/output

## see the bcl2fastq github for more information or run bcl2fastq --help

exit

# end of file