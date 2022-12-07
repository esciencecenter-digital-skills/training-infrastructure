#' Get meta folder
#'
#' Take the slug and return the corresponding URL where the meta files live for
#' the workshop in question.
#'
#' @param slug workshop slug
#'
#' @return url to the folder containing workshop metadata
get_meta_url <- function(slug) {
  # only metadata URL that is different from its slug
  if(slug == "dc-geospatial"){
    slug <- "dc-geospatial-python"
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
