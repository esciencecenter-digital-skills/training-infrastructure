skip_on_ci()

test_that("folders are only created for non-existing slugs", {
  info       <- data.frame(slug="2022-09-14-ds-rpackaging")
  expect_warning(create_sharepoint_folder(info),
                 regexp = "2022-09-14-ds-rpackaging already exists")
})
