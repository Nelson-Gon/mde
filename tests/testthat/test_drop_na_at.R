test_that(desc="drop_na_at works as expected",
                    code= {
                      # use unequal rows
                      skip_on_oldrel()
            expect_error(drop_na_at(airquality,
                                        pattern_type="contains",
                                        pattern="o"),
                                   "Unequal number of missing values, cannot rebind data. Please check with get_na_counts first",
                                  fixed = TRUE )
            expect_false(anyNA(drop_na_at(airquality,
                                  pattern_type="starts_with",
                                  pattern = "O")))
            expect_error(drop_na_at(airquality,
                                          pattern_type="contains"),
                                  "A pattern must be supplied.",
                                  fixed=TRUE)
            expect_error(mde::drop_na_at(airquality, pattern_type="gibberish"),
                                   'pattern_type should be one of starts_with,ends_with,contains or regex',
                                   fixed = TRUE)

                    })
