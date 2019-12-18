testthat::test_that(desc="get_na_counts works as expected",
                    code={
                  testthat::expect_error(mde::get_na_counts(airquality,
                                                       grouped = TRUE),
                                         "Grouping chosen but no grouping columns provided.",
                                         fixed=TRUE)

                    })
