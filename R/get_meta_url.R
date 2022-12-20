#' Get meta folder
#'
#' Take the workshop info and return the corresponding URL where the meta files
#' live for the workshop in question.
#'
#' @param info workshop information named vector
#'
#' @return url to the folder containing workshop metadata
get_meta_url <- function(info) {

  slug <- info$curriculum
  meta_url <- check_slug(slug)

  if(class(meta_url) == "character"){
    return(meta_url)
  }

  slug <- make_slug_option1(info)
  meta_url <- check_slug(slug)

  if(class(meta_url) == "character"){
    return(meta_url)
  }

  slug <- make_slug_option2(info)
  meta_url <- check_slug(slug)

  if(class(meta_url) == "character"){
    return(meta_url)
  }

  slug <- make_slug_option3(info)
  meta_url <- check_slug(slug)

  if(class(meta_url) == "character"){
    return(meta_url)
  }

  stop(paste("The information for workshop", info$slug, "is not linked to any meta URL."))
}

make_slug_option1 <- function(info){
  slug <- paste(info$curriculum, info$flavor, sep = "-")
  return(slug)
}

make_slug_option2 <- function(info){
  slug <- stringr::str_remove(info$slug, "^\\d{4}-\\d{2}-\\d{2}-")
  return(slug)
}

make_slug_option3 <- function(info){
  # this should not be necessary!
  # the flavor argument 'python' is added, because the holyexcel did not include it
  slug <- paste(info$curriculum, "python", sep = "-")
  return(slug)
}



check_slug <- function(slug){
  ghraw <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/"
  meta_url <- paste0(ghraw,slug,"/")
  title <- paste0(meta_url, "title.md")
  if(!RCurl::url.exists(title)){
    return(FALSE)
  } else{
    return(meta_url)
  }
}
