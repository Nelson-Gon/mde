testthat::test_that(desc="sorting only by columns or percents",
                    code={
                      
                      testthat::expect_error(mde::sort_by_missingness(airquality,
                                                                      sort_by="gibberish"),
                                             "sort_by should be one of counts or percents",
                                             fixed=TRUE)
                    })