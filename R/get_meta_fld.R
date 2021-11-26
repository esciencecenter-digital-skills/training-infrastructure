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
  parallel_python_meta  <- "https://raw.githubusercontent.com/carpentries-incubator/lesson-parallel-python/gh-pages/_meta/"
  containers_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/docker-introduction/gh-pages/_meta/"
  rpackaging_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/lesson-R-packaging/gh-pages/_meta/"
  gpu_meta              <- "https://raw.githubusercontent.com/carpentries-incubator/lesson-gpu-programming/gh-pages/_meta/"
  dc_python_socsci_meta <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/carpentries_metadata/main/dc-socsci-python/"
  deep_learning_meta    <- "https://raw.githubusercontent.com/carpentries-incubator/deep-learning-intro/gh-pages/_meta/" #TODO: implement this
  # TODO: consider storing this as a table. Slugs in one column, URLs in the other

  if (str_detect(slug, "ds-parallel")) {
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
  else if (str_detect(slug, "dc-socsci-python")) {
    meta_fld <- dc_python_socsci_meta
  }

  return(meta_fld)


}
