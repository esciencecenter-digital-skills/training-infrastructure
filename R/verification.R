verify_info_TF <- function(info){
  if(!"data.frame" %in% class(info)){
    return(FALSE)
  }
  if(nrow(info) != 1){
    return(FALSE)
  }
  if(!"slug" %in% names(info)){
    return(FALSE)
  }
  return(TRUE)
}

verify_info <- function(info){
  if(!verify_info_TF(info)){
    stop("Input does not match the required format.")
  }
}

verify_folder <- function(dirname){
  if(!dir.exists(dirname)){
    stop(paste("Folder", dirname,"does not exist."))
  }
}


#' Verify that the dataset has been obtained after `get_future_workshops()`
#'
#' @param df
verify_post_gfw <- function(df){
  if("instructor" %in% names(df) | "longitude" %in% names(df)){
    return(TRUE)
  }
  return(FALSE)
}
