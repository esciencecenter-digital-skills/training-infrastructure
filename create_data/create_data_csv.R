#devtools::install_github("hrbrmstr/nominatim")
library(rio)
library(tidyverse)
library(nominatim) #for open street maps coordinates
source("create_data/get_future_workshops.R")

ds_xlsx <- import("/Users/liekedeboer/Netherlands eScience Center/Instructors - Documents/General/Digital Skills Workshops 2021.xlsx")
ds_xlsx<-ds_xlsx[ds_xlsx$startdate >= Sys.time(), ] # only read workshop dates after today

exec_dir <- dirname(rstudioapi::getSourceEditorContext()$path) #the dir this script is in
setwd(exec_dir)
setwd('..')

tokens <- read.delim("tokens.txt", header=F)
token <- str_split(tokens$V1, pattern=" ")[[1]][2]

dat_struct <- get_future_workshops(ds_xlsx)
dat_struct

viable_slugs <- data_file$slug[nchar(data_file$slug)>10] #only bother with slugs longer than 10 characters
workshop_dirs <- file.path(exec_dir, viable_slugs) # create filepath from current directory + slug
sapply(workshop_dirs, dir.create) # create those directories

data_file <- dat_struct %>% 
  select(venue, address, country, latitude, longitude,
         humandate, humantime, 
         startdate, enddate,
         instructor, helper,
         carpentry, curriculum, title, slug, flavor)

for (i in 1:length(viable_slugs)) {
  csv_info <- data_file[i,]
  filename <- paste0(exec_dir, "/", viable_slugs[i], "/data.csv")
  write_csv(csv_info, filename)
}