all_data_C1=read.table(file="Caspii_1_phyto_fall.upgrade.txt",header=TRUE)
top_C1=subset(all_data_C1,all_data_C1$Topo_Caspii1_17cm == 2)
bot_C1=subset(all_data_C1,all_data_C1$Topo_Caspii1_14cm == 1)
all_data_C2=read.table(file="Caspii_2_topo.upgrade.txt",header=TRUE)
top_C2=subset(all_data_C2,all_data_C2$Topo_Caspii2_7cm == 2)
bot_C2=subset(all_data_C2,all_data_C2$Topo_Caspii_6cm == 1)

data_C1 = subset(all_data_C1,select = c("EC_0_5", "EC_5_10", "EC_10_20", "EC_20_30", "EC_30_50", "EC_50_70", "EC_70_100","Golaya_zemlya"))
data_C2 = subset(all_data_C2,select = c("EC_0_5", "EC_5_10", "EC_10_20", "EC_20_30", "EC_30_50", "EC_50_70", "EC_70_100","Goloya_zem"))

colnames(data_C1) = c("EC_0_5", "EC_5_10", "EC_10_20", "EC_20_30", "EC_30_50", "EC_50_70", "EC_70_100","GolZem") 
colnames(data_C2) = c("EC_0_5", "EC_5_10", "EC_10_20", "EC_20_30", "EC_30_50", "EC_50_70", "EC_70_100","GolZem") 


data_C1$site = "C1"
data_C2$site = "C2"

data = rbind(data_C1,data_C2)
depth = colnames(data)[1:7]
pv_vect = vector()
rho_vect = vector()
n_vect = vector()
for (i in 1:7) {
	data1=subset(data,data[,i] != "NA" & data$GolZem != "NA")
	numb = nrow(data1)
	n_vect = c(n_vect,numb)
	 sp = cor.test(data1[,i],data1$GolZem,method=("spearman"))
 	pv=sp$p.value
 	pv_vect = c(pv_vect,pv)
 	rho=sp$estimate
 	rho_vect = c(rho_vect,rho)
 }
res=data.frame(depth,pv_vect,rho_vect,n_vect)
print(res,row.names=FALSE)