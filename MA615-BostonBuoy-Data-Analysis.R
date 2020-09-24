library(ggplot2)
library(readr)
library(rstanarm)
library(readxl)
library(tidyverse)

##reading data
setwd("~/Desktop/615/assignment")
a <- list.files("data")
dir <- paste("./data/",a,sep="")
n <- length(dir)
merge.data1 <- read.table(file=dir[1],header=TRUE,fill=TRUE)
for(i in 2:8){
  new.data1 <- read.table(file=dir[i],header=TRUE,fill=TRUE)
  merge.data1 <- merge(merge.data1,new.data1,all=T,sort = T)
}
merge.data1[is.na(merge.data1)] <- 0
merge.data1$PRES <- merge.data1$PRES+merge.data1$BAR
merge.data1$WDIR <- merge.data1$WDIR+merge.data1$WD
merge.data1 <- merge.data1[,-18]
merge.data1 <- merge.data1[,-17]
merge.data1 <- merge.data1[,-16]

merge.data2 <- read.table(file=dir[9],header=TRUE,fill=TRUE)
for(j in 10:16 ){
  new.data2 <- read.table(file=dir[j],header=TRUE,fill=TRUE)
  merge.data2 <- merge(merge.data2,new.data2,all=T,sort = T)
}
merge.data2[is.na(merge.data2)] <- 0
merge.data2 <- merge.data2[,-5]

merge.data3 <- read.table(file=dir[17],header=TRUE,fill=TRUE)
for(k in 18:20 ){
  new.data3 <- read.table(file=dir[k],header=TRUE,fill=TRUE)
  merge.data3 <- merge(merge.data3,new.data3,all=T,sort = T)
}
merge.data3[is.na(merge.data3)] <- 0
merge.data3 <- merge.data3[,-5]

merge.data12 <- merge(merge.data1,merge.data2,all=T,sort = T)
dt <- merge(merge.data12,merge.data3,all=T,sort=T)

##unite the time
dt$MM <- formatC(dt$MM,flag = '0',width = 2)
dt$DD <- formatC(dt$DD,flag = '0',width = 2)
dt$hh <- formatC(dt$hh,flag = '0',width = 2)
dt_1 <- dt%>%unite('time(YYYYMMDDhh)','YY','MM','DD','hh',sep='')
dt_1$time<- as.numeric(dt_1$time)