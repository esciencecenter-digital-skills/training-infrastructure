#' Get debriefing doc info
#'
#' Get the specific information for the upcoming workshop so it can be used in the debriefing doc
#'
#' @param ws_dat information about the workshop to be inserted into the debriefing document
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
