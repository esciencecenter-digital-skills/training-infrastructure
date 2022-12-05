#' Create files
#'
#' Take the template word documents and save them with specific information
#' for the upcoming workshop.
#'
#' @param info named vector with workshop information
#' @export
create_files <- function(info){
  comms_doc_info <- get_comms_doc_info(info)
  render_comms_doc(comms_doc_info)
  planning_doc_info <- get_planning_doc_info(info)
  render_doc(planning_doc_info, "planning")
  debrief_doc_info <- get_debrief_doc_info(info)
  render_doc(debrief_doc_info, "debriefing")
}


render_doc <- function(info, type){
  doc_types <- c("planning", "comms", "debriefing")
  if(!type %in% doc_types){
    stop("Wrong `type`: only `planning`, `comms` and `debriefing` docs can be rendered.")
  }

  template_url <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/template-docs-coordination/master/"

  slug <- info$slug
  doc_name <- paste0(slug, "_", type, "_doc")
  template_online <- paste0(template_url, type, "_doc.Rmd")
  template_local <- paste0(doc_name, ".Rmd")
  rendered_local <- paste0(doc_name, ".docx")

  download.file(url = template_online,
                destfile = template_local)

  rmarkdown::render(
    input = template_local,
    params = info,
    output_file = rendered_local)
}



