#!/usr/bin/env Rscript
# parse parameter ---------------------------------------------------------
library(argparser, quietly=TRUE)
# Create a parser
p <- arg_parser("draw sturcture figure for admixture result")

# Add command line arguments
p <- add_argument(p, "dir", help="input: Q matirx dir", type="character")
p <- add_argument(p, "sample", help="input: samplefile, ie  .nosex", type="character")
p <- add_argument(p, "sample_order", help="input: sample order file, define order in output figure ", type="character")
p <- add_argument(p, "output", help="output prefix", type="character")

# Parse the command line arguments
argv <- parse_args(p)

dir <- argv$dir
samp <- argv$sample
ord  <- argv$sample_order
outpre <- argv$output

library(pophelper)
library(ggplot2)

#Qfiles1 <- as.character(read.table("Q_list",header = F)[,1])

Qfiles <- list.files( dir, pattern = "Q", full.names = T )
qlist <- readQ(Qfiles,  indlabfromfile=F)


label <- read.table( samp, header = F)
ordinfo <- read.table(ord, header = F, stringsAsFactors=F )

for( i in 1:length(qlist) ){
    rownames(qlist[[i]]) <- label$V1
    qlist[[i]] <- qlist[[i]][as.character(ordinfo[,1]),]
}
clist <- list(
 "shiny"=c("#1D72F5","#DF0101","#77CE61","#FF9326","#A945FF","#0089B2","#FDF060","#FFA6B2","#BFF217","#60D5FD","#CC1577","#F2B950","#7FB21D","#EC496F","#326397","#B26314","#027368","#A4A4A4","#610B5E"),
 "strong"=c("#11A4C8","#63C2C5","#1D4F9F","#0C516D","#2A2771","#396D35","#80C342","#725DA8","#B62025","#ED2224","#ED1943","#ED3995","#7E277C","#F7EC16","#F8941E","#8C2A1C","#808080"),
 "oceanfive"=c("#00A0B0", "#6A4A3C","#CC333F", "#EB6841", "#EDC951"),
 "keeled"=c("#48B098", "#91CB62","#FFEE3B", "#FB9013", "#FF3C28"),
 "vintage"=c("#400F13", "#027368","#A3BF3F", "#F2B950", "#D93A2B"),
 "muted"=c("#46BDDD","#82DDCE","#F5F06A","#F5CC6A","#F57E6A"),
 "teal"=c("#CFF09E","#A8DBA8","#79BD9A","#3B8686","#0B486B"),
 "merry"=c("#5BC0EB","#FDE74C","#9BC53D","#E55934","#FA7921"),
 "funky"=c("#A6CEE3", "#3F8EAA","#79C360", "#E52829","#FDB762","#ED8F47","#9471B4"),
 "retro"=c("#01948E","#A9C4E2","#E23560","#01A7B3","#FDA963","#323665","#EC687D"),
 "cb_paired"=c("#A6CEE3","#1F78B4","#B2DF8A","#33A02C","#FB9A99","#E31A1C","#FDBF6F","#FF7F00","#CAB2D6","#6A3D9A","#FFFF99","#B15928"),
 "cb_set3"=c("#8DD3C7","#FFFFB3","#BEBADA","#FB8072","#80B1D3","#FDB462","#B3DE69","#FCCDE5","#D9D9D9","#BC80BD","#CCEBC5","#FFED6F"),
 "morris"=c("#4D94CC","#34648A","#8B658A","#9ACD32","#CC95CC","#9ACD32","#8B3A39","#CD6601","#CC5C5B","#8A4500"),
 "wong"=c("#000000","#E69F00","#56B4E9","#009E73","#F0E442","#006699","#D55E00","#CC79A7"),
 "Kjg"=c("#E69F00","#56B4E9","#E31A1C","#8214A0","#33A02C","#0000CD","#000000"),
 "krzywinski"=c("#006E82","#8214A0","#005AC8","#00A0FA","#FA78FA","#14D2DC","#AA0A3C","#FA7850","#0AB45A","#F0F032","#A0FA82","#FAE6BE"),
 "WY"=c("#FFA20A","#007FB4","#A6CEE2","#FF7F5F","#00B484","#14D2DC","#AA0A3C","#FA7850","#0AB45A","#F0F032"))


p1_sort  <- plotQ(sortQ(qlist)[1:length(qlist)], 
      sortind = "all",  ## ind排序 
      imgoutput = "join",  ## 一张图还是多张
      returnplot=T,  
      exportplot=F,
	  clustercol=clist$WY,
      useindlab = T ,    ## 显示ind名称
      sharedindlab= F ,   ## ind出现一次
      showindlab=T  )

ggsave(filename = paste(outpre, "sorted.pdf",sep=".") , 
       p1_sort$plot[[1]],  
       width = 20,
       height = 4  
       )


p1_order  <- plotQ(sortQ(qlist)[1:length(qlist)], 
                  sortind = NA,  ## ind排序 
                  imgoutput = "join",  ## 一张图还是多张
                  returnplot=T,  
                  exportplot=F,
				  clustercol=clist$WY,
                  useindlab = T ,    ## 显示ind名称
                  sharedindlab= T ,   ## ind出现一次
                  showindlab=T  )

ggsave(filename = paste(outpre, "ordered.pdf",sep=".") , 
       p1_order$plot[[1]],  
       width = 3,
       height = 4  
)




