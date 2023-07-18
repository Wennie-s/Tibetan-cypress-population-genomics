library("ggplot2")
library("scales")

setwd("E:/博士/博士课题/巨柏/数据分析/重测序数据/Ne/gone")

a = read.table("Output_Ne_Cudu.combined.4Dsite.txt", header = T)
b = read.table("Output_Ne_Cugi.combined.4Dsite.txt", header = T)



ggplot() +
  geom_line(aes(x=a$Generation, y=a$Geometric_mean), color="#FF7F5F", alpha=0.8, size=0.8) +
  geom_line(aes(x=b$Generation, y=b$Geometric_mean), color="#007FB4", alpha=0.8, size=0.8) +

  theme(axis.title.x=element_text(size=10),
        axis.title.y=element_text(size=10),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        panel.background=element_rect(fill='transparent', color='black',size=1.5),
        panel.grid=element_blank(),
        legend.position = "none")
