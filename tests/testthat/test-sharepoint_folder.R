test_that("folders are only created for non-existing slugs", {
  instr_site <- Microsoft365R::get_sharepoint_site(site_url="https://nlesc.sharepoint.com/sites/instructors")
  drv        <- instr_site$get_drive()
  slug       <- "2022-09-14-ds-rpackaging"
  create_sharepoint_folder(drv, slug)
  expect_error(oops_message)
})
