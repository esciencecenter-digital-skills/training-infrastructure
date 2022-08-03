#' Fill debriefing doc
#'
#' Take the template Rmd debriefing doc and save it as a docx with specific information for the
#' upcoming workshop
#'
#' @param ws_dat information about the workshop to be inserted into the debriefing doc
#' @param meta_fld the URL of the meta folder
#'
#' @return no output, just saving files within the project directory
#'
#' @importFrom RCurl getURL
#' @importFrom rmarkdown render
#' @export
#'
