#devtools::install_github("hrbrmstr/nominatim")
library(rio)
library(tidyverse)
library(nominatim)
library(lubridate)
ds_xlsx <- import("/Users/liekedeboer/Netherlands eScience Center/Instructors - Documents/General/Digital Skills Workshops 2021.xlsx")

dat_struct <- ds_xlsx %>% 
  drop_na(title) %>% 
  select(startdate, enddate, starttime, endtime, title, slug,
         lead_instructor, supporting_instructor1, supporting_instructor2,
         helper1, helper2, helper3,
         carpentry, curriculum, flavor, host,
         venue, address, country,
         eventbrite, repository) %>% 
  mutate(startdate = as.POSIXlt(startdate, tz="Europe/Amsterdam"),
         enddate = as.POSIXlt(enddate, tz="Europe/Amsterdam"), 
         humandate = ifelse(months(dat_struct$startdate)==months(dat_struct$enddate), #this includes the month for end date only when workshop go over month switch
                            paste0(format(dat_struct$startdate, format="%B %d -"), 
                                   format(dat_struct$enddate, format=" %d, %Y, %Z")), 
                            paste0(format(dat_struct$startdate, format="%B %d -"), 
                                   format(dat_struct$enddate, format=" %B %d, %Y, %Z"))),
         humantime = paste0(starttime, " - ", endtime))
  

  
  mutate(latitude = (address))

  


venue, address, country, latitude, longitude, 
humandate, humantime, 

startdate, enddate, 
instructor, helper, 
carpentry, curriculum, 
title, slug, flavor

