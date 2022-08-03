read_from_drive <- function(path = "General/Digital Skills Workshops 2022.xlsx",
                            drive = "https://nlesc.sharepoint.com/sites/instructors"){
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


### Connect to Instructors drive
connect_drive <- function(url="https://nlesc.sharepoint.com/sites/instructors"){
  instr_site <- Microsoft365R::get_sharepoint_site(site_url=url)
  drv        <- instr_site$get_drive()
  return(drv)
}
