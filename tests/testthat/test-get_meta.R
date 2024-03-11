test_that("get_meta_url", {
  infotest = readRDS(file = "infotest.rda")
  expect_equal(get_meta_url(infotest),
               "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-dl-intro/")

  info <- data.frame(curriculum = "ds-parallel", flavor = NA)
  expect_equal(get_meta_url(info),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-parallel/")

  info <- data.frame(curriculum = "ds-docker", flavor = NA)
  expect_equal(get_meta_url(info),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-docker/")

  info <- data.frame(curriculum = "ds-rpackaging", flavor = NA)
  expect_equal(get_meta_url(info),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-rpackaging/")

  info <- data.frame(curriculum = "ds-gpu", flavor = NA)
  expect_equal(get_meta_url(info),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-gpu/")

  info <- data.frame(curriculum = "dc-socsci", flavor = "python")
  expect_equal(get_meta_url(info),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/dc-socsci-python/")

  info <- data.frame(curriculum = "ds-geospatial", flavor = "python")
  expect_equal(get_meta_url(info),
               "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-geospatial-python/")

  info <- data.frame(curriculum = "dc-astronomy", flavor = "python")
  expect_equal(get_meta_url(info),
               "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/dc-astronomy/")


  expect_error(get_meta_url("wrong-slug"))

})
