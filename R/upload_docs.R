#' Upload docs
#'
#' @param instr_team teams object obtained through running Microsoft365R::get_team("Instructors")
#' @param info information about the workshop for which the documents need to be uploaded
#' @param comms `TRUE` if the debriefing document should be uploaded (default)
#' @param planning `TRUE` if the planning document should be uploaded (default)
#' @param debriefing `TRUE` if the debriefing document should be uploaded (default)
#' @param datafl `TRUE` if the data.csv file should be uploaded (default)
#'
#' @export
#'
upload_docs <- function(instr_team, info,
                        comms = TRUE,
                        planning = TRUE,
                        debriefing = TRUE,
                        datafl = TRUE) {

  drv <- instr_team$get_drive()
  sharepointexist <- try(drv$get_item(info$slug), silent=T) # try to retrieve sharepoint site for slug and save error if it did not work

  if ("try-error" %in% class(sharepointexist)) { # another error probably means the login didn't work

    warning("retrieving Sharepoint folders failed, please check your M365 login. \nNo documents have been uploaded.")

  } # if no error, no action is needed.

  else {

    # per document: check if the item exists, if not, upload to sharepoint. if it does, ask for permission to overwrite
    if (comms == TRUE) {

      overwrite_comms = TRUE

      if (paste0(info$slug, "_communication_doc.docx") %in% drv$get_item(paste0(info$slug))$list_files()$name) {
        overwrite_comms <- askYesNo(paste0(info$slug, ": You will overwrite the old communication doc file. Do you want to continue?"), default = TRUE)
      }

      if (!paste0(info$slug, "_communication_doc.docx") %in% drv$get_item(paste0(info$slug))$list_files()$name | overwrite_comms == TRUE) {
        drv$upload_file(src = paste0("files/", info$slug, "/", info$slug, "_communication_doc.docx"),
                        dest = paste0(info$slug, "/", info$slug, "_communication_doc.docx"))
        drv$upload_file(src = paste0("files/", info$slug, "/", info$slug, "_communication_doc.html"),
                        dest = paste0(info$slug, "/", info$slug, "_communication_doc.html"))
      }
    }

    if (datafl == TRUE) {

      overwrite_datafl = TRUE

      if ("data.csv" %in% drv$get_item(paste0(info$slug))$list_files()$name) {
        overwrite_datafl <- askYesNo(paste0(info$slug, ": You will overwrite the old data.csv file. Do you want to continue?"), default = TRUE)
      }

      if (!("data.csv" %in% drv$get_item(paste0(info$slug))$list_files()$name) | overwrite_datafl == TRUE) {
        drv$upload_file(src = paste0("files/", info$slug, "/","data.csv"),
                        dest = paste0(info$slug, "/", "data.csv"))
      }
    }

    if (planning == TRUE) {

      overwrite_plan = TRUE

      if (paste0(info$slug, "_planning_doc.docx") %in% drv$get_item(paste0(info$slug))$list_files()$name) {
        overwrite_plan <- askYesNo(paste0(info$slug, ": You will overwrite the old planning doc file. Do you want to continue?"), default = TRUE)
      }

      if (!paste0(info$slug, "_planning_doc.docx") %in% drv$get_item(paste0(info$slug))$list_files()$name | overwrite_plan == TRUE) {
        drv$upload_file(src = paste0("files/", info$slug, "/", info$slug, "_planning_doc.docx"),
                        dest = paste0(info$slug, "/", info$slug, "_planning_doc.docx"))
      }
    }

    if (debriefing == TRUE) {

      overwrite_debrief = TRUE

      if (paste0(info$slug, "_debriefing_doc.docx") %in% drv$get_item(paste0(info$slug))$list_files()$name) {
        overwrite_debrief <- askYesNo(paste0(info$slug, ": You will overwrite the old debriefing doc file. Do you want to continue?"), default = TRUE)
      }

      if (!paste0(info$slug, "_debriefing_doc.docx") %in% drv$get_item(paste0(info$slug))$list_files()$name | overwrite_debrief == TRUE) {
        drv$upload_file(src = paste0("files/", info$slug, "/", info$slug, "_debriefing_doc.docx"),
                        dest = paste0(info$slug, "/", info$slug, "_debriefing_doc.docx"))
      }
    }

  }
}
