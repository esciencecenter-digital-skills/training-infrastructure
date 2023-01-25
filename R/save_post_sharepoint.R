#' Write message to Channel
#'
#' @param info a named vector with workshop information based on the digital skills programme excel file
#' @param alert any other people that need to be alerted
#'
#' @export
save_post_sharepoint <- function(info, alert = "Sven van der Burg") {

  instr_team <- Microsoft365R::get_team("Instructors")

  team_members <- get_people(info, alert, instr_team)

  workshop_channel<-instr_team$get_channel(info$slug)

  workshop_channel$send_message(
    body = paste0(
      "Hello all, this is the channel for ", info$slug,
      ". (FYI: this is an automated message, and duplicates sometimes happen. ",
      "Sorry about that.)<br /><br />Alerting "),
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
  people <- people[!is.na(people)]

  team_members <- NULL

  for(person in people){
    team_member <- tryCatch(instr_team$get_member(person),
                            error = function(e) {
                              message(paste0("Cannot find team member ", person, ". This person will not be notified automatically."))
                              })
    team_members <- c(team_members, team_member)
  }

  # ## It is possible to see all members with
  # instr_team$list_members()
  #
  # ## Then on an individual member, e.g.:
  # mbr <- instr_team$list_members()[[6]]
  #
  # ## You can call properties
  # mbr$properties
  #
  # ## Such as id, or screen name
  # mbr$properties$displayName


  return(team_members)
}
