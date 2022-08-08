#' Render debriefing doc
#'
#' Take the markdown file and render a word planning doc to be used in workshops
#'
#' @param info information about the workshop to be inserted into the debriefing document
#' @param template_url the place where the template for the document is saved in Rmd format
#'
#'
#' @export

render_debrief_doc = function(info, template_url = "https://raw.githubusercontent.com/esciencecenter-digital-skills/template-docs-coordination/master/") {

  doctype = "debriefing"

  debrief_templ <- paste0(template_url, doctype, "_doc.Rmd") # URL to the Rmd template
  download.file(debrief_templ, paste0(info$slug, doctype, "_doc.Rmd")) # download and save in current WD (for now)

  # update the downloaded Rmd file and knit to the desired file format
  rmarkdown::render(
    paste0(info$slug, doctype, "_doc.Rmd"),
    params = info,
    output_file = paste0(info$slug, "-debriefing_doc.docx") # render, save in current WD (for now) with proper name
  )

}
