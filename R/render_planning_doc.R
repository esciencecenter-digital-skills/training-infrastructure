#' Render planning doc
#'
#' Take the markdown file and render a word planning doc to be used in workshops
#'
#' @param info information about the workshop used to set up the planning document
#'
#' @return no output, just save the doc
#'
#' @export

render_plan <- function(info) {
  rmarkdown::render(
    "files/planning_doc.Rmd",
    params = plan_doc_info,
    output_file = paste0(plan_doc_info$slug, '/', plan_doc_info$slug, "-planning_doc.docx")
  )
}
