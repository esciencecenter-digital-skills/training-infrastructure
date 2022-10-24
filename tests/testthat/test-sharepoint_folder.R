skip_on_ci()

test_that("folders are only created for non-existing slugs", {
  instr_site <- Microsoft365R::get_sharepoint_site(site_url="https://nlesc.sharepoint.com/sites/instructors")
  info       <- data.frame(slug="2022-09-14-ds-rpackaging")
  drv        <- instr_site$get_drive()
  expect_warning(create_sharepoint_folder(drv, info), "the folder 2022-09-14-ds-rpackaging already exists")
})
