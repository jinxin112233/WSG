##Dependencies
#minimap2 v2.17-r941; purge_dups v1.2.3

minimap2 -I6G -xmap-pb genome.fa HiFi.fq.gz -t 12  > read-aln.paf
pbcstat read-aln.paf
calcuts PB.stat > cutoffs
split_fa done.fasta > split.fa
minimap2 -I6G -xasm5 -DP split.fa split.fa -t 12 > ctg-aln.paf
purge_dups -2 -T cutoffs -c PB.base.cov ctg-aln.paf > dups.bed
get_seqs dups.bed genome.fa

##Reference
#Li, H. Minimap2: pairwise alignment for nucleotide sequences. Bioinformatics 34, 3094–3100 (2018).
#Guan, D. et al. Identifying and removing haplotypic duplication in primary genome assemblies. Bioinformatics 36, 2896–2898 (2020).
