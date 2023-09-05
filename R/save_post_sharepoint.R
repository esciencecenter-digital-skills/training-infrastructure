#' Write message to Channel
#'
#' @param info a named vector with workshop information based on the digital skills programme excel file
#' @param alert the Teams name of any other people that need to be alerted (likely the Training Coordinator)
#'
#' @export
save_post_sharepoint <- function(info, alert = NULL) {

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
  whole_team <- get_team(instr_team)

  for(person in people){
    team_member <- return_closest_member(person, whole_team)
    team_member <- tryCatch({instr_team$get_member(team_member)}, error = function(e) NULL)
    team_members <- c(team_members, team_member)
  }

  return(team_members)
}

get_team <- function(instr_team){
  team_env <- instr_team$list_members()
  team <- NULL
  for(m in team_env){
    name <- m$properties$displayName
    team <- c(team, name)
  }
  return(team)
}

return_closest_member <- function(name, team){
  # return the name directly if it is part of the team as is
  if(name %in% team){
    return(name)
  }
  # try to find a close match, but only return it if one match is found
  index <- agrep(name, team, max.distance = 4, ignore.case = TRUE)
  found <- team[index]
  if(length(index) == 1){
    message(paste0("The Microsoft user name '", name,
                   "' was not found, but close match '",
                   found, "' will be notified."))
    return(found)
  }
  # if none or more than one name matches, throw a warning and do not return any
  warning(paste0("Cannot find team member ", name,
                 ". This person won't be notified automatically."))
  return(NULL)
}
