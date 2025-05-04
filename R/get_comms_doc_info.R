#' Get information for communications document
#'
#' Get specific information for a single workshop, represented as one line in the processed Holy Excel Sheet.
#' This represents information about one workshop. The information that is returned is needed
#' to set up the communication document, and is taken from the meta folder.
#'
#' @param info named vector with information about the workshop to be inserted into the different documents
#' should include: startdate, enddate, title, address, venue, starttime, endtime, slug.
#'
#' @return a list of workshop information, formatted correctly so that the communication document will render properly
#'
#' @export
#'
get_comms_doc_info <- function(info) {
  check_location_setting()

  meta_url <- get_meta_url(info)

  comm_doc_info <- list(YYYYMMDD              = as.character(info$startdate),
                        slug                  = info$slug,
                        workshop              = RCurl::getURL(paste0(meta_url, "title.md"), .encoding = "UTF-8"),
                        location              = info$address,
                        venue                 = info$venue,
                        time                  = paste(info$starttime, "-", info$endtime, as.character(strftime(info$startdate, format="%Z"))),
                        date                  = paste0(strftime(info$startdate, format="%A, %e %b"), " - ", strftime(info$enddate, format=" %A, %e %b")),
                        workshop_website      = paste0("[workshop website](","https://esciencecenter-digital-skills.github.io/", info$slug, ")"),
                        workshop_website_url  = paste0("https://esciencecenter-digital-skills.github.io/", info$slug),
                        month                 = strftime(info$startdate, format="%B"),
                        day_of_workshop       = strftime(info$startdate, format="%A, %e %b"),
                        start_time            = as.character(strftime(strptime(info$starttime, format = "%H:%M") -
                                                                        as.difftime(15, units="mins"), format="%H:%M")), #encourage 15 minutes before start showup.
                        registration_page     = paste0("[registration page](","https://www.eventbrite.co.uk/e/", info$eventbrite, ")"),
                        setup_instructions    = paste0("[setup instructions](","https://esciencecenter-digital-skills.github.io/", info$slug, "/#setup" ,")"),
                        description           = RCurl::getURL(paste0(meta_url, "description.md"), .encoding = "UTF-8"),
                        who                   = RCurl::getURL(paste0(meta_url, "who.md"), .encoding = "UTF-8"),
                        syllabus              = RCurl::getURL(paste0(meta_url, "syllabus.md"), .encoding = "UTF-8"),
                        synopsis              = RCurl::getURL(paste0(meta_url, "synopsis.md"), .encoding = "UTF-8"),
                        advertisement         = RCurl::getURL(paste0(meta_url, "advertisement.md"),.encoding = "UTF-8"),
                        setup                 = RCurl::getURL(paste0(meta_url, "setup.md"), .encoding = "UTF-8"),
                        lesson_url_ref        = paste0("[here](", RCurl::getURL(paste0(meta_url, "lesson-url.md"), .encoding = "UTF-8"), ")"),
                        lesson_url            = RCurl::getURL(paste0(meta_url, "lesson-url.md"), .encoding = "UTF-8"),
                        set_title             = paste(info$slug, "communication document"),
                        normal_price          = as.numeric(info$normal_price),
                        industry_price        = as.numeric(info$industry_price),
                        repo                  = paste0("https://github.com/esciencecenter-digital-skills/", info$slug),
                        repo_ref              = paste0("[workshop repository](","https://github.com/esciencecenter-digital-skills/", info$slug, "/files" ,")"),
                        show_text             = TRUE)
  return(comm_doc_info)
}

check_location_setting <- function(){
  location <- Sys.getlocale()
  #grepl("en", location)
  #"en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8"
}
