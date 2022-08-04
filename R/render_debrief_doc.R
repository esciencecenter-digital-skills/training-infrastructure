#' Render debriefing doc
#'
#' Take the markdown file and render a word planning doc to be used in workshops
#'
#' @param info information about the workshop to be inserted into the debriefing document
#'
#' @return no output, just save the doc
#'
#' @export

render_debrief_doc = function(info) {
  rmarkdown::render(
    "files/debriefing_doc.Rmd",
    params = debrief_doc_info,
    output_file = paste0(ws_dat$slug, '/', ws_dat$slug, "-debriefing_doc.docx")
  )
}
