#' Get future workshops
#'
#' Take information from the master spreadsheet with all future workshops, and generate the relevant information for GitHub pages.
#' This function checks whether necessary columns are present, and generates formatted columns that can be used
#' as input for websites and other communication material. It also drops empty lines.
#'
#' @param df A dataframe based on the digital skills programme excel file
#' @param future A boolean (True/False) that indicates whether only future workshops should be returned
#'
#' @return a checked and formatted dataframe
#'
#' @export
get_future_workshops <- function(df, future = T) {
  # verify that data contains the correct columns
  columns_needed <- c("startdate", "enddate", "starttime", "endtime",
                      "title", "slug",
                      "lead_instructor", "supporting_instructor1", "supporting_instructor2",
                      "helper1", "helper2", "helper3",
                      "carpentry", "curriculum", "flavor", "host",
                      "venue", "address", "country",
                      "eventbrite", "repository", "ready")

  for(c in columns_needed){
    if(!c %in% names(df)){
      e <- paste("Column", c, "is not present in the data.\
                 Please verify whether the data is complete, and column names are correct.")
      stop(e)
    }
  }

  df <- tidyr::drop_na(df, title)
  df <- df[columns_needed]
  # only pick future workshops, if requested
  if(future){df[convert_to_date(df$startdate) >= Sys.time(), ]}

  # define dates and times in human readable formats
  df <- dplyr::mutate(df,
                      humandate = human_date(startdate,enddate),
                      humantime = human_time(starttime,endtime,enddate)
  )

  # format helpers and instructors
  df <- dplyr::mutate(df,
                      instructor = list_people(lead_instructor, supporting_instructor1, supporting_instructor2),
                      helper = list_people(helper1, helper2, helper3)
  )
  return(df)
}


convert_to_date <- function(date){
  as.POSIXlt(date, tz="Europe/Amsterdam", format="%Y-%m-%d")
}

human_date <- function(startdate,enddate){
  startdate <- convert_to_date(startdate)
  enddate <- convert_to_date(enddate)
  ifelse(months(startdate)==months(enddate), #this includes the month for end date only when workshop go over month switch
         paste0(format(startdate, format="%B %d -"),
                format(enddate, format=" %d, %Y")),
         paste0(format(startdate, format="%B %d -"),
                format(enddate, format=" %B %d, %Y")))
}

human_time <- function(starttime, endtime, enddate){
  enddate <- convert_to_date(enddate)
  if(is.na(enddate)){return(NA)}
  paste0(starttime, " - ", endtime, format(enddate, format=" %Z"))
}

list_people <- function(p1,p2,p3){
  listed_people <- paste(p1,p2,p3, sep = ", ")
  listed_people <- gsub(", NA", "", listed_people)
  gsub("NA", "", listed_people)
}
