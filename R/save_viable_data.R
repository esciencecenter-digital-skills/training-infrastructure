#' Save viable data
#'
#' Take information from the master spreadsheet with all future workshops, and extract the relevant information for GitHub pages
#'
#' @param dat_struct a dataframe created based on the digital skills programme excel file
#'
#' @return data.csv files saved in folders with the slug name
#'
#' @importFrom readr write_csv
#' @importFrom dplyr select
#' @importFrom purrr `%>%`
#' @export
save_viable_data <- function(dat_struct) {

  viable_slugs  <- dat_struct[!is.na(dat_struct$slug), ]
  viable_slugs <- viable_slugs$slug #only bother with slugs longer than 10 characters
  workshop_dirs <- file.path(paste0(exec_dir, '/files'), viable_slugs) # create filepath from current directory + slug
  sapply(workshop_dirs, dir.create) # create those directories

  data_file <- dat_struct %>%
    select(venue, address, country, latitude, longitude,
           humandate, humantime,
           startdate, enddate,
           instructor, helper,
           carpentry, curriculum, title, slug, flavor,
           eventbrite)

  for (i in 1:length(viable_slugs)) { # for each viable slug, create a file called data.csv, within the folder it belongs.
    csv_info <- data_file[i,]
    filename <- paste0(exec_dir,"/files/", viable_slugs[i], "/data.csv")
    write_csv(csv_info, filename)
  }

}
