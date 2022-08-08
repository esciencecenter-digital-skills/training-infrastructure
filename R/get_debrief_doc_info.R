#' Get debriefing doc info
#'
#' Get specific information for a single workshop, represented as one line in the df_struct variable.
#' This represents information about one workshop. The information that is returned in a format that
#' can be input to is to set up the debriefing document with `render_debrief_doc.R`.
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
    slug = info$slug,
    show_text = TRUE
  )
  return(debrief_doc_info)

}
