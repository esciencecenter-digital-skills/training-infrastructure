#' Render planning doc
#'
#' Take the markdown file and render a word planning doc to be used in workshops
#'
#' @param plan_doc_info information about the workshop to be inserted into the planning document
#'
#' @importFrom RCurl getURL
#'
#' @return no output, just save the doc
#'
#' @export

render_plan_doc <- function(plan_doc_info) {
  rmarkdown::render(
    "files/planning_doc.Rmd",
    params = plan_doc_info,
    output_file = paste0(plan_doc_info$slug, '/', plan_doc_info$slug, "-planning_doc.docx")
  )
}
