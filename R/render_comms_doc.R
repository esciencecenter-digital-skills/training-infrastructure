#' Render communications doc
#'
#' @param info
#'
#' @importFrom RCurl getURL
#' @return
#' @export
#'
#' @examples

render_comms_doc = function(info) {

  if (str_detect(info$address, "online")) {
    comm_doc_template = "files/communication_doc_online.Rmd"}
  else {
    warning(paste0(info$slug, ": address field is not set to *online*, assuming in-person workshop"))
    comm_doc_template = "files/communication_doc_irl.Rmd"
  }

  rmarkdown::render(
    comm_doc_template,
    params = info,
    output_file = paste0(info$slug, '/', info$slug, "-communication_doc.docx")
  )
}
