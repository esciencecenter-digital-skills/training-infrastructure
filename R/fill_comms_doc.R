#' Create files
#'
#' Take the template word documents and save them with specific information for the upcoming workshop in the corresponding Sharepoint channel
#'
#' @param comms_doc_info information about the workshop to be inserted into the different documents
#' should include: startdate, enddate, title, address, venue, starttime, endtime, slug
#' @param meta_fld the URL of the meta folder
#'
#' @return no output, just saving files within the project directory
#'
#' @importFrom RCurl getURL
#' @importFrom rmarkdown render
#' @export
#'
fill_comms_doc <- function(comms_doc_info, meta_fld) {

comm_doc_info <- list(YYYYMMDD              = as.character(ws_dat$startdate),
                      workshop              = ws_dat$title,
                      location              = ws_dat$address,
                      venue                 = ws_dat$venue,
                      time                  = paste(ws_dat$starttime, "-", ws_dat$endtime, as.character(strftime(ws_dat$startdate, format="%Z"))),
                      date                  = paste0(strftime(ws_dat$startdate, format="%a %b %d"), " - ", strftime(ws_dat$enddate, format="%a %b %d")),
                      workshop_website      = paste0("[workshop website](","https://esciencecenter-digital-skills.github.io/", ws_dat$slug, ")"),
                      workshop_website_url  = paste0("https://esciencecenter-digital-skills.github.io/", ws_dat$slug),
                      month                 = strftime(ws_dat$startdate, format="%B"),
                      day_of_workshop       = strftime(ws_dat$startdate, format="%A, %b %d"),
                      start_time            = as.character(strftime(strptime(ws_dat$starttime, format = "%H:%M") -
                                                                as.difftime(15, units="mins"), format="%H:%M")), #encourage 15 minutes before start showup.
                      registration_page     = paste0("[registration page](","https://www.eventbrite.co.uk/e/", ws_dat$eventbrite, ")"),
                      setup_instructions    = paste0("[setup instructions](","https://esciencecenter-digital-skills.github.io/", ws_dat$slug, "/#setup" ,")"),
                      description           = getURL(paste0(meta_fld, "description.md"), .encoding = "UTF-8"),
                      who                   = getURL(paste0(meta_fld, "who.md"), .encoding = "UTF-8"),
                      syllabus              = getURL(paste0(meta_fld, "syllabus.md"), .encoding = "UTF-8"),
                      synopsis              = getURL(paste0(meta_fld, "synopsis.md"), .encoding = "UTF-8"),
                      advertisement         = getURL(paste0(meta_fld, "advertisement.md"),.encoding = "UTF-8"),
                      setup                 = getURL(paste0(meta_fld, "setup.md"), .encoding = "UTF-8"),
                      lesson_url_ref        = paste0("[here](", getURL(paste0(meta_fld, "lesson-url.md"), .encoding = "UTF-8"), ")"),
                      lesson_url            = getURL(paste0(meta_fld, "lesson-url.md"), .encoding = "UTF-8"),
                      set_title             = paste(ws_dat$slug, "communication document"),
                      repo                  = paste0("https://github.com/esciencecenter-digital-skills/", ws_dat$slug),
                      repo_ref              = paste0("[workshop repository](","https://github.com/esciencecenter-digital-skills/", ws_dat$slug, "/files" ,")"),
                      show_text             = TRUE)

if (str_detect(ws_dat$address, "online")) {
  comm_doc_template = "files/communication_doc_online.Rmd"}
else {
  warning(paste0(ws_dat$slug, ": address field is not set to *online*, assuming in-person workshop"))
  comm_doc_template = "files/communication_doc_irl.Rmd"
}

render_comm = function(comm_doc_info) {
  render(
    comm_doc_template,
    params = comm_doc_info,
    output_file = paste0(ws_dat$slug, '/', ws_dat$slug, "-communication_doc.docx")
  )
}

render_comm(comm_doc_info)
}
