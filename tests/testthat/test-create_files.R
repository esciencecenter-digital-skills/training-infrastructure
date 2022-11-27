test_that("correct documents are created", {
  # just in case a temp directory already exists: remove it
  if(dir.exists("temp_docs")){
    unlink("temp_docs", recursive=T)
  }

  # create temporary directory
  dir.create("temp_docs")
  expect_true(dir.exists("temp_docs"))

  load(file = "holytest.rda")

  # run function to create workshops, do tests on result
  create_files(workshop = "2021-03-22-ds-rpackaging",
               data = holytest,
               comms = T,
               plan = T,
               debrief = F,
               folder = "temp_docs")
  files <- list.files("temp_docs")
  expect_equal(length(files), 2)

  create_files(workshop = "2021-03-22-ds-rpackaging",
               data = holytest,
               comms = F,
               plan = T,
               debrief = T,
               folder = "temp_docs")
  files <- list.files("temp_docs")
  expect_equal(length(files), 3)

  # delete temporary directory and contents
  unlink("temp_docs",recursive=T)
  expect_false(dir.exists("temp_docs"))
})
