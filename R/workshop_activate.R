#' Choose workshops and activate them
#'
#' @param data dataframe with future workshops (use `get_future_workshops()`)
#'
#' @export
workshop_activate <- function(data){
  # what workshops are ready?
  data <- data[data$ready == "yes",]

  data <- dplyr::mutate(data,
                        summary = paste(startdate, title, "(lead:", lead_instructor,")", venue))
  #usersummary <- data[,c("startdate", "title", "lead_instructor", "venue")]

  # report to user: these are the workshops we have! which one do you want to activate?
  message("The following workshops are ready to go:")
  for(i in 1:nrow(data)){
    state <- paste0(as.character(i), ": ", data$summary[i])
    message(state)
  }

  activews <- readline(prompt = "Which workshop do you want to activate? (one at a time...) ")

  # based on user feedback: select a workshop
  activews <- as.numeric(activews)
  activews <- data[activews,]

  message(paste0("We are activating ", activews$slug, ". Please stand by!"))

  # make sharepoint
  message("Making sharepoint folder...")
  # TODO

  # make teams channel
  message("Making Teams channel...")
  # TODO

  # create documents
  message("Creating documents...")
  create_files(info = activews, comms = T, plan = T, debrief = T, folder = tempdir())
}



get_workshop <- function(df, slug){
  df <- df[!is.na(df$slug),] # in case there are NAs left in the df
  selected_ws <- df[df$slug==slug,]
  return(selected_ws)
}
