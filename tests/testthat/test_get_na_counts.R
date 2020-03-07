testthat::test_that(desc="get_na_counts works as expected",
                    code={


                  testthat::expect_equal(nrow(get_na_counts(iris,"Species")),
                                         3)

                    })
