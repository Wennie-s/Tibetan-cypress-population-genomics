library(ggplot2)
library(RColorBrewer)
library(qqman)
library(ggpubr)
setwd("E:/博士/博士课题/巨柏/数据分析/重测序数据/genetic_load/0_4_fold")
data <- read.table("0fold_4fold_het.txt", header = T)
head(data)
#plot inbreeding coefficient
ggplot(data, aes(x=group, y=X0fold.4fold)) + 
  geom_boxplot(aes(fill = group), varwidth = TRUE) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) +
  stat_compare_means(label = "p.signif",  method = "t.test", hide.ns = TRUE,label.y = 0.5 )+
  ylim(0.5, 0.8) +
  theme_bw()

#plot roh_100kb,500kb,1000kb,Froh
data <- read.table("roh_sum.txt", header = T)
head(data)
ggplot(data, aes(x=group, y=roh_100kb)) + 
  geom_boxplot(aes(fill = group), varwidth = TRUE) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  theme_bw()
ggplot(data, aes(x=group, y=roh_500kb)) + 
  geom_boxplot(aes(fill = group), varwidth = TRUE) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  theme_bw()
ggplot(data, aes(x=group, y=roh_1000kb)) + 
  geom_boxplot(aes(fill = group), varwidth = TRUE) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  theme_bw()
ggplot(data, aes(x=group, y=Froh)) + 
  geom_boxplot(aes(fill = group), varwidth = TRUE) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  theme_bw()

#plot Regression of whole genome heterozygosity against FROH
data <- read.table("het_Froh.txt", header = T)
head(data)
reg <- lm(data$Het ~ data$Froh)
summary(reg)
ggplot(data, aes(x=Froh,y=Het))+
  geom_point(aes(fill = Group),shape = 21, colour = "black")+
  geom_smooth(method = "lm", se = FALSE, color = "lightgrey")

