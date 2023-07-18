
library("ggplot2")
library("scales")

setwd("E:/博士/博士课题/巨柏/数据分析/重测序数据/Ne")

a = read.table("Cudu_two-epoch_fold.final.summary", header = T)
b = read.table("Cugi_two-epoch_fold.final.summary", header = T)



ggplot() +
        geom_line(aes(x=a$year, y=a$Ne_median), color="#FFA20A", alpha=0.8, size=1.5) +
        geom_line(aes(x=a$year, y=a$Ne_2.5), color="#FFA20A",  alpha=0.68, size=0.75) +
        geom_line(aes(x=a$year, y=a$Ne_97.5), color="#FFA20A", alpha=0.68, size=0.75) +
        
        geom_line(aes(x=b$year, y=b$Ne_median), color="#007FB4", alpha=0.8, size=1.5) +
        geom_line(aes(x=b$year, y=b$Ne_2.5), color="#007FB4", alpha=0.68, size=0.75) +
        geom_line(aes(x=b$year, y=b$Ne_97.5), color="#007FB4", alpha=0.68, size=0.75) +
 
        scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                      labels = trans_format("log10", math_format(10^.x))) +
        theme(axis.title.x=element_text(size=20),
              axis.title.y=element_text(size=20),
              axis.text.x = element_text(size = 20),
              axis.text.y = element_text(size = 20),
              panel.background=element_rect(fill='transparent', color='black',size=1.5),
              panel.grid=element_blank(),
              legend.position = "none")

p1
p1+ annotation_logticks()














p1=ggplot() +
geom_line(aes(x=a$year, y=a$Ne_median), color="#5B9BD5", alpha=0.68, size=2) +
geom_line(aes(x=a$year, y=a$Ne_2.5), color="#5B9BD5", alpha=0.68, size=0.75) +
geom_line(aes(x=a$year, y=a$Ne_97.5), color="#5B9BD5", alpha=0.68, size=0.75) +
geom_line(aes(x=b$year, y=b$Ne_median), color="#ED7D31", alpha=0.68, size=2)+
geom_line(aes(x=b$year, y=b$Ne_2.5), color="#ED7D31", alpha=0.68, size=0.75)+
geom_line(aes(x=b$year, y=b$Ne_97.5), color="#ED7D31", alpha=0.68, size=0.75)+
scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
              labels = trans_format("log10", math_format(10^.x))) +
theme(axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        panel.background=element_rect(fill='transparent', color='black',size=1.5),
        panel.grid=element_blank(),
        legend.position = "none")

p1+ annotation_logticks()