testthat::test_that(desc="Test helpers",
                    code = {
expect_true(get_na_means.data.frame(airquality)[[1]]==percent_missing.data.frame(airquality)[[1]])

                    })
