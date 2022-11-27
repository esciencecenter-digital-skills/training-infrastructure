#' Create files
#'
#' Take the template word documents and save them with specific information
#' for the upcoming workshop.
#'
#' @param workshop workshop slug
#' @param data database with workshop information
#' @param comms boolean indicating whether the comms doc should be created
#' @param plan boolean indicating whether the plan doc should be created
#' @param debrief boolean indicating whether the debrief doc should be created
#' @param folder location where the files should be saved
#' @export
create_files <- function(workshop, data, comms = F, plan = F, debrief = F, folder = "."){

  wsdat <- get_workshop(data, workshop)

  if(comms){
    comms_doc_info <- get_comms_doc_info(wsdat)
    render_comms_doc(comms_doc_info, folder = folder)
  }

  if(plan){
    planning_doc_info <- get_planning_doc_info(wsdat)
    render_planning_doc(planning_doc_info, folder = folder)
  }

  if(debrief){
    debrief_doc_info <- get_debrief_doc_info(wsdat)
    render_debrief_doc(debrief_doc_info, folder = folder)
  }




}


get_workshop <- function(df, slug){
  df <- df[!is.na(df$slug),] # in case there are NAs left in the df
  selected_ws <- df[df$slug==slug,]
  return(selected_ws)
}
