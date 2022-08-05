test_that("Workshop sheet is parsed correctly", {
  load(file = "holytest.rda")
  expect_equal(dim(holytest), c(10,26))
  holytest <- get_future_workshops(holytest)
  expect_equal(dim(holytest), c(3,26))
})


test_that("Date selections are made using future argument", {
  load(file = "holytest.rda")
  holytest <- get_future_workshops(holytest, future="2021-03-10")
  expect_equal(dim(holytest), c(2,26))

  holytest <- get_future_workshops(holytest, future="today")
  expect_equal(dim(holytest), c(0,26))
})
