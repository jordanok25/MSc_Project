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

# Runs panaroo
source activate panaroo
mkdir ../results
panaroo -i *.gff -o ../results -t 6 -a core --aligner mafft --clean-mode moderate --core_threshold 0.99
conda deactivate

# Runs iqtree
source activate snippy
iqtree2 -s ../results/core_gene_alignment_filtered.aln -nt 8 -mem 8GB  -B 20000 
