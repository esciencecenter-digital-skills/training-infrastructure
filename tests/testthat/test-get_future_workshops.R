test_that("Workshop sheet is parsed correctly", {
  load(file = "holytest.rda")
  expect_equal(dim(holytest), c(20,26))
  # check presence of certain names
  # check absence of names after processing
  # check presence of new column names after processing
  # check that names have content after processing
  holytest <- get_future_workshops(holytest)
  expect_equal(dim(holytest), c(1,26))
})

# test that confirms dates are turned into human dates

# test that token and location gives an error


test_that("Date selections are made using future argument", {
  load(file = "holytest.rda")
  holytest <- get_future_workshops(holytest, future="2021-03-10")
  expect_equal(dim(holytest), c(3,26))

  holytest <- get_future_workshops(holytest, future="today")
  expect_equal(dim(holytest), c(1,26))
})
