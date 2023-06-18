R
data<-matrix(c(X,Y,Z,F),nr=2)
result<-fisher.test(data)
pvalue<-result$p.value
pvalue

##Note
#X and Y represent the number of NB-ARC genes in 'Camarosa' and one wild octoploid species (F. chiloensis or F. virginiana)
#Z and F represent the total protein genes in their genomes, respectively.

##Reference
#Wu, D. et al. Genomic insights into the evolution of Echinochloa species as weed and orphan crop. Nat. Commun. 13, 689 (2022).
