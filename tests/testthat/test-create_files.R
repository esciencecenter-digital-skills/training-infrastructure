test_that("correct documents are created", {
  tdir <- "temporary_docs"

  # create temporary directory
  dir.create(tdir)

  load(file = "holytest.rda")
  slug <- "2021-03-22-ds-rpackaging"
  info <- get_workshop(holytest, slug)

  comms <- paste0(slug, "-communication_doc.docx")
  plan <- paste0(slug, "_planning_doc.docx")
  debrief <- paste0(slug, "_debriefing_doc.docx")

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


  # delete temporary directory and contents
  unlink(tdir,recursive=T)
})