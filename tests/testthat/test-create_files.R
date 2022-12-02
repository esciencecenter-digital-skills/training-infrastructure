test_that("correct documents are created", {
  tdir <- "temporary_docs"

  # create temporary directory
  dir.create(tdir)

  load(file = "holytest.rda")
  rpack <- "2021-03-22-ds-rpackaging"
  info <- dplyr::filter(holytest, slug==rpack)

  comms <- paste0(rpack, "-communication_doc.docx")
  plan <- paste0(rpack, "_planning_doc.docx")
  debrief <- paste0(rpack, "_debriefing_doc.docx")

  # run function to create workshops, do tests on result
  create_files(info,
               comms = T,
               plan = T,
               debrief = F,
               folder = tdir)
  files <- list.files(tdir)
  expect_true(comms %in% files)
  expect_true(plan %in% files)
  expect_false(debrief %in% files)

  create_files(info,
               comms = F,
               plan = T,
               debrief = T,
               folder = tdir)
  files <- list.files(tdir)
  expect_true(debrief %in% files)
  expect_length(files, 4)

  # delete temporary directory and leftover contents
  unlink(tdir,recursive=T)
  rmds_left <- list.files(".")[stringr::str_detect(list.files("."), ".Rmd")]
  for(r in rmds_left){
    file.remove(r)
  }
})
