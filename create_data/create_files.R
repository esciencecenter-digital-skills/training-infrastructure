create_files <- function(ws_dat) {
  #' Take the template word documents and save them with specific information for the upcoming workshop in the corresponding Sharepoint channel
  #' Input: 
  #'         ws_dat: information about the workshop to be inserted into the different documents
  #'         
  #' Ouput:
  #'         no output, just saving files within the project directory. 
  
comm_doc_info <- list(YYYYMMDD=as.character(ws_dat$startdate),
                      workshop=ws_dat$title,
                      location=ws_dat$venue,
                      time=paste(ws_dat$starttime, "-", ws_dat$endtime, as.character(strftime(ws_dat$startdate, format="%Z"))),
                      date=paste0(strftime(ws_dat$startdate, format="%a %b %d"), " - ", strftime(ws_dat$enddate, format="%a %b %d")), 
                      workshop_website=paste0("[workshop website](","https://esciencecenter-digital-skills.github.io/", slug, ")"),
                      workshop_website_url=paste0("https://esciencecenter-digital-skills.github.io/", slug),
                      month=strftime(ws_dat$startdate, format="%B"),
                      day_of_workshop = strftime(ws_dat$startdate, format="%A, %b %d"),
                      start_time=as.character(strftime(strptime(ws_dat$starttime, format = "%H:%M") - 
                                                                as.difftime(15, units="mins"), format="%H:%M")), #encourage 15 minutes before start showup.   
                      registration_page = paste0("[registration page](","https://www.eventbrite.co.uk/e/", ws_dat$eventbrite, ")"),
                      registration_page_url = paste0("https://www.eventbrite.co.uk/e/", ws_dat$eventbrite),
                      set_title = paste(ws_dat$slug, "communication document"),
                      show_text=TRUE)

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




render_plan(plan_doc_info)

#debrief_doc <- read_docx(path = "templates/debriefing_doc.docx") %>% 
 # body_replace_all_text("[slug]", ws_dat$slug, fixed=T)

#plan_doc <- read_docx(path="templates/planning_doc.docx") %>% 
 # body_replace_all_text("YYYY-MM-DD", as.character(ws_dat$startdate), fixed=T) %>%
#  body_replace_all_text("[workshop]", ws_dat$title, fixed=T) %>% 
 # slip_in_text("Sharepoint Folder", hyperlink = paste0("https://nlesc.sharepoint.com/sites/instructors/Shared Documents/", slug), pos = "before") 
  
  
#print(comm_doc, target = paste0(ws_dat$slug, "/", ws_dat$slug, "communication_doc.docx"))
#print(debrief_doc, target = paste0(ws_dat$slug, "/", ws_dat$slug, "debriefing_doc.docx"))
#print(plan_doc, target = paste0(ws_dat$slug, "/", ws_dat$slug, "planning_doc.docx"))

}
