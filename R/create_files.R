#' Create files
#'
#' Take the template word documents and save them with specific information for the upcoming workshop in the corresponding Sharepoint channel
#'
#' @param ws_dat information about the workshop to be inserted into the different documents
#' @param meta_fld the URL of the meta folder
#'
#' @return no output, just saving files within the project directory
#'
#' @importFrom RCurl getURL
#' @importFrom rmarkdown render
#' @export
#'
create_files <- function(ws_dat, meta_fld) {

plan_doc_info <- list(
  YYYYMMDD = as.character(ws_dat$startdate),
  sharepoint = paste0("[Sharepoint](", ws_dat$newch, ")"),
  workshop_website = paste0(
    "[workshop website](",
    "https://esciencecenter-digital-skills.github.io/",
    slug,
    ")"
  ),
  registration_page = paste0(
    "[registration page](",
    "https://www.eventbrite.co.uk/e/",
    ws_dat$eventbrite,
    ")"
  ),
  set_title = paste(ws_dat$slug, "planning document"),
  lead_instructor = ws_dat$lead_instructor,
  instructor = ws_dat$instructor,
  helper = ws_dat$helper,
  show_text = TRUE
)

render_plan = function(plan_doc_info) {
  render(
    "files/planning_doc.Rmd",
    params = plan_doc_info,
    output_file = paste0(ws_dat$slug, '/', ws_dat$slug, "-planning_doc.docx")
  )
}

debrief_doc_info <- list(
  YYYYMMDD = as.character(ws_dat$startdate),
  set_title = paste(ws_dat$slug, "debriefing document"),
  show_text = TRUE
)

render_debrief = function(debrief_doc_info) {
  render(
    "files/debriefing_doc.Rmd",
    params = debrief_doc_info,
    output_file = paste0(ws_dat$slug, '/', ws_dat$slug, "-debriefing_doc.docx")
  )
}

render_debrief(debrief_doc_info)
render_plan(plan_doc_info)

}
