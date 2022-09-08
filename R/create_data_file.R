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
create_data_file <- function(dat_struct) {

  data_file <- dat_struct %>%
    dplyr::select(venue, address, country, latitude, longitude,
           humandate, humantime,
           startdate, enddate,
           instructor, helper,
           carpentry, curriculum, title, slug, flavor)

  for (i in 1:length(viable_slugs)) { # for each viable slug, create a file called data.csv, within the folder it belongs.
    csv_info <- data_file[i,]
    filename <- paste0("/files/", viable_slugs[i], "/data.csv")
    readr::write_csv(csv_info, filename)
  }

}
