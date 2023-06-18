##Dependencies
#jellyfish v.2.2.10; GenomeScope v1.0

jellyfish count -C -m 21 -s 1000000000 -t 10 *.fastq -o reads.jf
jellyfish histo -t 10 -h 25000 reads.jf > reads.histo
genomescope.R reads.histo 21 150 output

##Reference
#Vurture, G. W. et al. GenomeScope: fast reference-free genome profiling from short reads. Bioinformatics 33, 2202–2204 (2017).
#Marçais, G. & Kingsford, C. A fast, lock-free approach for efficient parallel counting of occurrences of k-mers. Bioinformatics 27, 764–770 (2011).

