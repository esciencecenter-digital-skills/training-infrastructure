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
  
  
  if (str_detect(slug, "ds-parallel")==T) {
    meta_fld <- parallel_python_meta
  }
  else if (str_detect(slug, "ds-dl-intro")==T) {
    meta_fld <- deep_learning_meta
  }
  else if (str_detect(slug, "ds-docker")==T) {
    meta_fld <- containers_meta
  }
  else if (str_detect(slug, "ds-rpackaging")==T) {
    meta_fld <- rpackaging_meta
  }
  else if (str_detect(slug, "ds-gpu")==T) {
    meta_fld <- gpu_meta
  }
  else if (str_detect(slug, "dc-socsci-python")==T) {
    meta_fld <- dc_python_socsci_meta
  }
  
  return(meta_fld)
  
  
}