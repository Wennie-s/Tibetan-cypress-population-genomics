library(ggplot2)
library(ggridges)
library(RColorBrewer)

setwd("E:/博士/博士课题/巨柏/数据分析/基因组数据/wgd/kaks_caculator")
data1 <- read.csv("Cugi_Segi_Gbi.csv", header = T)
data2 <- read.csv("Cugi.csv", header = T)
data1 = na.omit(data1)
data2 = na.omit(data2)
data = rbind(data1, data2)
head(data)
data$Species = factor(data$Species, levels = c("Cugi-Segi","Cugi-Gbi","Cugi"))
p <- ggplot(data, aes(x=Ks, fill = Species))+
  geom_density()+
  geom_histogram(aes(y = ..density.., fill = Species),binwidth = 0.1,  position = "identity", alpha = 0.8, color = "white")+
  stat_density(geom = 'line',  position = 'identity', aes(color = Species))+
  theme_classic()
p

p <- ggplot(data, aes(x=Ks, fill = Species))+
  geom_histogram(aes(fill = Species), binwidth = 0.08, position = "identity", alpha = 0.6, color = "white")
p

