test_that("comms doc info contains relevant variables", {
  load("holytest.Rda")
  comms_test <- get_future_workshops(holytest)
  comms_test2 <- get_comms_doc_info(comms_test[1,])
  expect_true("time" %in% names(comms_test2))
  expect_false("barbara" %in% names(comms_test2))
})
