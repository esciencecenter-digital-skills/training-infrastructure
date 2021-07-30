create_files <- function(slug) {
  #' Take the template word documents and save them with specific information for the upcoming workshop in the corresponding Sharepoint channel
  #' Input: 
  #'         slug: slug for the workshop
  #'         
  #' Ouput:
  #'         no output, just saving files within the project directory. 
  

comm_doc <- read_docx(path = "templates/communication_doc.docx") %>%
  body_add_par("Level 1 title", style = "heading 1") %>%
  body_add_par("Hello world!", style = "Normal")

print(doc_3, target = "reports/example_3.docx")

}