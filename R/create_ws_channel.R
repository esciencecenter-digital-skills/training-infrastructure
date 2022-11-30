#' Create Microsoft Teams Channel
#'
#' Takes information about the workshop. Checks if a channel for a workshop slug already exists.
#' Creates a channel if it does not exist yet. Throws an error if channels cannot be retrieved.
#' (within the current workflow, this will most likely be from the "Instructors" channel)
#'
#' @param info information about the workshop taken from the holy excel sheet
#' @param team the name of the team in Teams where the channel will be created
#'
#' @export
#'

create_ws_channel <- function(info, team = "Instructors") {

  instr_team <- Microsoft365R::get_team(team)  #make the retrieval of the team part of the function rather than part of the setup

  slug <- info$slug
  channelexist <- try(instr_team$get_channel(slug), silent=T)
  if ("try-error"%in%class(channelexist)){
    if(stringr::str_detect(channelexist[1], "Invalid channel name")){
      instr_team$create_channel(info$slug)
      message <- paste("Channel", as.character(info$slug), "created")
      print(message)
    } else{
      warning("retrieving teams channels failed, please check your M365 login")
    }
  }
  else {
    message <- (paste0("No new channel created, because the following channel already exists:", slug))# if retrieving the channel does not fail, no action is required.
  }
}
