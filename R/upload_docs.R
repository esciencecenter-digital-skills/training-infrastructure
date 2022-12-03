upload_docs <- function(info,
                        drive = "instructors") {
  verify_info(info)

  siteloc <- paste0("https://nlesc.sharepoint.com/sites/", drive)

  instr_site <- Microsoft365R::get_sharepoint_site(siteloc)
  drv        <- instr_site$get_drive()

  #instr_team <- Microsoft365R::get_team(drive)
  #drv <- instr_team$get_drive()

  drv_check <- check_drive(drv, info$slug)
  if ("try-error" %in% drv_check) {
    stop("retrieving Sharepoint folders failed, please check your M365 login. \nNo documents have been uploaded.")
  }

  drv_content <- drv$get_item(info$slug)$list_files()$name

  # list of files that are created
  flist <- paste0(info$slug, "_planning_doc.docx")

  for(file in flist){
    if(!file %in% drv_content){
      destname <- paste0(info$slug, "/", file)
      drv$upload_file(src = file, dest = destname)
    } else{
      warning(paste(file, "already exist in the sharepoint drive."))
    }
  }

}

check_drive <- function(drive, slug){
  sharepointexist <- try(drive$get_item(slug), silent=T) # try to retrieve sharepoint site for slug and save error if it did not work
  return(class(sharepointexist))
}
