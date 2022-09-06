#' Create Sharepoint site
#'
#' Takes information about the workshop. Checks if a sharepoint folder for a workshop slug already exists.
#' Creates a folder if it does not exist yet. Throws an error if sharepoint folders cannot be retrieved.
#' (within the current workflow, this will most likely be from the "Instructors" Sharepoint page)
#'
#' @param drv the Sharepoint Drive to check
#' @param info information about the workshop taken from the holy excel sheet
#'
#' @export
#'

create_sharepoint_folder <- function(drv, info) {
  sharepointexist <- try(drv$get_item(info$slug), silent=T) # try to retrieve sharepoint site for slug and save error if it did not work
  #drv$get_item(slug)$type

  if (class(sharepointexist) == "try-error" && str_detect(sharepointexist[1],"404")) { #if 404, the folder does not exist, make it
    drv$create_folder(info$slug)
    print(paste("Sharepoint folder", as.character(info$slug), "created"))
  }
  else if (class(channelexist) == "try-error") { # another error probably means the login didn't work
    warning("retrieving Sharepoint folders failed, please check your M365 login")
  } # if no error, no action is needed


}
