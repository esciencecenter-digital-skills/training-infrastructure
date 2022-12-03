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
  verify_info(info)

  instr_team <- Microsoft365R::get_team(team)  #make the retrieval of the team part of the function rather than part of the setup
  slug <- info$slug

  channelexist <- try(instr_team$get_channel(slug), silent=T)
  if ("try-error"%in%class(channelexist)){
    if(stringr::str_detect(channelexist[1], "Invalid channel name")){
      instr_team$create_channel(slug)

      # confirm that channel was correctly created
      channelexist <- try(instr_team$get_channel(slug), silent=T)
      if(!"try-error"%in%class(channelexist)){
        print(paste("Channel", slug, "created"))
      } else{
        warning(paste("Something went wrong. Channel", slug, "was not created."))
      }

    } else {
      warning("retrieving Teams channels failed, please check your M365 login")
    }
  }
  else {
    # if retrieving the channel does not fail, no action is required.
    warning(paste("No new channel created:", info$slug, "already exists."))
  }
}
