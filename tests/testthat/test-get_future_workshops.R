test_that("Workshop sheet is parsed correctly", {
  load(file = "holytest.rda")
  # verify the contents of the test file
  expect_equal(dim(holytest), c(20,26))
  expect_true("Holiday and conflicts"%in%names(holytest))
  # process and check
  holytest <- get_future_workshops(holytest)
  expect_equal(dim(holytest), c(1,26))
  expect_equal(c("Holiday and conflicts","humandate","helper")%in%names(holytest), c(FALSE,TRUE,TRUE))
  expect_false(is.na(holytest$instructor))
  expect_equal(holytest[1,"humandate"], "October 22 - March 24, 2075")
})

test_that("Token is needed to inquire location", {
  expect_error(get_future_workshops(holytest, include_location = T))
})

test_that("Date selections are made using future argument", {
  load(file = "holytest.rda")
  holytest <- get_future_workshops(holytest, future="2021-03-10")
  expect_equal(dim(holytest), c(3,26))

  holytest <- get_future_workshops(holytest, future="today")
  expect_equal(dim(holytest), c(1,26))
})

test_that("Locations are found with Open Street Map", {
  load(file = "holytest.rda")
  holytest <- get_future_workshops(holytest, future="none", include_location = T, token = "not necessary")
  expect_equal(holytest$latitude[3], 52.3566292)
  expect_equal(holytest$longitude[3], 4.9568662)

})
