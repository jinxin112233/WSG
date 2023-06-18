##Dependencies
#GATK v.4.1.3.0; VCFtools v.0.1.16; PLINK v.1.9

samtools index 01_sort.mdup.bam
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" MarkDuplicates -I 01_sort.bam -O 01_sort.mdup.bam -CREATE_INDEX=true -REMOVE_DUPLICATES=true -M 01.dups.txt
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" HaplotypeCaller -R genome.fasta -ERC GVCF -I 01_sort.mdup.bam -O 01.gvcf
samtools index 02_sort.mdup.bam
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" MarkDuplicates -I 02_sort.bam -O 02_sort.mdup.bam -CREATE_INDEX=true -REMOVE_DUPLICATES=true -M 02.dups.txt
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" HaplotypeCaller -R genome.fasta -ERC GVCF -I 02_sort.mdup.bam -O 02.gvcf
samtools index 03_sort.mdup.bam
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" MarkDuplicates -I 03_sort.bam -O 03_sort.mdup.bam -CREATE_INDEX=true -REMOVE_DUPLICATES=true -M 03.dups.txt
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" HaplotypeCaller -R genome.fasta -ERC GVCF -I 03_sort.mdup.bam -O 03.gvcf
...

gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" CombineGVCFs -R genome.fasta --variant 01.gvcf --variant 02.gvcf --variant 03.gvcf -O all.gvcf
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" GenotypeGVCFs -R genome.fasta --variant all.gvcf -O all.vcf
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" SelectVariants -R genome.fasta -V all.vcf --select-type SNP -O all.snp.vcf
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" VariantFiltration -R genome.fasta -V all.snp.vcf --filter-expression "QD < 2.0 || MQ < 40.0 || FS > 60.0 || SOR > 3.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filter-name 'Filter' -O all.snp.filter.vcf
gatk --java-options "-Xmx4g -Djava.io.tmpdir=./tmp" SelectVariants -R genome.fasta -V all.snp.filter.vcf --exclude-filtered -O all.snp.pass.vcf
vcftools --vcf all.snp.pass.vcf --maf 0.05 --max-missing 0.9 --recode --recode-INFO-all --out all.SNP.filt
plink --vcf all.SNP.filt.recode.vcf --geno 0.1 --maf 0.01 --out all.missing_maf --recode vcf-iid --allow-extra-chr --set-missing-var-ids @:# --keep-allele-order
plink --vcf all.missing_maf.vcf --indep-pairwise 50 10 0.2 --out tmp.ld --allow-extra-chr --set-missing-var-ids @:#
plink --vcf all.missing_maf.vcf --make-bed --extract tmp.ld.prune.in --out all.LDfilter --recode vcf-iid --keep-allele-order --allow-extra-chr --set-missing-var-ids @:#

##Reference
#McKenna, A. et al. The Genome Analysis Toolkit: a MapReduce framework for analyzing nextgeneration DNA sequencing data. Genome Res. 20,1297–1303 (2010).
#Danecek, P. et al. The variant call format and VCFtools. Bioinformatics 27, 2156–2158 (2011).
#Purcell, S. et al. PLINK: a tool set for whole-genome association and population-based linkage analyses. Am. J. Hum. Genet. 81, 559–575 (2007).

