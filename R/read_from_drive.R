#' Read a file from the SharePoint drive into R
#'
#' This function combines the `Microsoft365R::get_sharepoint_site()` function
#' and the `rio::import()`` functions to connect to a sharepoint drive
#' and download a file, then open it in R. Because it uses `rio::import()`,
#' the function is able to open a large number of different filetypes.
#'
#' The defaults are set to open the main excel sheet for the eScience Center
#' digital skills workshops (a.k.a. the "Holy Excel Sheet").
#'
#' @param path Path of the file inside the sharepoint drive
#' @param drive URL of the sharepoint drive
#'
#' @return an imported R object
#' @export
read_from_drive <- function(path = "General/Digital Skills Workshops 2022.xlsx",
                            drive = "https://nlesc.sharepoint.com/sites/instructors"){

  rlang::check_installed("Microsoft365R")
  require(Microsoft365R)

  #TODO validate path and drive arguments
  # e.g. path needs to have an extension
  # drive needs to be sharepoint site and include https://

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


connect_drive <- function(url="https://nlesc.sharepoint.com/sites/instructors"){
  instr_site <- Microsoft365R::get_sharepoint_site(site_url=url)
  drv        <- instr_site$get_drive()
  return(drv)
}
