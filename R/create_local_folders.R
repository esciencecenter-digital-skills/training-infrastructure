
#' Create local folders
#' create folders inside a local folder called "files", folder names are future workshop slugs.
#'
#' @param dat_struct a dataframe created based on the digital skills programme excel file
#'
#' @export
#'
create_local_folders <- function(dat_struct) {

  dir.create('/files/')
  viable_slugs  <- dat_struct[!is.na(dat_struct$slug), ]
  viable_slugs <- viable_slugs$slug #only bother with slugs longer than 10 characters
  workshop_dirs <- file.path(paste0('/files/', viable_slugs)) # create filepath from current directory + slug
  sapply(workshop_dirs, dir.create) # create those directories

}
