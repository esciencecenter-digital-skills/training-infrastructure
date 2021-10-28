#' Take the slug and return the corresponding URL where the meta files live for the workshop in question
#' Input: 
#'         slug: workshop slug
#'         
#' Ouput:
#'         a variable meta_fld that has the URL to the meta folder in it 

get_meta_fld <- function(slug) {
  
  parallel_python_meta  <- "https://raw.githubusercontent.com/carpentries-incubator/lesson-parallel-python/gh-pages/_meta/"
  deep_learning_meta    <- "https://raw.githubusercontent.com/carpentries-incubator/deep-learning-intro/gh-pages/_meta/"
  containers_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/docker-introduction/gh-pages/_meta/"
  rpackaging_meta       <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/lesson-R-packaging/gh-pages/_meta/"
  gpu_meta              <- "https://raw.githubusercontent.com/carpentries-incubator/lesson-gpu-programming/gh-pages/_meta/"
  dc_python_socsci_meta <- "https://raw.githubusercontent.com/esciencecenter-digital-skills/carpentries_metadata/main/dc-socsci-python/"
  
  description   <- getURL(paste0(meta_fld, "description.md"), .encoding = "UTF-8")
  who           <- getURL(paste0(meta_fld, "who.md"), .encoding = "UTF-8")
  syllabus      <- getURL(paste0(meta_fld, "syllabus.md"), .encoding = "UTF-8")
  synopsis      <- getURL(paste0(meta_fld, "synopsis.md"), .encoding = "UTF-8")
  advertisement <- getURL(paste0(meta_fld, "advertisement.md"),.encoding = "UTF-8")
  
  
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