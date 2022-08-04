test_that("MS drive is opened", {
  drive <- connect_drive()
  expect_equal(drive$properties$driveType, "documentLibrary")
})

test_that("Default excel file is loaded as dataframe", {
  opened_excel <- read_from_drive()
  expect_equal(class(opened_excel), "data.frame")
})
