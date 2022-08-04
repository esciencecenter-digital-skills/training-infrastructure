#' Get debriefing doc info
#'
#' Get specific information for a workshop needed to set up the debriefing document.
#' The input data is read from Holy Excel sheet.
#'
#' @param ws_dat information read from Holy Excel sheet: dataframe with
#' information about the workshop - used to set up the debriefing document
#'
#' @return debrief doc information to be used in rendering the doc
#'
#' @export
#'
get_debrief_doc_info <- function(ws_dat) {
  debrief_doc_info <- list(
    YYYYMMDD = as.character(ws_dat$startdate),
    set_title = paste(ws_dat$slug, "debriefing document"),
    show_text = TRUE
  )
  return(debrief_doc_info)

}
