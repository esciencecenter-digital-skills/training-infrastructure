#' Get meta folder
#'
#' Take the slug and return the corresponding URL where the meta files live for
#' the workshop in question.
#'
#' @param slug workshop slug
#'
#' @return url to the folder containing workshop metadata
get_meta_url <- function(slug) {
  # delete date from the slug
  slug <- stringr::str_remove(slug, "^\\d{4}-\\d{2}-\\d{2}-")

  # some metadata URLs that are different from their slug
  if(slug == "ds-geospatial"){
    slug <- "ds-geospatial-python"
  }
  if(slug == "dc-astronomy-python"){
    slug <- "dc-astronomy"
  }

  ghraw <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/"
  meta_url <- paste0(ghraw,slug,"/")

  # check if the URL exists by pinging the Title page
  title <- paste0(meta_url, "title.md")
  if(!RCurl::url.exists(title)){
    stop(paste("The slug", slug, "is not linked to any URL. Perhaps you misspelled it?"))
  }

  return(meta_url)

}
