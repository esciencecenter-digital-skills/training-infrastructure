#' Render communications doc
#'
#' Checks if the upcoming workshop is online or in person. Takes the appropriate template Rmd document from the template
#' repository. Renders a filled in document with specific information for the workshop.
#' Rendered docs will be saved in html and docx formats (default). Files will be saved in the working directory.
#'
#' @param info a dataframe with information about the upcoming workshop
#' @param outformat if left empty, both html and docx are printed. otherwise, choose one with "html", or "docx".
#' @param template_url the place where the template for the communication document is saved in Rmd format
#'
#' @export

render_comms_doc = function(info, outformat = "", template_url = "https://raw.githubusercontent.com/esciencecenter-digital-skills/template-docs-coordination/master/") {

  # check if workshop is online or in person, choose template accordingly
  if (stringr::str_detect(info$location, "online")) {
    doctype = "communication_online"}
  else {
    warning(paste0(info$slug, ": address field is not set to *online*, assuming in-person workshop"))
    doctype = "communication_irl"
  }

  # download the correct template and give it the name of the slug plus the template name

  doc_loc <- paste0("files/", info$slug, "/")
  doc_name <- paste0(info$slug, "_", doctype, "_doc")

  comms_templ <- paste0(template_url, doctype, "_doc.Rmd") # URL to the Rmd template
  download.file(comms_templ, paste0(doc_loc, doc_name, ".Rmd"))

  # update the downloaded Rmd file and knit to the desired file format, html, docx or both (this can probably be optimized (: )
  if (stringr::str_detect(outformat, "html")) {
    rmarkdown::render(
      paste0(doc_loc, doc_name, ".Rmd"),
      params = info,
      output_format = "html_document",
      output_dir = doc_loc,
      output_file = paste0(doc_name, ".html") # render, save in current WD (for now) with proper name
    )
  }

  else if (stringr::str_detect(outformat, "docx"))  {
    rmarkdown::render(
      paste0(doc_loc, doc_name, ".Rmd"),
      params = info,
      output_format = "word_document",
      output_dir = doc_loc,
      output_file = paste0(doc_name, ".docx") # render, save in current WD (for now) with proper name
    )
  }

  else {
    rmarkdown::render(
      paste0(doc_loc, doc_name, ".Rmd"),
      params = info,
      output_format = "html_document",
      output_dir = doc_loc,
      output_file = paste0(doc_name, ".html") # render, save in current WD (for now) with proper name
    )

    rmarkdown::render(
      paste0(doc_loc, doc_name, ".Rmd"),
      params = info,
      output_format = "word_document",
      output_dir = doc_loc,
      output_file = paste0(doc_name, ".docx") # render, save in current WD (for now) with proper name
    )
  }
}
