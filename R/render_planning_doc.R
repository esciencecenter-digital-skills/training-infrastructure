#' Render planning doc
#'
#' Take the markdown file and render a word planning doc for one workshop.
#'
#' @param info information about the workshop used to set up the planning document
#' @param template_url the place where the template for the document is saved in Rmd format
#'
#' @export

render_planning_doc <- function(info,
                                template_url = "https://raw.githubusercontent.com/esciencecenter-digital-skills/template-docs-coordination/master/",
                                folder = ".") {

  doctype = "planning"

  planning_templ <- paste0(template_url, doctype, "_doc.Rmd") # URL to the Rmd template
  download.file(planning_templ, paste0(info$slug, "_", doctype, "_doc.Rmd")) # download and save in current WD (for now)

  # update the downloaded Rmd file and knit to the desired file format
  rmarkdown::render(
    paste0(info$slug, "_", doctype, "_doc.Rmd"),
    params = info,
    output_file = paste0(folder,"/",info$slug, "_", doctype, "_doc.docx")
  )

}
