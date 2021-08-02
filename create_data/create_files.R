create_files <- function(ws_dat) {
  #' Take the template word documents and save them with specific information for the upcoming workshop in the corresponding Sharepoint channel
  #' Input: 
  #'         slug: slug for the workshop
  #'         
  #' Ouput:
  #'         no output, just saving files within the project directory. 
  

comm_doc <- read_docx(path = "templates/communication_doc.docx") %>%
  body_replace_all_text("YYYY-MM-DD", as.character(ws_dat$startdate)) %>%
  body_replace_all_text("[workshop]", ws_dat$title) %>% 
  body_replace_all_text("[location]", ws_dat$venue) %>% 
  body_replace_all_text("[time]", paste(ws_dat$starttime, "-", ws_dat$endtime, as.character(strftime(ws_dat$startdate, format="%Z")))) %>% 
  body_replace_all_text("[date]", paste0(strftime(ws_dat$startdate, format="%a %b %d"), " - ", strftime(ws_dat$enddate, format="%a %b %d")))
  body_replace_all_text("[workshop website]", paste0("https://esciencecenter-digital-skills.github.io/", slug)) %>% 
  body_replace_all_text("[month]", strftime(ws_dat$startdate, format="%B")) %>% 
  body_replace_all_text("[day of workshop]", strftime(ws_dat$startdate, format="%A, %b %d")) %>% 
  body_replace_all_text("[start time]", as.character(strftime(strptime(ws_dat$starttime, format = "%H:%M") - 
                                                                as.difftime(15, units="mins"), format="%H:%M"))) %>% #encourage 15 minutes before start showup.   
  body_replace_all_text("[registration page]", paste0("https://www.eventbrite.co.uk/e/", ws_dat$eventbrite))


debrief_doc <- read_docx(path = "templates/debriefing_doc.docx") 
  body_replace_all_text("[slug]", ws_dat$slug)


print(comm_doc, target = paste0(ws_dat$slug, "/", ws_dat$slug, "communication_doc.docx"))
print(debrief_doc, target = paste0(ws_dat$slug, "/", ws_dat$slug, "debriefing_doc.docx"))
print(planning_doc, target = paste0(ws_dat$slug, "/", ws_dat$slug, "planning_doc.docx"))

}