
save_sharepoint <- function(slug, instructors, helpers, coordinator = "Lieke") {
  #' Take information from the master spreadsheet with all future workshops, and extract the relevant information for GitHub pages
  #' Input: 
  #'         excelfile: a df created based on the digital skills programme excel file
  #'         
  #' Ouput:
  #'         A dataframe that should be saved as data.csv in the workshop folder in SharePoin
  library(Microsoft365R)
  
  exec_dir <- dirname(rstudioapi::getSourceEditorContext()$path) #the dir this script is in
  setwd(exec_dir)
  
  list_sharepoint_sites()
  site <- list_teams()
  Mateusz <- instr_team$get_member("Mateusz Kuzak")  
  Lieke <- instr_team$get_member("Lieke de Boer") 
  
  lead_instr <- instr_team$get_member
  
  #slug <- "2021-12-24-dc-socsci-R-nlesc"
  
  instr_team<-get_team("Instructors")
  instr_team$create_channel(slug)
  workshop_channel<-instr_team$get_channel(slug)
  
  workshop_channel$send_message(body = "Hi all, @Lieke de Boer, this is a test message that you can all safely ignore", 
                                mentions = Mateusz, content_type = 'html')
  
  instr_site <-get_sharepoint_site(site_url="https://nlesc.sharepoint.com/sites/instructors")
  drv <- instr_site$get_drive()
  drv$upload_file(src=paste0(slug, "/data.csv"), dest=paste0(slug, "/data.csv"))
  

  
}

#drv$list_files()
#cc<-bb$get_lists()
#dd<-cc[[18]]$list_items()


#cc<-get_business_onedrive("nlesc/sites/instructors")

