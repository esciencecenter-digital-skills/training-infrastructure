test_that("correct documents are created", {
  infotest =readRDS(file = "infotest.rda")

  slug <- infotest$slug
  comms <- paste0(slug, "_communication_doc.docx")
  commshtml <- paste0(slug, "_communication_doc.html")
  plan <- paste0(slug, "_planning_doc.docx")
  debrief <- paste0(slug, "_debriefing_doc.docx")
  datacsv <- "data.csv"

  # run function to create workshops, do tests on result
  create_files(infotest)
  files <- list.files(".")
  expect_true(comms %in% files)
  expect_true(commshtml %in% files)
  expect_true(plan %in% files)
  expect_true(debrief %in% files)
  expect_true(datacsv %in% files)

  # delete temporary directory and leftover contents
  files_left <- list.files(".")[stringr::str_detect(list.files("."), slug)]
  for(r in files_left){
    file.remove(r)
  }
  file.remove(datacsv)
})

test_that("files cannot be created to nonexisting folder", {
  infotest = readRDS(file = "infotest.rda")
  expect_error(create_files(infotest, folder = "nonexisting"))
})
