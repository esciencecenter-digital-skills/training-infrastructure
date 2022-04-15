#' Get meta folder
#'
#' Take the slug and return the corresponding URL where the meta files live for the workshop in question
#'
#' @param slug workshop slug
#'
#' @return a variable meta_fld that has the URL to the meta folder in it
#'
#' @importFrom stringr str_detect
#' @export
#'
get_meta_fld <- function(slug) {
  parallel_python_meta  <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-parallel/"
  containers_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-docker/"
  rpackaging_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-rpackaging/"
  gpu_meta              <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-gpu/"
  dc_python_socsci_meta <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/dc-socsci-python/"
  deep_learning_meta    <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-dl-intro/"
  coderefine_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-cr/" #TODO: implement this
  astronomy_meta        <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/dc-astronomy/"


  # TODO: consider storing this as a table. Slugs in one column, URLs in the other

  if (str_detect(slug, "ds-parallel")) { #TODO: consider using slug == "ds-parallel" and dropping stringi::str_detect dependence
    meta_fld <- parallel_python_meta
  }
  else if (str_detect(slug, "ds-dl-intro")) {
    meta_fld <- deep_learning_meta
  }
  else if (str_detect(slug, "ds-docker")) {
    meta_fld <- containers_meta
  }
  else if (str_detect(slug, "ds-rpackaging")) {
    meta_fld <- rpackaging_meta
  }
  else if (str_detect(slug, "ds-gpu")) {
    meta_fld <- gpu_meta
  }
  else if (str_detect(slug, "ds-cr")) {
    meta_fld <- coderefine_meta
  }
  else if (str_detect(slug, "dc-socsci-python")) {
    meta_fld <- dc_python_socsci_meta
  }
  else if (str_detect(slug, "dc-astronomy")) {
    meta_fld <- astronomy_meta
  }
  else {
    errMsg <- sprintf("The slug %s is not linked to any URL. Perhaps you mispelled it?", slug)
    stop(errMsg)
  }

  return(meta_fld)

}
