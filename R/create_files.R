#' Create files
#'
#' Take the template Rmd documents and save them with specific information
#' for the upcoming workshop. Write the workshop info to a data.csv file.
#'
#' @param info named vector with workshop information
#' @param folder location where files should be stored
#' @export
create_files <- function(info, folder = "."){
  verify_info(info)
  verify_folder(folder)

  comms_doc_info <- get_comms_doc_info(info)
  render_doc(comms_doc_info, "communication", folder)

  planning_doc_info <- get_planning_doc_info(info)
  render_doc(planning_doc_info, "planning", folder)

  debrief_doc_info <- get_debrief_doc_info(info)
  render_doc(debrief_doc_info, "debriefing", folder)

  create_data_file(info, folder)
}


render_doc <- function(info, type, folder){
  doc_types <- c("planning", "communication", "debriefing")
  if(!type %in% doc_types){
    stop("Wrong `type`: only `planning`, `communication` and `debriefing` docs can be rendered.")
  }

  template_type <- type

  # communication doc checks
  if(type == "communication"){
    if (stringr::str_detect(info$location, "online")) {
      message("Address field is set to `online`, assuming virtual workshop.")
      template_type = "communication_online"}
    else {
      message("Address field is not set to `online`, assuming in-person workshop.")
      template_type = "communication_irl"
    }
  }

  # define names
  slug <- info$slug
  template_name <- paste0(template_type, "_doc.Rmd")
  template <- system.file("extdata", template_name, package = "traininginfrastructure")
  doc_name <- paste0(slug, "_", type, "_doc.docx")
  html_name <- paste0(slug, "_", type, "_doc.html")

  message(paste("Generating",type,"document(s) for", slug))
  rmarkdown::render(
    input = template,
    params = info,
    output_format = "word_document",
    output_file = doc_name,
    output_dir = folder,
    quiet = TRUE)

  if(type == "communication"){ # communication also requires a HTML
    rmarkdown::render(
      input = template,
      params = info,
      output_format = "html_document",
      output_file = html_name,
      output_dir = folder,
      quiet = TRUE)
  }

}


create_data_file <- function(info, folder) {
  data_file <- dplyr::select(.data = info,
                             venue, address, country, latitude, longitude,
                             humandate, humantime,startdate, enddate,
                             instructor, helper, carpentry, curriculum, title,
                             slug, flavor)

  filename <- paste0(folder, "/data.csv")
  readr::write_csv(data_file, filename)
}
