#' Create Microsoft Teams Channel
#'
#' Takes information about the workshop. Checks if a channel for a workshop slug already exists.
#' Creates a channel if it does not exist yet. Throws an error if channels cannot be retrieved.
#' (within the current workflow, this will most likely be from the "Instructors" channel)
#'
#' @param instr_team a teams Microsoft 365 object
#' @param info information about the workshop taken from the holy excel sheet
#'
#' @export
#'

create_ws_channel <- function(instr_team, info) {
  channelexist <- try(instr_team$get_channel(info$slug), silent=T)
  if (class(channelexist) == "try-error" && channelexist[1] == "Error : Invalid channel name\n") {  #if 404, the folder does not exist, create it
    instr_team$create_channel(info$slug)
    print(paste("Channel", as.character(info$slug), "created"))
  }
  else if (class(channelexist) == "try-error") {
    warning("retrieving teams channels failed, please check your Sharepoint login")
  }
}
