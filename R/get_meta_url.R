#' Get meta folder
#'
#' Take the slug and return the corresponding URL where the meta files live for the workshop in question
#'
#' @param slug workshop slug
#'
#' @return url to the folder containing workshop metadata
#'
#'
get_meta_url <- function(slug) {
  parallel_python_meta  <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-parallel/"
  containers_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-docker/"
  rpackaging_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-rpackaging/"
  gpu_meta              <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-gpu/"
  dc_python_socsci_meta <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/dc-socsci-python/"
  deep_learning_meta    <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-dl-intro/"
  coderefine_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-cr/" #TODO: implement this
  astronomy_meta        <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/dc-astronomy/"
  geospatial_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/dc-geospatial-python/"


  # TODO: consider storing this as a table. Slugs in one column, URLs in the other

  if (stringr::str_detect(slug, "ds-parallel")) { #TODO: consider using slug == "ds-parallel" and dropping stringi::str_detect dependence
    meta_url <- parallel_python_meta
  }
  else if (stringr::str_detect(slug, "ds-dl-intro")) {
    meta_url <- deep_learning_meta
  }
  else if (stringr::str_detect(slug, "ds-docker")) {
    meta_url <- containers_meta
  }
  else if (stringr::str_detect(slug, "ds-rpackaging")) {
    meta_url <- rpackaging_meta
  }
  else if (stringr::str_detect(slug, "ds-gpu")) {
    meta_url <- gpu_meta
  }
  else if (stringr::str_detect(slug, "ds-cr")) {
    meta_url <- coderefine_meta
  }
  else if (stringr::str_detect(slug, "dc-socsci-python")) {
    meta_url <- dc_python_socsci_meta
  }
  else if (stringr::str_detect(slug, "dc-astronomy")) {
    meta_url <- astronomy_meta
  }
  else if (stringr::str_detect(slug, "dc-geospatial")) {
    meta_url <- geospatial_meta
  }
  else {
    errMsg <- sprintf("The slug %s is not linked to any URL. Perhaps you mispelled it?", slug)
    stop(errMsg)
  }

  return(meta_url)

}
