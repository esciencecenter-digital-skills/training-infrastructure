test_that("info parameter is checked properly", {
  a_string <- "here is text"
  expect_error(verify_info(a_string),
               "Input does not match the required format.")

  a_number <- 4
  expect_error(verify_info(a_number),
               "Input does not match the required format.")

  data_without_slug <- data.frame()
  expect_error(verify_info(data_without_slug),
               "Input does not match the required format.")
})
