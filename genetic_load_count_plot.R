library(ggplot2)
library(ggpubr)
library(RColorBrewer)
library(qqman)
setwd("E:/博士/博士课题/巨柏/数据分析/重测序数据/genetic_load/delterious_load")
#plot LoF
data <- read.table("count.txt", header = T)
compaired = list(c("Cugi,Cudu"),c("Cugi,CuduN"),c("Cugi,CuduS"))
head(data)
class(data[,4])
ggplot(data, aes(x=catelory, y=LoF)) + 
  geom_boxplot(aes(fill = Species),varwidth = TRUE, outlier.shape = NA) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  theme_bw() +
  theme_light()
d1 = subset(data, catelory=="Hom_ratio")
d2 = subset(data, catelory == "Het_ratio")
compare_means(LoF~Species, data=d1, method = "t.test")
compare_means(LoF~Species, data=d2, method = "t.test")
#plot delterious
data <- read.table("count.txt", header = T)
compaired = list(c("Cugi,Cudu"),c("Cugi,CuduN"),c("Cugi,CuduS"))
head(data)
class(data[,4])
ggplot(data, aes(x=catelory, y=Deleterious)) + 
  geom_boxplot(aes(fill = Species),varwidth = TRUE, outlier.shape = NA) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  theme_bw() +
  theme_light()
d1 = subset(data, catelory=="Hom_ratio")
d2 = subset(data, catelory == "Het_ratio")
compare_means(Deleterious~Species, data=d1, method = "t.test")
compare_means(Deleterious~Species, data=d2, method = "t.test")

#plot tolerant
ggplot(data, aes(x=catelory, y=Tolerate)) + 
  geom_boxplot(aes(fill = Species),varwidth = TRUE, outlier.shape = NA) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  theme_bw() +
  theme_light()
d1 = subset(data, catelory=="Hom_ratio")
d2 = subset(data, catelory == "Het_ratio")
compare_means(Tolerate~Species, data=d1, method = "t.test")
compare_means(Tolerate~Species, data=d2, method = "t.test")

#plot syn
ggplot(data, aes(x=catelory, y=Syn)) + 
  geom_boxplot(aes(fill = Species),varwidth = TRUE, outlier.shape = NA) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  theme_bw() +
  theme_light()
d1 = subset(data, catelory=="Hom_ratio")
d2 = subset(data, catelory == "Het_ratio")
compare_means(Tolerate~Species, data=d1, method = "t.test")
compare_means(Tolerate~Species, data=d2, method = "t.test")


#plot LoF_count_ratio
data = read.table("count_ratio.txt", header = TRUE)
head(data)
ggplot(data, aes(x= Species, y= LoF, shape = catelory, color = catelory)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(1,2))+
  facet_grid(.~catelory)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  stat_compare_means(comparisons = compaired, label = "p.signif", method = "t.test", ref.group = "Cugi", hide.ns = TRUE)+
  theme_bw()
d1 = subset(data, catelory=="Hom_ratio")
d2 = subset(data, catelory == "Het_ratio")
compare_means(LoF~Species, data=d1, method = "t.test")
compare_means(LoF~Species, data=d2, method = "t.test")

ggplot(data, aes(x= Species, y= Deleterious, shape = catelory, color = catelory)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(1,2))+
  facet_grid(.~catelory)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  stat_compare_means(comparisons = compaired, label = "p.signif", method = "t.test", ref.group = "Cugi", hide.ns = TRUE)+
  theme_bw()
d1 = subset(data, catelory=="Hom_ratio")
d2 = subset(data, catelory == "Het_ratio")
compare_means(Deleterious~Species, data=d1, method = "t.test")
compare_means(Deleterious~Species, data=d2, method = "t.test")

ggplot(data, aes(x= Species, y= Tolerate, shape = catelory, color = catelory)) +
  geom_point(size = 2)+
  scale_shape_manual(values = c(1,2))+
  facet_grid(.~catelory)+
  stat_summary(fun = mean, geom = "point", shape = "-", color= "black", size = 10) +
  stat_compare_means(comparisons = compaired, label = "p.signif", method = "t.test", ref.group = "Cugi", hide.ns = TRUE)+
  theme_bw()
d1 = subset(data, catelory=="Hom_ratio")
d2 = subset(data, catelory == "Het_ratio")
compare_means(Tolerate~Species, data=d1, method = "t.test")
compare_means(Tolerate~Species, data=d2, method = "t.test")


