testthat::test_that(desc="drop_na_at works as expected",
                    code= {
                      # use unequal rows
               
            testthat::expect_error(mde::drop_na_at(airquality,
                                        pattern_type="contains",
                                        pattern="o"),
                                   "Unequal number of missing values, cannot rebind data. Please check with get_na_counts first",
                                  fixed = TRUE )
            testthat::expect_false(anyNA(mde::drop_na_at(airquality,
                                  pattern_type="starts_with",
                                  pattern = "O")))
            testthat::expect_error(mde::drop_na_at(airquality,
                                          pattern_type="contains"),
                                  "No pattern was provided. Please provide one.",
                                  fixed=TRUE)
             
                    })