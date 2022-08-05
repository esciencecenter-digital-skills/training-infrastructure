#' Get future workshops
#'
#' Take information from the master spreadsheet with all future workshops, and extract the relevant information for GitHub pages
#'
#' @param excelfile A dataframe created based on the digital skills programme excel file
#'
#' @return A dataframe that should be saved as data.csv in the workshop folder in SharePoint
#'
#' @importFrom tidyr drop_na
#' @importFrom dplyr mutate select
#' @importFrom nominatim osm_search
#' @importFrom purrr `%>%`
#' @export
#'
get_future_workshops <- function(excelfile) {
  dat_struct <- excelfile %>%
    drop_na(title) %>%
    select(startdate, enddate, starttime, endtime, title, slug,
           lead_instructor, supporting_instructor1, supporting_instructor2,
           helper1, helper2, helper3,
           carpentry, curriculum, flavor, host,
           venue, address, country,
           eventbrite, repository, ready) %>%
    mutate(startdate = as.POSIXlt(startdate, tz="Europe/Amsterdam", format="%Y-%m-%d"), #convert to our timezone so CET or CEST is displayed in humandate
           enddate = as.POSIXlt(enddate, tz="Europe/Amsterdam",format="%Y-%m-%d"),
           humandate = ifelse(months(startdate)==months(enddate), #this includes the month for end date only when workshop go over month switch
                              paste0(format(startdate, format="%B %d -"),
                                     format(enddate, format=" %d, %Y")),
                              paste0(format(startdate, format="%B %d -"),
                                     format(enddate, format=" %B %d, %Y"))),
           humantime = paste0(starttime, " - ", endtime, format(enddate, format=" %Z")),
           instructor = paste(lead_instructor, supporting_instructor1, supporting_instructor2, sep = ", "),
           instructor = gsub(", NA", "", instructor),
           helper = paste(helper1, helper2, helper3, sep=", "),
           helper = gsub(", NA", "", helper),
           latitude = ifelse(address=="online",NA, nominatim::osm_search(address, key=token)$lat), #TODO: pass Open street maps token...
           longitude = ifelse(address=="online",NA, nominatim::osm_search(address, key=token)$lon) #... as a variable
    )
  return(dat_struct)
}
