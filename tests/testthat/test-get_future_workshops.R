test_that("Workshop sheet is parsed correctly", {
  load(file = "holytest.rda")
  expect_equal(dim(holytest), c(10,26))
  holytest <- get_future_workshops(holytest)
  expect_equal(dim(holytest), c(3,26))
})
