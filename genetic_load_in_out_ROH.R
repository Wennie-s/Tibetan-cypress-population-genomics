library(ggpubr)
library(ggplot2)
setwd("E:/博士/博士课题/巨柏/数据分析/重测序数据/genetic_load/delterious_load")
#plot LoF_ratio_roh Hom
data = read.table("roh_hom_ratio.txt", header = TRUE)
head(data)
ggplot(data, aes(x= roh, y= LoF, shape = roh, color = species)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(1,2))+
  facet_grid(.~species)+
  ylim(0.01, 0.03)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  theme_bw()
#T-test for each species
Cudu <-subset(data, data$species == "Cudu")
Cugi <-subset(data, data$species == "Cugi")
CuduN <-subset(data, data$species == "CuduN")
CuduS <-subset(data, data$species == "CuduS")
compare_means(LoF~roh, data=Cudu, method = "t.test")
compare_means(LoF~roh, data=Cugi, method = "t.test")
compare_means(LoF~roh, data=CuduN, method = "t.test")
compare_means(LoF~roh, data=CuduS, method = "t.test")

#plot delterious_ratio_roh Hom
ggplot(data, aes(x= roh, y= Deletrious, shape = roh, color = species)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(1,2))+
  facet_grid(.~species)+
  ylim(0.05, 0.16)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  theme_bw()
#T-test for each species
Cudu <-subset(data, data$species == "Cudu")
Cugi <-subset(data, data$species == "Cugi")
CuduN <-subset(data, data$species == "CuduN")
CuduS <-subset(data, data$species == "CuduS")
compare_means(Deletrious~roh, data=Cudu, method = "t.test")
compare_means(Deletrious~roh, data=Cugi, method = "t.test")
compare_means(Deletrious~roh, data=CuduN, method = "t.test")
compare_means(Deletrious~roh, data=CuduS, method = "t.test")

#plot LoF_ratio_roh Het
data = read.table("roh_het_ratio.txt", header = TRUE)
head(data)
ggplot(data, aes(x= roh, y= LoF, shape = roh, color = species)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(0,5))+
  facet_grid(.~species)+
  ylim(0.05, 0.14)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  theme_bw()
#T-test for each species
Cudu <-subset(data, data$species == "Cudu")
Cugi <-subset(data, data$species == "Cugi")
CuduN <-subset(data, data$species == "CuduN")
CuduS <-subset(data, data$species == "CuduS")
compare_means(LoF~roh, data=Cudu, method = "t.test")
compare_means(LoF~roh, data=Cugi, method = "t.test")
compare_means(LoF~roh, data=CuduN, method = "t.test")
compare_means(LoF~roh, data=CuduS, method = "t.test")

#plot delterious_ratio_roh Het
ggplot(data, aes(x= roh, y= Deleterious, shape = roh, color = species)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(0,5))+
  facet_grid(.~species)+
  ylim(0.2, 0.55)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  theme_bw()
#T-test for each species
Cudu <-subset(data, data$species == "Cudu")
Cugi <-subset(data, data$species == "Cugi")
CuduN <-subset(data, data$species == "CuduN")
CuduS <-subset(data, data$species == "CuduS")
compare_means(Deleterious~roh, data=Cudu, method = "t.test")
compare_means(Deleterious~roh, data=Cugi, method = "t.test")
compare_means(Deleterious~roh, data=CuduN, method = "t.test")
compare_means(Deleterious~roh, data=CuduS, method = "t.test")

#plot delterious_total_ratio_roh 
data = read.table("roh_total_ratio.txt", header = TRUE)
head(data)
ggplot(data, aes(x= roh, y= LoF, shape = roh, color = species)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(0,5))+
  facet_grid(.~species)+
  ylim(0.01, 0.10)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  theme_bw()
#T-test for each species
Cudu <-subset(data, data$species == "Cudu")
Cugi <-subset(data, data$species == "Cugi")
CuduN <-subset(data, data$species == "CuduN")
CuduS <-subset(data, data$species == "CuduS")
compare_means(LoF~roh, data=Cudu, method = "t.test")
compare_means(LoF~roh, data=Cugi, method = "t.test")
compare_means(LoF~roh, data=CuduN, method = "t.test")
compare_means(LoF~roh, data=CuduS, method = "t.test")

data = read.table("roh_total_ratio.txt", header = TRUE)
head(data)
ggplot(data, aes(x= roh, y= Deletrious, shape = roh, color = species)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(0,5))+
  facet_grid(.~species)+
  ylim(0.1, 0.4)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  theme_bw()
#T-test for each species
Cudu <-subset(data, data$species == "Cudu")
Cugi <-subset(data, data$species == "Cugi")
CuduN <-subset(data, data$species == "CuduN")
CuduS <-subset(data, data$species == "CuduS")
compare_means(LoF~roh, data=Cudu, method = "t.test")
compare_means(LoF~roh, data=Cugi, method = "t.test")
compare_means(LoF~roh, data=CuduN, method = "t.test")
compare_means(LoF~roh, data=CuduS, method = "t.test")

