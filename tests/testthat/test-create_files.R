test_that("correct documents are created", {
  # create temporary directory
  dir.create("temp")

  # run function to create workshops, do tests on result
  create_files(workshop = "2021-03-22-ds-rpackaging",
                     comms = T,
                     plan = T,
                     debrief = F,
                     folder = "temp")
  files <- list.files("temp")
  expect_equal(length(files), 2)

  create_files(workshop = "2021-03-22-ds-rpackaging",
                     comms = F,
                     plan = T,
                     debrief = T,
                     folder = "temp")
  files <- list.files("temp")
  expect_equal(length(files), 3)

  # delete temporary directory and contents
  unlink("temp",recursive=T)
})
