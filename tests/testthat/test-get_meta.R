test_that("get_meta_fld", {

  expect_equal(get_meta_fld("ds-parallel"),
                            "https://raw.githubusercontent.com/carpentries-incubator/lesson-parallel-python/gh-pages/_meta/")

  expect_equal(get_meta_fld("ds-docker"),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/docker-introduction/gh-pages/_meta/")

  expect_equal(get_meta_fld("ds-rpackaging"),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/lesson-R-packaging/gh-pages/_meta/")

  expect_equal(get_meta_fld("ds-gpu"),
                            "https://raw.githubusercontent.com/carpentries-incubator/lesson-gpu-programming/gh-pages/_meta/")

  expect_equal(get_meta_fld("dc-socsci-python"),
                            "https://raw.githubusercontent.com/esciencecenter-digital-skills/carpentries_metadata/main/dc-socsci-python/")

})
