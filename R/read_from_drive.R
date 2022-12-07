#' Read a file from the SharePoint drive into R
#'
#' This function opens the main excel sheet for the eScience Center
#' digital skills workshops (a.k.a. the "Holy Excel Sheet").
#' In the 'year' argument, indicate the year for which the file should be read.
#' If the file path no longer matches, e.g.,
#' `General/Digital Skills Workshops 2023.xlsx`, please fix this information in
#' the csv file in `inst/extdata/rawinfo.csv`.
#'
#'
#' @param year The year for which the Holy Excel Sheet will be read
#' @param drive name of the NLeSC sharepoint drive (default is 'instructors')
#'
#' @return an imported R object
#' @export
read_from_drive <- function(year = "2023",
                            drive = "instructors"){

  path <- look_up_info(item = "holyexcel", id = year)

  # connect to drive
  drv <- connect_drive(drive)

  # setup temporary directory
  tempdir <- paste0("temp", Sys.time())
  tempdir <- stringr::str_replace_all(tempdir,"[:punct:]|[:blank:]","")
  dir.create(tempdir)

  # download and open excel sheet
  extension <- stringr::str_match(path, "\\..{1,}$")[1]
  tempname <- paste0(tempdir,"/file", extension)

  drv$download_file(src = path,
                    dest = tempname)
  imported <- rio::import(tempname)

  # delete temporary directory and contents
  unlink(tempdir,recursive=T)

  return(imported)
}


connect_drive <- function(drive="instructors"){
  url <- paste0("https://nlesc.sharepoint.com/sites/", drive)
  instr_site <- Microsoft365R::get_sharepoint_site(site_url=url)
  drv        <- instr_site$get_drive()
  return(drv)
}

look_up_info <- function(item, id){
  rawinfo <- system.file("extdata", "rawinfo.csv", package = "traininginfrastructure")
  rawinfo <- utils::read.csv(rawinfo)
  information <- rawinfo[rawinfo$item == item & rawinfo$id == id,"information"]
  return(information)
}
