#' Save to Sharepoint
#'
#' Take information from the master spreadsheet with all future workshops, and extract the relevant information for GitHub pages
#'
#' @param ws_dat a dataframe created based on the digital skills programme excel file
#'
#' @return a dataframe that should be saved as data.csv in the workshop folder in SharePoint
#'
#' @importFrom Microsoft365R get_sharepoint_site get_team list_teams
#' @export
#'
save_sharepoint <- function(ws_dat) {

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
  workshop_channel<-instr_team$get_channel(ws_dat$slug)

  workshop_channel$send_message(body = paste("Hello all, this is the channel for", slug),
                                mentions = c(Lead_instructor, Supp_instr1, Supp_instr2, Helper1, Helper2, Helper3, Mateusz, Lieke),
                                content_type = 'html')

  instr_site <-get_sharepoint_site(site_url="https://nlesc.sharepoint.com/sites/instructors")
  drv <- instr_site$get_drive()
  drv$upload_file(src=paste0("files/", ws_dat$slug, "/data.csv"), dest=paste0(ws_dat$slug, "/data.csv"))

}
