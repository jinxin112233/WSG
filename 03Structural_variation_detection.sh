##Dependencies
#nucmer v4.0.0rc1; SYRI

nucmer --maxmatch -c 500 -b 500 -l 100 -t 24 hap1.fa hap2.fa
delta-filter -m -i 90 -l 100 out.delta > out_filter.delta
show-coords -THrd out_filter.delta > out.filtered.coords
syri -c ./out.filtered.coords -d ./out_filter.delta -r hap1.fa -q hap2.fa
awk '{if($1==$6)print}' syri.out > syri_filter.txt
plotsr syri_filter.txt hap1.fa hap2.fa -H 10 -W 4

##Reference
#Marçais, G. et al. MUMmer4: A fast and versatile genome alignment system. PLoS Comput. Biol. 14, e1005944 (2018).
#Goel, M., Sun, H., Jiao, W. B. & Schneeberger, K. SyRI: finding genomic rearrangements and local sequence differences from whole-genome assemblies. Genome Biol. 20, 277 (2019).


