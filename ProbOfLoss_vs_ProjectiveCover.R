data=read.table(file="Dagestan_big_plus_small_plots.VERY_FINAL.txt",header=TRUE)
data$C3C4_1=ifelse(data$C3C4=="C4","C4","C3")
data_sub=data[,c(1,5,6,7,8,10)]
colnames(data_sub) = c("species","Caspii1_spring","Caspii2_spring","Life_cycle","group","C3C4")

C1=read.table(file="Caspii1_FALL.top_bottom_plots.SpeciesYesNo2.GOOD_DATA.txt",header=TRUE)
cols = colnames(C1)
sp_c1 = data.frame()
for (i in 10:ncol(C1)) {
	vect1 = paste(C1[,i],C1[,8],sep="_")
	vect2 = paste(C1[,i],C1[,9],sep="_")
	yes_top =sum(vect1== "yes_2")
	no_top =sum(vect1== "no_2")
	yes_bot =sum(vect2== "yes_1")
	no_bot =sum(vect1== "no_1")
	sp = cols[i]
	sp_c1[i-9,1] = sp
	  sp_c1[i-9,2] = yes_top
 	 sp_c1[i-9,3] = no_top
  	sp_c1[i-9,4] = yes_bot
  	sp_c1[i-9,5] = no_bot
}
colnames(sp_c1) = c("species","yes_top_c1","no_top_c1"," yes_bot_c1"," no_bot_c1")


C2=read.table(file="Caspii2_FALL.top_bottom_plots.SpeciesYesNo2_TamarixSize.GOOD_DATA.txt",header=TRUE)
cols = colnames(C2)
sp_c2 = data.frame()
for (i in 10:ncol(C2)) {	 
	vect1 = paste(C2[,i],C2[,8],sep="_")
	vect2 = paste(C2[,i],C2[,9],sep="_")
	yes_top =sum(vect1== "yes_2")
	no_top =sum(vect1== "no_2")
	yes_bot =sum(vect2== "yes_1")
	no_bot =sum(vect1== "no_1")
	sp = cols[i]
	 sp_c2[i-9,1] = sp
	  sp_c2[i-9,2] = yes_top
  	sp_c2[i-9,3] = no_top
 	 sp_c2[i-9,4] = yes_bot
 	 sp_c2[i-9,5] = no_bot
}
colnames(sp_c2) = c("species","yes_top_c2","no_top_c2"," yes_bot_c2"," no_bot_c2")
sp_c1c2 = merge(x=sp_c1,y=sp_c2,by="species",all.x = TRUE,all.y=TRUE)

only_fall=sp_c1c2[!sp_c1c2$species %in% data_sub$Species,]
only_spring=data_sub[!data_sub$Species %in% sp_c1c2$species,]

sp_c1c2_fall_spring = merge(x=sp_c1c2,y= data_sub,by.x="species",by.y= "species",all.x=TRUE,all.y=TRUE)

write.table(sp_c1c2_fall_spring,file="C1C2.SPECIES.YES_NO.AutumnSpring.txt",quote=FALSE,row.names=FALSE) #вручную замен€ем в файле УNAФ на 0. —разу изменила жизненную форму P.gigantea с У2Ф на У0Ф, чтобы не рассматривать еЄ в общих тестах.

sp_c1c2_fall_spring = read.table(file="C1C2.SPECIES.YES_NO.AutumnSpring.txt",header=TRUE)

sp_c1c2_fall_spring$Caspii1_fall = ifelse((sp_c1c2_fall_spring$yes_top_c1>0 | sp_c1c2_fall_spring$yes_bot_c1>0),"yes","no")
sp_c1c2_fall_spring$Caspii2_fall = ifelse((sp_c1c2_fall_spring$yes_top_c2>0 | sp_c1c2_fall_spring$yes_bot_c2>0),"yes","no")

fall=subset(sp_c1c2_fall_spring,sp_c1c2_fall_spring$Caspii1_fall=="yes" | sp_c1c2_fall_spring$Caspii2_fall=="yes")
fall$Caspii1_fall=fall$yes_top_c1+fall$yes_bot_c1
fall$Caspii2_fall=fall$yes_top_c2+fall$yes_bot_c2
fall1=fall[,c(1,15,16,12)]
fall1[19,4] = 1  

fall2=subset(fall1,fall1$Life_cycle != 0)
c1_yes=subset(fall2,fall2$Caspii1_fall>0)
c1_no=subset(fall2,fall2$Caspii1_fall==0)

wilcox.test(c1_yes$Caspii2_fall,c1_no$Caspii2_fall)
