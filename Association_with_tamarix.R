C2=read.table(file="Caspii2_FALL.top_bottom_plots.SpeciesYesNo2_TamarixSize.GOOD_DATA.txt",header=TRUE)
cols = colnames(C2)
sp_c2 = data.frame()
for (i in 10:20) {
  yes_tam=sum(C2[,i]== "yes" & C2[,21]== "yes")
  yes_notam=sum(C2[,i]== "yes" & C2[,21]== "no")
  no_tam=sum(C2[,i]== "no" & C2[,21]== "yes")
  no_notam=sum(C2[,i]== "no" & C2[,21]== "no")
 sp = cols[i]
   sp_c2[i-9,1] = sp
  sp_c2[i-9,2] = yes_tam
  sp_c2[i-9,3] = yes_notam
  sp_c2[i-9,4] = no_tam
  sp_c2[i-9,5] = no_notam
}
colnames(sp_c2) = c("species","yes_c2_tam","yes_c2_wotam","no_c2_tam","no_c2_wotam")
sp_c1c2 = merge(x=sp_c1,y=sp_c2,by="species",all.x = TRUE,all.y=TRUE)

write.table(sp_c1c2,file="C1C2.SPECIES.YES_NO_plusminusBigTamarix.txt",quote=FALSE,row.names=FALSE)

sp_c1c2 = read.table(file="C1C2.SPECIES.YES_NO_plusminusBigTamarix.txt ",header=TRUE)

fisher = function(x){
 str = sp_c1c2[x,]
mat=matrix(c(str[1,6],str[1,7],str[1,8],str[1,9]),nrow=2,ncol=2)
 f=fisher.test(mat,alternative="less")$p.value
 return(f)
}
vect = seq(1,nrow(sp_c1c2),by=1)
fish_res=sapply(vect ,fisher)
sp_c1c2 = cbind(sp_c1c2 ,fish_res)
sp_c1c2$C1=ifelse(sp_c1c2$yes_top_c1>0 | sp_c1c2$no_top_c1>0 | sp_c1c2$yes_bot_c1>0 | sp_c1c2$no_bot_c1>0,"yes","no")
c2_yes = subset(sp_c1c2,sp_c1c2$yes_c2_tam>0 | sp_c1c2$ yes_c2_wotam>0)
write.table(c2_yes,file="C2yes_BigTamarixFisher.txt",dec=","quote=FALSE,row.names=FALSE)
