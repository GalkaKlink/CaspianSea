all_data_C1=read.table(file="Caspii_1_phyto.txt",header=TRUE)
top_C1=subset(all_data_C1,all_data_C1$Topo_Caspii1_17cm == 2)
bot_C1=subset(all_data_C1,all_data_C1$Topo_Caspii1_14cm == 1)
all_data_C2=read.table(file="Caspii_2_topo.txt",header=TRUE)
top_C2=subset(all_data_C2,all_data_C2$Topo_Caspii2_7cm == 2)
bot_C2=subset(all_data_C2,all_data_C2$Topo_Caspii_6cm == 1)
top_C1_gz = top_C1$Golaya_zemlya   #bare ground in microhighs of old site
top_C2_gz = top_C2$Goloya_zem   #bare ground in microhighs of young site
top_C1_gz=subset(top_C1_gz,top_C1_gz != "NA")
top_C2_gz=subset(top_C2_gz,top_C2_gz != "NA")

bot_C1_gz = bot_C1$Golaya_zemlya   #bare ground in microlows of old site
bot_C2_gz = bot_C2$Goloya_zem   #bare ground in microlows of young site
bot_C1_gz=subset(bot_C1_gz,bot_C1_gz != "NA")
bot_C2_gz=subset(bot_C2_gz,bot_C2_gz != "NA")

mw1=wilcox.test(top_C1_gz,top_C2_gz)
mw1$p.value
mw2=wilcox.test(bot_C1_gz,bot_C2_gz)
mw2$p.value
mw3=wilcox.test(top_C1_gz,bot_C1_gz)
mw3$p.value
mw4=wilcox.test(top_C2_gz,bot_C2_gz)
mw4$p.value
