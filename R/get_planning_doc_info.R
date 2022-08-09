#' Get information for planning document
#'
#' Get specific information for a single workshop, represented as one line in the processed Holy Excel Sheet.
#' This represents information about one workshop. The information that is returned in a format that
#' can be input to is to set up the planning document with `render_planning_doc.R`.
#'
#' @param info named vector with information about the workshop to be inserted into the different documents
#' should include: slug, startdate, newch, eventbrite, lead_instructor, instructor, helper
#'
#' @return planning doc information to be used in rendering the doc
#'
#' @export
#'
get_planning_doc_info <- function(info) {

  plan_doc_info <- list(
    slug = info$slug,
    YYYYMMDD = as.character(info$startdate),
    sharepoint = paste0("[Sharepoint](", info$newch, ")"),
    workshop_website = paste0(
      "[workshop website](",
      "https://esciencecenter-digital-skills.github.io/",
      info$slug,
      ")"
    ),
    registration_page = paste0(
      "[registration page](",
      "https://www.eventbrite.co.uk/e/",
      info$eventbrite,
      ")"
    ),
    set_title = paste(info$slug, "planning document"),
    lead_instructor = info$lead_instructor,
    instructor = info$instructor,
    helper = info$helper,
    show_text = TRUE
  )
  return(plan_doc_info)
  }
