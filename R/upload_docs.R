#' Title
#'
#' @param instr_team teams object obtained through running Microsoft365R::get_team("Instructors")
#' @param info information about the workshop for which the documents need to be uploaded
#' @param comms `TRUE` if the debriefing document should be uploaded (default)
#' @param planning `TRUE` if the planning document should be uploaded (default)
#' @param debriefing `TRUE` if the debriefing document should be uploaded (default)
#' @param data `TRUE` if the data.csv file should be uploaded (default)
#'
#' @export
#'
upload_docs <- function(instr_team, info, comms = TRUE, planning = TRUE, debriefing = TRUE, data = TRUE) {

  drv <- instr_team$get_drive()
  sharepointexist <- try(drv$get_item(info$slug), silent=T) # try to retrieve sharepoint site for slug and save error if it did not work

  if ("try-error" %in% class(sharepointexist)) { # another error probably means the login didn't work

    warning("retrieving Sharepoint folders failed, please check your M365 login. \nNo documents have been uploaded.")

  } # if no error, no action is needed.

  else {

    #ws_dat$newch <- instr_team$get_channel(info$slug)$get_folder()$properties$webUrl #sharepoint URL
    if (comms = TRUE) {

      if (drv$get_item(paste0(info$slug, "/", info$slug, "-debriefing_doc.docx"))$type=="drive item") {
        overwrite_comms <- askYesNo("You will overwrite the old debriefing doc file. Do you want to continue?", default = TRUE)}

      if (drv$get_item(paste0(info$slug, "/", info$slug, "-debriefing_doc.docx"))$type!="drive item" | overwrite_comms == TRUE) {
        drv$upload_file(src = paste0("files/", info$slug, "/", info$slug, "-debriefing_doc.docx"),
                        dest = paste0(slug, "/", info$slug, "-debriefing_doc.docx"))
      }
    }

    if (planning = TRUE) {

      if (drv$get_item(paste0(info$slug, "/", info$slug, "-planning_doc.docx"))$type=="drive item") {
        overwrite_plan <- askYesNo("You will overwrite the old planning doc file. Do you want to continue?", default = TRUE)}

      if (drv$get_item(paste0(info$slug, "/", info$slug, "-planning_doc.docx"))$type!="drive item" | overwrite_plan == TRUE) {
        drv$upload_file(src = paste0("files/", info$slug, "/", info$slug, "-planning_doc.docx"),
                        dest = paste0(slug, "/", info$slug, "-planning_doc.docx"))
      }
    }

    if (debriefing = TRUE) {

      if (drv$get_item(paste0(info$slug, "/", info$slug, "-debriefing_doc.docx"))$type=="drive item") {
        overwrite_debrief <- askYesNo("You will overwrite the old debriefing doc file. Do you want to continue?", default = TRUE)}

      if (drv$get_item(paste0(info$slug, "/", info$slug, "-debriefing_doc.docx"))$type!="drive item" | overwrite_debrief == TRUE) {
        drv$upload_file(src = paste0("files/", info$slug, "/", info$slug, "-debriefing_doc.docx"),
                        dest = paste0(slug, "/", info$slug, "-debriefing_doc.docx"))
      }
    }

  }
}
