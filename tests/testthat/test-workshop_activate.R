test_that("Error messages are called if data is wrong for workshop_activate", {
  load(file = "holytest.rda")

  ht_noready <- holytest
  ht_noready$ready <- NULL
  expect_error(workshop_activate(ht_noready),
               "The data does not contain a column 'ready'.")

  ht_nocols <- holytest[0,]
  expect_error(workshop_activate(ht_nocols),
               "no workshops ready for activation.")
})
