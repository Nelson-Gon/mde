testthat::test_that(desc="percent_missing warns",
                    code = {
                      
                      testthat::expect_warning(mde::percent_missing(airquality,
                                                              grouped=TRUE),
                                               "You chose to do grouping but no grouping columns were provided.",
                                               fixed=TRUE)
                    })