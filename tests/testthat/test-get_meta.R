test_that("get_meta_url", {

  expect_equal(get_meta_url("ds-parallel"),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-parallel/")

  expect_equal(get_meta_url("ds-docker"),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-docker/")

  expect_equal(get_meta_url("ds-rpackaging"),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-rpackaging/")

  expect_equal(get_meta_url("ds-gpu"),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/ds-gpu/")

  expect_equal(get_meta_url("dc-socsci-python"),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/workshop-metadata/main/dc-socsci-python/")

  expect_error(get_meta_url("wrong-slug"))

})
