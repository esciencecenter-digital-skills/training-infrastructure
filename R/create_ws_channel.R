#' Create Microsoft Teams Channel
#'
#' Takes information about the workshop. Checks if a channel for a workshop slug already exists.
#' Creates a channel if it does not exist yet. Throws an error if channels cannot be retrieved.
#' (within the current workflow, this will most likely be from the "Instructors" channel)
#'
#' @param instr_team a teams Microsoft 365 object
#' @param slug slug of the workshop. Usually will be input through info (from the holy excel sheet). info$slug will have this parameter
#'
#' @export
#'

create_ws_channel <- function(instr_team, slug) {
  channelexist <- try(instr_team$get_channel(slug), silent=T)
  if (class(channelexist) == "try-error" && channelexist[1] == "Error : Invalid channel name\n") {  #if 404, the folder does not exist, create it
    instr_team$create_channel(slug)
    oops_message <- paste("Channel", as.character(slug), "created")
    warning(oops_message)
  }
  else if (class(channelexist) == "try-error") {
    oops_message <- "retrieving teams channels failed, please check your Sharepoint login"
    warning(oops_message)
  } # if retrieving the channel does not fail, no action is required.
}
