#' Render communications doc
#' Checks if the upcoming workshop is online or in person. Takes the appropriate template Rmd document from the template
#' repository. Renders a filled in document with specific information for the workshop.
#' Rendered docs will be saved in html and docx formats (default). Files will be saved in "files" directory of
#' working directory, within a directory that has the same name as the slug of the workshop.
#'
#' @param info
#' @param outformat if left empty, both html and docx are printed. otherwise, choose one with "html", or "docx".
#'
#' @importFrom RCurl getURL
#' @export
#'

render_comms_doc = function(info, outformat = "") {

  if (str_detect(info$address, "online")) {
    comm_doc_template = "files/communication_doc_online.Rmd"}
  else {
    warning(paste0(info$slug, ": address field is not set to *online*, assuming in-person workshop"))
    comm_doc_template = "files/communication_doc_irl.Rmd"
  }


if (str_detect(outformat = "html")) {
    rmarkdown::render(
      comm_doc_template,
      params = info,
      output_file = paste0(info$slug, '/', info$slug, "-communication_doc.html")
    )
}

else if (str_detect(outformat = "docx"))  {
  rmarkdown::render(
  comm_doc_template,
  params = info,
  output_file = paste0(info$slug, '/', info$slug, "-communication_doc.docx")
  )
}

  else {
    rmarkdown::render(
      comm_doc_template,
      params = info,
      output_file = paste0(info$slug, '/', info$slug, "-communication_doc.html")
    )
  }
}
