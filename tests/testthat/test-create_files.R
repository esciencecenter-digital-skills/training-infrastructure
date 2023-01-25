test_that("individual documents can be rendered", {
  load(file = "infotest.rda")
  slug <- infotest$slug
  tempdir <- create_tempdir()

  # communication
  doc_info <- get_comms_doc_info(infotest)
  render_doc(info = doc_info, type = "communication", folder = tempdir)
  expect_true(file.exists(paste0(tempdir, "/", slug, "_communication_doc.docx")))
  expect_true(file.exists(paste0(tempdir, "/", slug, "_communication_doc.html")))

  # planning
  doc_info <- get_planning_doc_info(infotest)
  render_doc(info = doc_info, type = "planning", folder = tempdir)
  expect_true(file.exists(paste0(tempdir, "/", slug, "_planning_doc.docx")))

  # debriefing
  doc_info <- get_debrief_doc_info(infotest)
  render_doc(info = doc_info, type = "debriefing", folder = tempdir)
  expect_true(file.exists(paste0(tempdir, "/", slug, "_debriefing_doc.docx")))

  unlink(tempdir, recursive = T)
})

test_that("all documents are created", {
  load(file = "infotest.rda")
  tempdir <- create_tempdir()
  slug <- infotest$slug

  # run function to create workshops, do tests on result
  create_files(infotest, folder=tempdir)
  files <- list.files(tempdir)
  for(docname in c("_communication_doc.docx",
                   "_communication_doc.html",
                   "_planning_doc.docx",
                   "_debriefing_doc.docx")){
    fname <- paste0(slug, docname)
    expect_true(fname %in% files, label = fname)
  }

  expect_true("data.csv" %in% files, label = "data.csv")

  # delete temporary directory and leftover contents
  unlink(tempdir, recursive = T)
})

test_that("files cannot be created to nonexisting folder", {
  load(file = "infotest.rda")
  expect_error(create_files(infotest, folder = "nonexisting"))
})
