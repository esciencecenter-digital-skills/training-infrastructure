#' Create Sharepoint site
#'
#' Takes information about the workshop. Checks if a sharepoint folder for a workshop slug already exists.
#' Creates a folder if it does not exist yet. Throws an error if sharepoint folders cannot be retrieved.
#' (within the current workflow, this will most likely be from the "Instructors" Sharepoint page)
#'
#' @param drv a microsoft 365 object that contains all the information about the Sharepoint Drive to check
#' # created within this function by calling get_sharepoint_site and get_drive on the returned object
#' @param info information about the workshop taken from the holy excel sheet
#'
#' @export
#'

create_sharepoint_folder <- function(drive = "Instructors", info) {

  instr_site <- Microsoft365R::get_sharepoint_site(site_url=paste0("https://nlesc.sharepoint.com/sites/", drive)) #make the retrieval of the sharepoint site part of the function rather than part of the setup
  drv        <- instr_site$get_drive()


  #create_sharepoint_folder <- function(drv, info) {
  sharepointexist <- try(drv$get_item(info$slug), silent=T) # try to retrieve sharepoint site for slug and save error if it did not work

  if ("try-error" %in% class(sharepointexist) == "try-error" && stringr::str_detect(sharepointexist[1],"404")) { #if 404, the folder does not exist, make it
    drv$create_folder(info$slug)
    spdrive <- try(drv$get_item(info$slug), silent=T)
    if("ms_drive_item" %in% class(spdrive)){
        print(paste("Sharepoint folder", as.character(info$slug), "created"))
    } else{
        warning(paste("Something went wrong. The folder", info$slug, "was not created."))
    }  
    
  }
  else if ("try-error" %in% class(sharepointexist)) { # another error probably means the login didn't work
    warning("retrieving Sharepoint folders failed, please check your M365 login")
  } # if no error, no action is needed.
  else(
    warning(paste("the folder", info$slug, "already exists"))
  )


}
