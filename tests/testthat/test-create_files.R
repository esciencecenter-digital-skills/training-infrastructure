test_that("correct documents are created", {
  load(file = "holytest.rda")
  rpack <- "2021-03-22-ds-rpackaging"
  info <- dplyr::filter(holytest, slug==rpack)

  comms <- paste0(rpack, "_communication_doc.docx")
  plan <- paste0(rpack, "_planning_doc.docx")
  debrief <- paste0(rpack, "_debriefing_doc.docx")

  # run function to create workshops, do tests on result
  create_files(info)
  files <- list.files(".")
  expect_true(comms %in% files)
  expect_true(plan %in% files)
  expect_true(debrief %in% files)

  # delete temporary directory and leftover contents
  files_left <- list.files(".")[stringr::str_detect(list.files("."), rpack)]
  for(r in files_left){
    file.remove(r)
  }
})
