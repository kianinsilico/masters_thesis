sessionInfo()
rm(list=ls())

getwd()

library(Seurat)
library(SeuratData)
library(BPCells)
library(dplyr)
options(Seurat.object.assay.version = "v5")

SampleSheet <- read.table("./data/filbin/GSE102130_K27Mproject.RSEM.vh20170621.txt.gz",sep="\t",header=T)
SampleSheet
dim(SampleSheet)
str(SampleSheet)
summary(SampleSheet)
