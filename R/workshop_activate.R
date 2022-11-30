#' Choose workshops and activate them
#'
#' @param df data frame with future workshops (use `get_future_workshops()`)
#'
#' @export
workshop_activate <- function(df){
  df <- df[df$ready == "yes",]
  df <- dplyr::mutate(df,
                        summary = paste(
                          startdate, title, "(lead:", lead_instructor,")", venue
                          ))

  message("The following workshops are ready to go:")
  for(i in 1:nrow(df)){
    state <- paste0(as.character(i), ": ", df$summary[i])
    message(state)
  }

  activews <- readline(
    prompt = "Which workshop do you want to activate? (one at a time...) ")
  activews <- as.numeric(activews)
  activews <- df[activews,]

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
