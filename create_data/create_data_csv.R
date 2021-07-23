#devtools::install_github("hrbrmstr/nominatim")
library(rio)
library(tidyverse)
library(nominatim) #for open street maps coordinates

exec_dir <- dirname(rstudioapi::getSourceEditorContext()$path) #the dir this script is in
setwd(exec_dir)

source("get_future_workshops.R")
source("save_post_sharepoint.R")
source("save_viable_data.R")

setwd('..')

tokens <- read.delim("tokens.txt", header=F)
token <- str_split(tokens$V1, pattern=" ")[[1]][2]

setwd(exec_dir)

ds_xlsx <- import("/Users/liekedeboer/Netherlands eScience Center/Instructors - Documents/General/Digital Skills Workshops 2021.xlsx")
ds_xlsx<-ds_xlsx[ds_xlsx$startdate >= Sys.time(), ] # only read workshop dates after today

dat_struct <- get_future_workshops(ds_xlsx)
save_viable_data(dat_struct) #only saves a data file in its folder if the slug is longer than 10 characters
save_post_sharepoint(slug, instructors, helpers, coordinator = c("Mateusz Kuzak", "Lieke de Boer"))


