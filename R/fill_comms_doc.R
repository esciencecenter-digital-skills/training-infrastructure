#' fill comms doc
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

comm_doc_info <- list(YYYYMMDD              = as.character(comms_doc_info$startdate),
                      workshop              = getURL(paste0(meta_fld, "title.md"), .encoding = "UTF-8"),
                      location              = comms_doc_info$address,
                      venue                 = comms_doc_info$venue,
                      time                  = paste(comms_doc_info$starttime, "-", comms_doc_info$endtime, as.character(strftime(comms_doc_info$startdate, format="%Z"))),
                      date                  = paste0(strftime(comms_doc_info$startdate, format="%A, %e %b"), " - ", strftime(comms_doc_info$enddate, format=" %A, %e %b")),
                      workshop_website      = paste0("[workshop website](","https://esciencecenter-digital-skills.github.io/", comms_doc_info$slug, ")"),
                      workshop_website_url  = paste0("https://esciencecenter-digital-skills.github.io/", comms_doc_info$slug),
                      month                 = strftime(comms_doc_info$startdate, format="%B"),
                      day_of_workshop       = strftime(comms_doc_info$startdate, format="%A, %e %b"),
                      start_time            = as.character(strftime(strptime(comms_doc_info$starttime, format = "%H:%M") -
                                                                as.difftime(15, units="mins"), format="%H:%M")), #encourage 15 minutes before start showup.
                      registration_page     = paste0("[registration page](","https://www.eventbrite.co.uk/e/", comms_doc_info$eventbrite, ")"),
                      setup_instructions    = paste0("[setup instructions](","https://esciencecenter-digital-skills.github.io/", comms_doc_info$slug, "/#setup" ,")"),
                      description           = getURL(paste0(meta_fld, "description.md"), .encoding = "UTF-8"),
                      who                   = getURL(paste0(meta_fld, "who.md"), .encoding = "UTF-8"),
                      syllabus              = getURL(paste0(meta_fld, "syllabus.md"), .encoding = "UTF-8"),
                      synopsis              = getURL(paste0(meta_fld, "synopsis.md"), .encoding = "UTF-8"),
                      advertisement         = getURL(paste0(meta_fld, "advertisement.md"),.encoding = "UTF-8"),
                      setup                 = getURL(paste0(meta_fld, "setup.md"), .encoding = "UTF-8"),
                      lesson_url_ref        = paste0("[here](", getURL(paste0(meta_fld, "lesson-url.md"), .encoding = "UTF-8"), ")"),
                      lesson_url            = getURL(paste0(meta_fld, "lesson-url.md"), .encoding = "UTF-8"),
                      set_title             = paste(comms_doc_info$slug, "communication document"),
                      repo                  = paste0("https://github.com/esciencecenter-digital-skills/", comms_doc_info$slug),
                      repo_ref              = paste0("[workshop repository](","https://github.com/esciencecenter-digital-skills/", comms_doc_info$slug, "/files" ,")"),
                      show_text             = TRUE)

if (str_detect(comms_doc_info$address, "online")) {
  comm_doc_template = "files/communication_doc_online.Rmd"}
else {
  warning(paste0(comms_doc_info$slug, ": address field is not set to *online*, assuming in-person workshop"))
  comm_doc_template = "files/communication_doc_irl.Rmd"
}

render_comm = function(comm_doc_info) {
  render(
    comm_doc_template,
    params = comm_doc_info,
    output_file = paste0(comms_doc_info$slug, '/', comms_doc_info$slug, "-communication_doc.docx")
  )
}

render_comm(comm_doc_info)
}
