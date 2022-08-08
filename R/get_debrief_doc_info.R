#' Get debriefing doc info
#'
#' Get specific information for a workshop needed to set up the debriefing document.
#' The input data is read from Holy Excel sheet.
#'
#' @param info information read from Holy Excel sheet: dataframe with
#' information about the workshop - used to set up the debriefing document
#'
#' @return debrief doc information to be used in rendering the doc
#'
#' @export
#'
get_debrief_doc_info <- function(info) {
  debrief_doc_info <- list(
    YYYYMMDD = as.character(info$startdate),
    set_title = paste(info$slug, "debriefing document"),
    show_text = TRUE
  )
  return(debrief_doc_info)

}
