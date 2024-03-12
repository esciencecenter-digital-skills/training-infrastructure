test_that("Error messages are called if data is wrong for workshop_activate", {
  holytest = readRDS(file = "holytest.rda")

  ht_nocountry <- holytest

  # the test data misses essential columns that will activate get_future_workshops
  # the error expected here, is inside get_future_workshops
  # this test is to verify that get_future_workshops gets called correctly
  ht_nocountry$country <- NULL
  expect_error(workshop_activate(ht_nocountry),
               "Column 'country' is not present in the data.")

  # add columns that are checked for their presence in workshop_activate
  # this way, get_future_workshops is no longer activated
  holytest$instructor <- ""
  holytest$longitude <- ""

  ht_noready <- holytest
  ht_noready$ready <- NULL
  expect_error(workshop_activate(ht_noready),
               "The data does not contain a column 'ready'.")

  ht_nocols <- holytest[0,]
  expect_error(workshop_activate(ht_nocols),
               "no workshops ready for activation.")
})
