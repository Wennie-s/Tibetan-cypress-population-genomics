library(ggplot2)
library(RColorBrewer)
library(qqman)
library(ggpubr)
setwd("E:/博士/博士课题/巨柏/数据分析/重测序数据/genetic_load/0_4_fold")
data <- read.table("0fold_4fold_ratio.txt", header = T)
head(data)
#plot 0fold/4fold_PI
ggplot(data=data, aes(x=Species,xend=Species, y=ystart, yend=ratio)) + 
  geom_segment(aes(color=Species),
               size=20,
               show.legend = FALSE)+
  scale_y_continuous(limits = c(0.45, 0.65)) +
  theme_bw() +
  theme_classic()

data <- read.table("0fold.txt", header = T)
head(data)
ggplot(data=data, aes(x=Species,xend=Species, y=ystart, yend=X0fold)) + 
  geom_segment(aes(color=Species),
               size=20,
               show.legend = FALSE)+
  scale_y_continuous(limits = c(0.002, 0.006)) +
  theme_bw() +
  theme_classic()

data <- read.table("4_fold.txt", header = T)
head(data)
ggplot(data=data, aes(x=Species,xend=Species, y=ystart, yend=X4fold)) + 
  geom_segment(aes(color=Species),
               size=20,
               show.legend = FALSE)+
  scale_y_continuous(limits = c(0.002, 0.01)) +
  theme_bw() +
  theme_classic()

#plot 0fold/4fold_Het
data <- read.table("0fold_4fold_het.txt", header = T)
head(data)
compaired <- list(c("Cudu","Cugi"),c("CuduN","Cugi"),c("CuduS","Cugi"))
ggplot(data, aes(x=group, y=X0fold.4fold)) + 
  geom_boxplot(aes(fill = group), varwidth = TRUE, outlier.shape=NA) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  stat_compare_means(comparisons = compaired,  method = "t.test", label  = "p.signif", ref.group = "Cugi")+
  ylim(0.4, 0.8) +
  theme_classic()

data <- read.table("0fold_4fold_het.txt", header = T)
head(data)
compaired <- list(c("Cudu","Cugi"),c("CuduN","Cugi"),c("CuduS","Cugi"))
ggplot(data, aes(x=group, y=X0fold_Het)) + 
  geom_boxplot(aes(fill = group), varwidth = TRUE,outlier.shape=NA) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  stat_compare_means(comparisons = compaired,  method = "t.test", label  = "p.signif", ref.group = "Cugi" )+
  ylim(0.0, 0.01) +
  theme_classic()

compaired <- list(c("Cudu","Cugi"),c("CuduN","Cugi"),c("CuduS","Cugi"))
ggplot(data, aes(x=group, y=X4fold_Het)) + 
  geom_boxplot(aes(fill = group), varwidth = TRUE,outlier.shape=NA) +
  scale_fill_manual(values = c(brewer.pal(7, "Set2")[c(1,2,4,5)])) + 
  stat_compare_means(comparisons = compaired,  method = "t.test",label  = "p.signif", ref.group = "Cugi"  )+
  ylim(0.0, 0.015) +
  theme_classic()
