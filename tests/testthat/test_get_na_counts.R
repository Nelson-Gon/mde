test_that(desc="get_na_counts works as expected",
                    code={

                      skip_on_oldrel()
                  expect_equal(nrow(get_na_counts(iris,"Species")),
                                         3)
                  expect_error(get_na_counts(airquality,
                                                       grouping_cols = "Nope"),
                                         "All columns to group by should exist in the data set",
                                         fixed=TRUE)
                  expect_equal(nrow(get_na_counts(airquality,
                                                            grouping_cols = "Month")),
                                         5)

                    })
