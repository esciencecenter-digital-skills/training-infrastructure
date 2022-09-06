test_that("folders are only created for non-existing slugs", {
  instr_site <- Microsoft365R::get_sharepoint_site(site_url="https://nlesc.sharepoint.com/sites/instructors")
  info       <- data.frame(slug="2022-09-14-ds-rpackaging")
  drv        <- instr_site$get_drive()
  oops_message <- create_sharepoint_folder(drv, info)
  expect_null(oops_message)
})
