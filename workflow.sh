#!/bin/bash

# Move into data directory
cd data

# Start conda environments
conda init --all 

source activate snippy

# Loop over directory names, annotate genomes and move into data
for dir in */
do 
	prokka --outdir ./$dir/annotate ./$dir/* 
	cp $dir\annotate/*.gff $dir\annotate/${dir%/}.gff
	cp $dir\annotate/G*.gff /project/data
done
conda deactivate	

# Runs roary
source activate roary
enc2xs -C
cpan File::Find::Rule
roary -p 6 -e -n -f alignment *.gff
conda deactivate 

# Runs panaroo
source activate panaroo
mkdir ../results
panaroo -i *.gff -o ../results -t 6 -a core --aligner mafft --clean-mode moderate --core_threshold 0.99
conda deactivate

# Runs iqtree
conda activate snippy
iqtree2 -s ../results/ -nt 8 -mem 8GB -m HKY+F -B 2000