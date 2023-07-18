library(ggplot2)

setwd("E:/博士/博士课题/巨柏/数据分析/重测序数据/PCA")
data <- read.csv("pc.csv", header = T)
head(data)
x_per <- round(summary(data)$importance[2, 1]*100, 1)
x_per
p <- ggplot(data, aes(PC1, PC2, color = POP)) + geom_point(size = 3)+ 
  geom_hline(yintercept = 0,linetype="dashed") +
  geom_vline(xintercept = 0,linetype="dashed") +
  theme_bw() +
  xlab("PC1 (17.66%)") + ylab("PC (8.47%)") +
  theme(legend.position = c(0.85,0.85))
p
