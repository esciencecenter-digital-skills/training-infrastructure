#devtools::install_github("hrbrmstr/nominatim")
library(rio)
library(tidyverse)
library(nominatim) #for open street maps coordinates

ds_xlsx <- import("/Users/liekedeboer/Netherlands eScience Center/Instructors - Documents/General/Digital Skills Workshops 2021.xlsx")

exec_dir <- dirname(rstudioapi::getSourceEditorContext()$path) #the dir this script is in
setwd(exec_dir)
setwd('..')

tokens <- read.delim("tokens.txt", header=F)
token <- str_split(tokens$V1, pattern=" ")[[1]][2]

dat_struct <- ds_xlsx %>% #read in excel file above
  drop_na(title) %>% 
  select(startdate, enddate, starttime, endtime, title, slug,
         lead_instructor, supporting_instructor1, supporting_instructor2,
         helper1, helper2, helper3,
         carpentry, curriculum, flavor, host,
         venue, address, country,
         eventbrite, repository) %>% 
  mutate(startdate = as.POSIXlt(startdate, tz="Europe/Amsterdam", format="%Y-%m-%d"), #convert to our timezone so CET or CEST is displayed in humandate
         enddate = as.POSIXlt(enddate, tz="Europe/Amsterdam",format="%Y-%m-%d"), 
         humandate = ifelse(months(dat_struct$startdate)==months(dat_struct$enddate), #this includes the month for end date only when workshop go over month switch
                            paste0(format(dat_struct$startdate, format="%B %d -"), 
                                   format(dat_struct$enddate, format=" %d, %Y, %Z")), 
                            paste0(format(dat_struct$startdate, format="%B %d -"), 
                                   format(dat_struct$enddate, format=" %B %d, %Y, %Z"))),
         humantime = paste0(starttime, " - ", endtime),
         instructor = paste(lead_instructor, supporting_instructor1, supporting_instructor2, sep = ", "),
         instructor = gsub(", NA", "", instructor),
         helper = paste(helper1, helper2, helper3, sep=", "),
         helper = gsub(", NA", "", helper),
         latitude = osm_search(address, key=token)$lat,
         longitude = osm_search(address, key=token)$lon
         )
  
data_file <- dat_struct %>% 
  select(venue, address, country, latitude, longitude,
         humandate, humantime, 
         as.character(startdate), as.character(enddate),
         instructor, helper,
         carpentry, curriculum, title, slug, flavor)

xmas_special <- data_file[23,]
write_csv(xmas_special, "data.csv")

  
  mutate(latitude = (address))

  


#venue, address, country, latitude, longitude, (include lat/long in df creation, keep API key local)
#humandate, humantime, (done)

#startdate, enddate, (done)
#instructor, helper, (concatanate / done ask)
#carpentry, curriculum, (done)
#title, slug, flavor (done)

