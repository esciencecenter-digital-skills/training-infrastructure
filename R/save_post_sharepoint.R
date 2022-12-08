#' Write message to Channel
#'
#' Take information from the master spreadsheet with all future workshops, and extract the relevant information for GitHub pages
#'
#' @param info a dataframe created based on the digital skills programme excel file
#' @param alert any other people that need to be alerted
#'
#' @export
save_post_sharepoint <- function(info, alert = "Sven van der Burg") {

  instr_team <- Microsoft365R::get_team("Instructors")

  team_members <- get_people(info, alert, instr_team)

  workshop_channel<-instr_team$get_channel(info$slug)

  workshop_channel$send_message(body = paste("Hello all, this is the channel for", info$slug),
                                 mentions = team_members,
                                 content_type = 'html')

  return(invisible(NULL))
}


get_people <- function(info, alert, instr_team){
  people <- c(info$lead_instructor,
              info$supporting_instructor1,
              info$supporting_instructor2,
              info$helper1,
              info$helper2,
              info$helper3,
              alert)

  people <- unique(people)

  team_members <- NULL

  for(person in people){
    person <- tryCatch({instr_team$get_member(person)}, error = function(e) NULL)
    team_members <- c(team_members, person)
  }

  return(team_members)
}
