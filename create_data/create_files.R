create_files <- function(ws_dat, meta_fld) {
  #' Take the template word documents and save them with specific information for the upcoming workshop in the corresponding Sharepoint channel
  #' Input: 
  #'         ws_dat: information about the workshop to be inserted into the different documents
  #'         
  #' Ouput:
  #'         no output, just saving files within the project directory. 

  
    
comm_doc_info <- list(YYYYMMDD              = as.character(ws_dat$startdate),
                      workshop              = ws_dat$title,
                      location              = ws_dat$address,
                      venue                 = ws_dat$venue,
                      time                  = paste(ws_dat$starttime, "-", ws_dat$endtime, as.character(strftime(ws_dat$startdate, format="%Z"))),
                      date                  = paste0(strftime(ws_dat$startdate, format="%a %b %d"), " - ", strftime(ws_dat$enddate, format="%a %b %d")), 
                      workshop_website      = paste0("[workshop website](","https://esciencecenter-digital-skills.github.io/", slug, ")"),
                      workshop_website_url  = paste0("https://esciencecenter-digital-skills.github.io/", slug),
                      month                 = strftime(ws_dat$startdate, format="%B"),
                      day_of_workshop       = strftime(ws_dat$startdate, format="%A, %b %d"),
                      start_time            = as.character(strftime(strptime(ws_dat$starttime, format = "%H:%M") - 
                                                                as.difftime(15, units="mins"), format="%H:%M")), #encourage 15 minutes before start showup.   
                      registration_page     = paste0("[registration page](","https://www.eventbrite.co.uk/e/", ws_dat$eventbrite, ")"),
                      setup_instructions    = paste0("[setup instructions](","https://esciencecenter-digital-skills.github.io/", slug, "/#setup" ,")"),
                      registration_page_url = paste0("https://www.eventbrite.co.uk/e/", ws_dat$eventbrite),
                      description           = getURL(paste0(meta_fld, "description.md"), .encoding = "UTF-8"),
                      who                   = getURL(paste0(meta_fld, "who.md"), .encoding = "UTF-8"),
                      syllabus              = getURL(paste0(meta_fld, "syllabus.md"), .encoding = "UTF-8"),
                      synopsis              = getURL(paste0(meta_fld, "synopsis.md"), .encoding = "UTF-8"),
                      advertisement         = getURL(paste0(meta_fld, "advertisement.md"),.encoding = "UTF-8"),
                      set_title             = paste(ws_dat$slug, "communication document"),
                      show_text             = TRUE)

render_comm = function(comm_doc_info) {
  rmarkdown::render("files/communication_doc.Rmd", params = comm_doc_info,
                    output_file = paste0(ws_dat$slug, '/', ws_dat$slug, "-communication_doc.docx"))
}

plan_doc_info <- list(YYYYMMDD=as.character(ws_dat$startdate),
                      sharepoint=paste0("[Sharepoint](", ws_dat$newch,")"),
                      workshop_website=paste0("[workshop website](","https://esciencecenter-digital-skills.github.io/", slug, ")"),
                      registration_page = paste0("[registration page](","https://www.eventbrite.co.uk/e/", ws_dat$eventbrite, ")"),
                      set_title = paste(ws_dat$slug, "planning document"),
                      lead_instructor = ws_dat$lead_instructor,
                      instructor = ws_dat$instructor,
                      helper = ws_dat$helper,
                      show_text=TRUE)

render_plan = function(plan_doc_info) {
  rmarkdown::render("files/planning_doc.Rmd", params = plan_doc_info,
                    output_file = paste0(ws_dat$slug, '/', ws_dat$slug, "-planning_doc.docx"))
}

debrief_doc_info <- list(YYYYMMDD=as.character(ws_dat$startdate),
                      set_title = paste(ws_dat$slug, "debriefing document"),
                      show_text=TRUE)

render_debrief = function(debrief_doc_info) {
  rmarkdown::render("files/debriefing_doc.Rmd", params = debrief_doc_info,
                    output_file = paste0(ws_dat$slug, '/', ws_dat$slug, "-debriefing_doc.docx"))
}

render_comm(comm_doc_info)
render_debrief(debrief_doc_info)
render_plan(plan_doc_info)

}
