#' Render planning doc
#'
#' Take the markdown file and render a word planning doc to be used in workshops
#'
#' @param plan_doc_info information about the workshop to be inserted into the planning document
#'
#' @return planning doc information to be used in rendering the doc
#'
#' @importFrom RCurl getURL
#' @importFrom rmarkdown render
#' @importFrom training-infrastructure get_plan_doc_info
#'
#' @export

render_plan <- function(plan_doc_info) {
  render(
    "files/planning_doc.Rmd",
    params = plan_doc_info,
    output_file = paste0(plan_doc_info$slug, '/', plan_doc_info$slug, "-planning_doc.docx")
  )
}
