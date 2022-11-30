#' Choose workshops and activate them
#'
#' @param data dataframe with future workshops (use `get_future_workshops()`)
#'
#' @export
workshop_activate <- function(data){
  # what workshops are ready?

  # report to user: these are the workshops we have! which one do you want to activate?

  # based on user feedback: select a workshop

  # make sharepoint

  # make teams channel

  # create documents


}



get_workshop <- function(df, slug){
  df <- df[!is.na(df$slug),] # in case there are NAs left in the df
  selected_ws <- df[df$slug==slug,]
  return(selected_ws)
}
