get_future_workshops <- function(excelfile) {
  #' Take information from the master spreadsheet with all future workshops, and extract the relevant information for GitHub pages
  #' Input: 
  #'         excelfile: a df created based on the digital skills programme excel file
  #'         ppt_info: a df with id, event_id, order_id, ticket_class_name, created, name, email
  #'         
  #' Ouput:
  #'         A dataframe with simplified answer column names and answers for each ppt
  
  dat_struct <- excelfile %>% #read in excel file above
    drop_na(title) %>% 
    select(startdate, enddate, starttime, endtime, title, slug,
           lead_instructor, supporting_instructor1, supporting_instructor2,
           helper1, helper2, helper3,
           carpentry, curriculum, flavor, host,
           venue, address, country,
           eventbrite, repository) %>% 
    mutate(startdate = as.POSIXlt(startdate, tz="Europe/Amsterdam", format="%Y-%m-%d"), #convert to our timezone so CET or CEST is displayed in humandate
           enddate = as.POSIXlt(enddate, tz="Europe/Amsterdam",format="%Y-%m-%d"), 
           humandate = ifelse(months(dat_struct$startdate)==months(dat_struct$enddate), #this includes the month for end date only when workshop go over month switch
                              paste0(format(startdate, format="%B %d -"), 
                                     format(enddate, format=" %d, %Y, %Z")), 
                              paste0(format(startdate, format="%B %d -"), 
                                     format(enddate, format=" %B %d, %Y, %Z"))),
           humantime = paste0(starttime, " - ", endtime),
           instructor = paste(lead_instructor, supporting_instructor1, supporting_instructor2, sep = ", "),
           instructor = gsub(", NA", "", instructor),
           helper = paste(helper1, helper2, helper3, sep=", "),
           helper = gsub(", NA", "", helper),
           latitude = ifelse(address=="online",NA, osm_search(address, key=token)$lat),
           longitude = ifelse(address=="online",NA, osm_search(address, key=token)$lon)
    )
  return(dat_struct)
}