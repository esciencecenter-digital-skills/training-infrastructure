test_that("only a single workshop is selected", {
  load(file = "holytest.rda")
  ws <- get_workshop(holytest, slug = "2021-03-22-ds-rpackaging")
  expect_equal(nrow(ws), 1)
})
