testthat::test_that(desc="get_na_counts works as expected",
                    code={


                  testthat::expect_equal(nrow(get_na_counts(iris,"Species")),
                                         3)
                  testthat::expect_error(get_na_counts(airquality,
                                                       grouping_cols = "Nope"),
                                         "All grouping columns must exist in the data set",
                                         fixed=TRUE)
                  testthat::expect_equal(nrow(get_na_counts(airquality,
                                                            grouping_cols = "Month")),
                                         5)

                    })
