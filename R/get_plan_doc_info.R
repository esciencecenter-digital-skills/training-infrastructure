#' Get planning doc info
#'
#' Get the specific information for the upcoming workshop so it can be used in the planning doc
#'
#' @param ws_dat information about the workshop to be inserted into the planning document
#' @param meta_fld the URL of the meta folder
#'
#' @return planning doc information to be used in rendering the doc
#'
#' @export
#'
get_plan_doc_info <- function(ws_dat, meta_fld) {

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
  return(plan_doc_info)
  }
