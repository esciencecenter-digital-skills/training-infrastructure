#' Get future workshops
#'
#' Take information from the master spreadsheet with all future workshops, and generate the relevant information for GitHub pages.
#' This function checks whether necessary columns are present, and generates formatted columns that can be used
#' as input for websites and other communication material. It also drops empty lines.
#'
#' @param df A dataframe based on the digital skills programme excel file
#' @param future A string formatted as "YYYY-MM-DD", or "today", or "none". Only workshops after this date will be returned.
#'
#' @return a checked and formatted dataframe
#'
#' @export
get_future_workshops <- function(df, future = "today") {
  #TODO verify input for future parameter

  # verify that data contains the correct columns
  columns_needed <- c("startdate", "enddate", "starttime", "endtime",
                      "title", "slug",
                      "lead_instructor", "supporting_instructor1", "supporting_instructor2",
                      "helper1", "helper2", "helper3",
                      "carpentry", "curriculum", "flavor", "host",
                      "venue", "address", "country", "repository", "ready")

  for(c in columns_needed){
    if(!c %in% names(df)){
      e <- paste("Column", c, "is not present in the data.\
                 Please verify whether the data is complete, and column names are correct.")
      stop(e)
    }
  }

  df <- tidyr::drop_na(df, title)
  df <- df[columns_needed]

  # define dates and times in human readable formats
  df <- dplyr::mutate(df,
                      startdate = convert_to_date(startdate),
                      enddate = convert_to_date(enddate),
                      humandate = human_date(startdate,enddate),
                      humantime = human_time(starttime,endtime,enddate)
  )

  # only pick future workshops, if requested
  if(future != "none"){
    # the following is hacky. I do not know why this is necessary, but it works.
    if(future == "today"){
      date <- as.character(lubridate::today(tzone="Europe/Amsterdam"))
      date <- convert_to_date(date)
    } else{
      date <- convert_to_date(future)
    }
    df <- dplyr::filter(df, startdate >= date)
  }

  # format helpers and instructors
  df <- dplyr::mutate(df,
                      instructor = list_people(lead_instructor, supporting_instructor1, supporting_instructor2),
                      helper = list_people(helper1, helper2, helper3)
  )

  # make a global address dictionary to prevent extra nominatim calls
  address_dict <<- data.frame(address = "", lat = "", lon = "")

  # add latitude/longitude
  latlon <- sapply(df$address, retrieve_latlon)
  latlon <- data.frame(do.call("rbind", latlon))
  names(latlon) <- c("lat", "lon")
  df$latitude <- latlon$lat
  df$longitude <- latlon$lon

  rm(address_dict, envir = .GlobalEnv)

  return(df)
}

convert_to_date <- function(date){
  lubridate::ymd(date, tz="Europe/Amsterdam")
}

human_date <- function(startdate,enddate){
  ifelse(months(startdate)==months(enddate), #this includes the month for end date only when workshop go over month switch
         paste0(format(startdate, format="%B %d -"),
                format(enddate, format=" %d, %Y")),
         paste0(format(startdate, format="%B %d -"),
                format(enddate, format=" %B %d, %Y")))
}

human_time <- function(starttime, endtime, enddate){
  paste0(starttime, " - ", endtime, format(enddate, format=" %Z"))
}

list_people <- function(p1,p2,p3){
  listed_people <- paste(p1,p2,p3, sep = ", ")
  listed_people <- gsub(", NA", "", listed_people)
  gsub("NA", "", listed_people)
}

retrieve_latlon <- function(address){
  if(address == "online"){
    return(NA)
  }
  if(address %in% address_dict$address){ # check the global dictionary, this saves time!
    return(address_dict[address_dict$address == address,c("lat","lon")])
  }
  address_loc <- nominatimlite::geo_lite(address)
  # add the address to the global dictionary so info can be reused
  address_dict <<- rbind(address_dict, c(address, c(address_loc$lat, address_loc$lon)))
  return(c(address_loc$lat, address_loc$lon))
}
