#' Get planning doc info
#'
#' Get specific information for a workshop needed to set up the planning document.
#'
#' @param ws_dat workshop data: information read from Holy Excel sheet: dataframe with
#' information about the workshop - used to set up the planning document
#'
#' @return planning doc information to be used in rendering the doc
#'
#' @export
#'
get_plan_doc_info <- function(ws_dat) {

  plan_doc_info <- list(
    YYYYMMDD = as.character(info$startdate),
    sharepoint = paste0("[Sharepoint](", info$newch, ")"),
    workshop_website = paste0(
      "[workshop website](",
      "https://esciencecenter-digital-skills.github.io/",
      slug,
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
