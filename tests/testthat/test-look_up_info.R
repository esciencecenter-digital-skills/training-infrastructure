test_that("correct information is returned", {
  path <- look_up_info(item = "holyexcel", id = "2022")
  expect_equal(path, "General/Holy excel sheets/Digital Skills Workshops 2022.xlsx")

  path <- look_up_info(item = "holyexcel", id = 2025)
  expect_equal(path, "General/Holy excel sheets/Digital Skills Workshops 2025.xlsx")
})
