#' Create files
#'
#' Take the template word documents and save them with specific information for the upcoming workshop in the corresponding Sharepoint channel
#'
#' @param ws_dat workshop data: information about the workshop to be inserted into the different documents
#' @param meta_fld the URL of the meta folder
#'
#' @return no output, just saving files within the project directory
#'
#' @export
#'
create_files <- function(ws_dat, meta_fld) {

  debrief_doc_info <- get_debrief_doc_info(wsdat)
  plan_doc_info <- get_plan_doc_info(wsdat)

  render_debrief_doc(debrief_doc_info)
  render_plan_doc(plan_doc_info)

}
