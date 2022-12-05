#' Upload documents to sharepoint
#'
#' @param info information about the workshop taken from the holy excel sheet
#' @param drive the name of the Sharepoint drive where the workshop folder lives
#'
#' @export
upload_docs <- function(info,
                        drive = "instructors") {
  verify_info(info)
  slug <- info$slug

  spsite <- paste0("https://nlesc.sharepoint.com/sites/", drive)
  instr_site <- Microsoft365R::get_sharepoint_site(site_url=spsite)
  drv        <- instr_site$get_drive()

  drv_check <- check_drive(drv, slug)
  if ("try-error" %in% drv_check) {
    stop("retrieving Sharepoint folders failed, please check your M365 login.
    \nNo documents have been uploaded.")
  }

  drv_content <- drv$get_item(slug)$list_files()$name

  # list of files that contain the slug
  flist <- list.files()
  flist <- flist[grep(slug, flist)]

  for(file in flist){
    if(!file %in% drv_content){
      destname <- paste0(slug, "/", file)
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
