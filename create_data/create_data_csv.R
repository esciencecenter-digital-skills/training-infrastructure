#-------------------------------------------
# Script by Lieke de Boer, July 2021
# Takes the digital skills workshops excel sheet and creates a datafile for the corresponding GH repo. Initially saves this locally.
# Checks if a workshop is ready to be uploaded (based on "yes" in ready column) and if so
# creates a Microsoft Teams channel with the same name as a workshop's slug,
# posts a message in the Microsoft Teams channel tagging instructors and helpers.
# Creates planning, communication and debriefing documents (.docx) from Rmd templates.
# ------------------------------------------
# To Do:
# - make sure that template documents are also uploaded (debriefing, communication, planning)
# - investigate possibility for automatic PR based on "ready"
#-------------------------------------------

library(traininginfrastructure)
library(Microsoft365R)
library(tidyverse)
library(rio)
library(nominatim)

exec_dir <- dirname(rstudioapi::getSourceEditorContext()$path) #the dir this script is in
setwd(exec_dir)

tokens     <- read.delim("tokens.txt", header=F)
token      <- stringr::str_split(tokens$V1, pattern=" ")[[1]][2]

instr_site <- get_sharepoint_site(site_url="https://nlesc.sharepoint.com/sites/instructors")
drv        <- instr_site$get_drive()
ds_xlsx    <- drv$download_file("General/Digital Skills Workshops 2022.xlsx", overwrite = T) #get the latest version of the excel sheet and overwrite the previous download
ds_xlsx    <- import("Digital Skills Workshops 2022.xlsx") #TODO: save using a portable filename. Consider adding to .gitignore
ds_xlsx    <- ds_xlsx[ds_xlsx$startdate >= Sys.time(), ] # only read workshop dates after today
dat_struct <- get_future_workshops(ds_xlsx) # extracts relevant information for GH page from spreadsheet

save_viable_data(dat_struct) #only saves a data file in its folder if the slug is longer than 10 characters

ready_future <- na.omit(dat_struct$slug[dat_struct$ready=="yes"])

instr_team <- get_team("Instructors")

for (i in 1:length(ready_future)) {
  slug <- ready_future[i]
  ws_dat <- dat_struct[dat_struct$slug==slug,]
  meta_fld <- get_meta_fld(slug)

  result = tryCatch({
    instr_team$get_channel(slug)
  }, error = function(e) {
    create_files(ws_dat, meta_fld)

    print(paste0("trying to retrieve channel '", slug, "' threw this ", e, " creating channel."))
    instr_team$create_channel(slug)
    ws_dat$newch <- instr_team$get_channel(slug)$get_folder()$properties$webUrl #sharepoint URL

    if (drv$get_item(paste0(slug, "/", slug, "-planning_doc.docx"))$type!="drive item") {
      drv$upload_file(src = paste0("files/", slug, "/", slug, "-planning_doc.docx"),
                    dest = paste0(slug, "/", slug, "-planning_doc.docx"))
    }

    if (drv$get_item(paste0(slug, "/", slug, "-communication_doc.html"))$type!="drive item") {
      drv$upload_file(src = paste0("files/", slug, "/", slug, "-communication_doc.docx"),
                      dest = paste0(slug, "/", slug, "-communication_doc.docx"))
    }

    if (drv$get_item(paste0(slug, "/", slug, "-debriefing_doc.docx"))$type!="drive item") {
      drv$upload_file(src = paste0("files/", slug, "/", slug, "-debriefing_doc.docx"),
                      dest = paste0(slug, "/", slug, "-debriefing_doc.docx"))

    }
    save_post_sharepoint(ws_dat)
  }, finally = {
    #instr_team$create_channel(slug)
  })


}



