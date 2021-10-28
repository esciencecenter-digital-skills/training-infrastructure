save_sharepoint <- function(ws_dat) {
  #' Take information from the master spreadsheet with all future workshops, and extract the relevant information for GitHub pages
  #' Input: 
  #'         excelfile: a df created based on the digital skills programme excel file
  #'         
  #' Ouput:
  #'         A dataframe that should be saved as data.csv in the workshop folder in SharePoin
  library(Microsoft365R)
  
  site <- list_teams()
  Mateusz <- instr_team$get_member("Mateusz Kuzak")  
  Lieke <- instr_team$get_member("Lieke de Boer")
  
  
  Lead_instructor = tryCatch({instr_team$get_member(ws_dat$lead_instructor)}, error = function(e) NULL)
  Supp_instr1 = tryCatch({instr_team$get_member(ws_dat$supporting_instructor1)}, error = function(e) NULL) 
  Supp_instr2 = tryCatch({instr_team$get_member(ws_dat$supporting_instructor2)}, error = function(e) NULL)
  Helper1 = tryCatch({instr_team$get_member(ws_dat$helper1)}, error = function(e) NULL)
  Helper2 = tryCatch({instr_team$get_member(ws_dat$helper2)}, error = function(e) NULL)
  Helper3 = tryCatch({instr_team$get_member(ws_dat$helper3)}, error = function(e) NULL)
  
  instr_team<-get_team("Instructors")
  workshop_channel<-instr_team$get_channel(slug)
  
  workshop_channel$send_message(body = paste("Hello all, this is the channel for", slug), 
                                mentions = c(Lead_instructor, Supp_instr1, Supp_instr2, Helper1, Helper2, Helper3, Mateusz, Lieke), 
                                content_type = 'html')
  
  instr_site <-get_sharepoint_site(site_url="https://nlesc.sharepoint.com/sites/instructors")
  drv <- instr_site$get_drive()
  drv$upload_file(src=paste0("files/", slug, "/data.csv"), dest=paste0(slug, "/data.csv"))
  
}
