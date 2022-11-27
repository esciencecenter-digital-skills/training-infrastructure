test_that("Workshop sheet is parsed correctly", {
  load(file = "holytest.rda")
  # verify the contents of the test file
  expect_equal(dim(holytest), c(20,26))
  expect_true("Holiday and conflicts"%in%names(holytest))
  # process and check
  holyselect <- get_future_workshops(holytest)
  expect_equal(dim(holyselect), c(1,28))
  expect_equal(c("Holiday and conflicts","humandate","helper")%in%names(holyselect), c(FALSE,TRUE,TRUE))
  expect_false(is.na(holyselect$instructor))
  expect_equal(holyselect[1,"humandate"], "October 22 - March 24, 2075")
})

test_that("Date selections are made using future argument", {
  load(file = "holytest.rda")
  holyselect <- get_future_workshops(holytest, future="2021-03-10")
  expect_equal(dim(holyselect), c(3,28))
  holyselect<- get_future_workshops(holytest, future="today")
  expect_equal(dim(holyselect), c(1,28))
  holyselect <- get_future_workshops(holytest, future="none")
  expect_equal(dim(holyselect), c(4,28))
})

test_that("Locations are found with Open Street Map", {
  load(file = "holytest.rda")
  holyselect <- get_future_workshops(holytest, future="none")
  expect_equal(round(holyselect$latitude[3], 1), 52.4)
  expect_equal(round(holyselect$longitude[3], 1), 5.0)
})
