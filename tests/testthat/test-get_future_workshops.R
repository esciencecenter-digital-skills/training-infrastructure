test_that("Workshop sheet is parsed correctly", {
  holytest = readRDS(file = "holytest.rda")
  # verify the contents of the test file
  expect_equal(dim(holytest), c(20,28))
  expect_true("Holiday and conflicts"%in%names(holytest))
  # process and check
  holyselect <- get_future_workshops(holytest)
  expect_equal(dim(holyselect), c(1,29))
  expect_equal(c("Holiday and conflicts","humandate","helper")%in%names(holyselect), c(FALSE,TRUE,TRUE))
  expect_false(is.na(holyselect$instructor))
  expect_equal(holyselect[1,"humandate"], "October 22 - March 24, 2075")

  # if the data is empty, function still runs
  holytest <- holytest[-c(1:nrow(holytest)),]
  holyselect <- get_future_workshops(holytest)
  expect_equal(dim(holyselect), c(0,29))
})

test_that("Date selections are made using future argument", {
  holytest = readRDS(file = "holytest.rda")
  holyselect <- get_future_workshops(holytest, future="2021-03-10")
  expect_equal(dim(holyselect), c(3,29))
  holyselect<- get_future_workshops(holytest, future="today")
  expect_equal(dim(holyselect), c(1,29))
  holyselect <- get_future_workshops(holytest, future="none")
  expect_equal(dim(holyselect), c(4,29))
})

test_that("Locations are found with Open Street Map", {
  holytest = readRDS(file = "holytest.rda")
  holyselect <- get_future_workshops(holytest, future="none")
  expect_equal(round(holyselect$latitude[3], 1), 52.4)
  expect_equal(round(holyselect$longitude[3], 1), 5.0)

  wageningen_data = readRDS(file = "wageningen_data.rda")
  expect_warning(get_future_workshops(wageningen_data, future="none"),
                 regexp = "enter the complete address")
})
