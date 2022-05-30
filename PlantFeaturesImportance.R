features=read.table(file="Caspii12.NEW.OneTamarix.txt",header=TRUE)
c1c2_fall_spring_short = sp_c1c2_fall_spring[,c(1,10,11,15,16,12,14)]
vect = c("Tamarix","no","yes","no","yes",2,"C3")
c1c2_fall_spring_short = rbind(c1c2_fall_spring_short,vect)
c1c2_fall_spring_short[28,6] = 0 #to exclude P.gigantea from autumn statistics
feat_sp = merge(x= c1c2_fall_spring_short,y= features,by.x="species",by.y= "Species_at_the_tree",all.x=FALSE,all.y=TRUE)

feat_sp$root_nomore_100cm = ifelse(feat_sp$Roots_max_cm <= 100,"yes","no")
feat_sp$grass=ifelse(feat_sp$Group==1,"yes","no")
feat_sp$efemer = ifelse(feat_sp$Life_cycle.y == 0,"yes","no")
feat_sp$annyal = ifelse(feat_sp$Life_cycle.y == 1,"yes","no")
feat_sp$perennial = ifelse(feat_sp$Life_cycle.y == 2,"yes","no")
feat_sp$C4=ifelse(feat_sp$C3C4=="C4","yes","no")

C1=subset(feat_sp,feat_sp$Caspii1_spring =="yes")
C2 =subset(feat_sp, feat_sp$Caspii1_spring=="no")
fish_test = vector()
C1_yes_vect = vector()
C2_yes_vect = vector()
for (i in c(14:30)) {
C1_yes = subset(C1,C1[,i] == "yes")
C1_no = subset(C1,C1[,i] == "no")
C2_yes = subset(C2,C2[,i] == "yes")
C2_no = subset(C2,C2[,i] == "no")
matr=matrix(c(nrow(C1_yes),nrow(C1_no),nrow(C2_yes),nrow(C2_no)),2)
ft=fisher.test(matr)
pv = ft$p.value
fish_test = c(fish_test,pv)
C1_ratio = nrow(C1_yes)/(nrow(C1_yes)+nrow(C1_no))
C2_ratio = nrow(C2_yes)/(nrow(C2_yes)+nrow(C2_no))
C1_yes_vect = c(C1_yes_vect, C1_ratio)
C2_yes_vect = c(C2_yes_vect,C2_ratio)
}
names = colnames(feat_sp)
traits = names[c(14:30)]
results = cbind(traits,fish_test,C1_yes_vect,C2_yes_vect)
results=as.data.frame(results)
print(results,quote=FALSE,row.names=FALSE)
#AUTUMN – 9 species persist in C1, è 7 species abcent in Ñ1
feat_sp1 = subset(feat_sp,feat_sp$Life_cycle.x > 0)
C1=subset(feat_sp1,feat_sp1$Caspii1_fall =="yes")
C2 =subset(feat_sp1, feat_sp1$Caspii1_fall=="no")
fish_test = vector()
C1_yes_vect = vector()
C2_yes_vect = vector()
for (i in c(14:30)) {
C1_yes = subset(C1,C1[,i] == "yes")
C1_no = subset(C1,C1[,i] == "no")
C2_yes = subset(C2,C2[,i] == "yes")
C2_no = subset(C2,C2[,i] == "no")
matr=matrix(c(nrow(C1_yes),nrow(C1_no),nrow(C2_yes),nrow(C2_no)),2)
ft=fisher.test(matr)
pv = ft$p.value
fish_test = c(fish_test,pv)
C1_ratio = nrow(C1_yes)/(nrow(C1_yes)+nrow(C1_no))
C2_ratio = nrow(C2_yes)/(nrow(C2_yes)+nrow(C2_no))
C1_yes_vect = c(C1_yes_vect, C1_ratio)
C2_yes_vect = c(C2_yes_vect,C2_ratio)
}
names = colnames(feat_sp)
traits = names[c(14:30)]
results_fall = cbind(traits,fish_test,C1_yes_vect,C2_yes_vect)
results_fall=as.data.frame(results_fall)
print(results_fall,quote=FALSE,row.names=FALSE)
