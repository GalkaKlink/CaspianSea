library("tidyr")
data=read.table(file="Dagestan_big_plus_small_plots.VERY_FINAL.txt",header=TRUE)
data$Species1 = data$Species
data<-separate(data = data, col = Species1, into = c("Genus","sp"), sep = "_")
data = data[,c(1,10,2,3,4,5,6)]
casp1 = subset(data,data$Caspii_1 == "yes" & data$Caspii_2 == "no")
res = numeric()
for (i in 1:(nrow(casp1)-1)) {
 for (j in (i+1):nrow(casp1)) {
 sub = casp1[c(i,j),]
 spn = length(unique(sub$Species))
 gn = length(unique(sub$Genus))
 fn = length(unique(sub$Family))
 on = length(unique(sub$Order))
 cn = length(unique(sub$Clade))
 vect = c(spn,gn,fn,on,cn)
 diff = sum(vect==2)
 res = c(res,diff)
  }
}
TDI = mean(res)
