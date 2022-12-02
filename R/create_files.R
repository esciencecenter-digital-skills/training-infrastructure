#' Create files
#'
#' Take the template word documents and save them with specific information
#' for the upcoming workshop.
#'
#' @param info named vector with workshop information
#' @export
create_files <- function(info){
  comms_doc_info <- get_comms_doc_info(info)
  render_comms_doc(comms_doc_info)
  planning_doc_info <- get_planning_doc_info(info)
  render_planning_doc(planning_doc_info)
  debrief_doc_info <- get_debrief_doc_info(info)
  render_debrief_doc(debrief_doc_info)
}
