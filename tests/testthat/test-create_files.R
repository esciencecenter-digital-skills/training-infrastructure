test_that("correct documents are created", {
  # create temporary directory
  dir.create("temp")
  expect_true(dir.exists("temp"))

  load(file = "holytest.rda")

  # run function to create workshops, do tests on result
  create_files(workshop = "2021-03-22-ds-rpackaging",
               data = holytest,
               comms = T,
               plan = T,
               debrief = F,
               folder = "temp")
  files <- list.files("temp")
  expect_equal(length(files), 2)

  create_files(workshop = "2021-03-22-ds-rpackaging",
               data = holytest,
               comms = F,
               plan = T,
               debrief = T,
               folder = "temp")
  files <- list.files("temp")
  expect_equal(length(files), 3)

  # delete temporary directory and contents
  unlink("temp",recursive=T)
  expect_false(dir.exists("temp"))
})
