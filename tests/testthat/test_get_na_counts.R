test_that(desc = "get_na_counts works as expected",
          code = {
            skip_on_oldrel()
            expect_snapshot({
              expect_error(get_na_counts(as.POSIXct(Sys.Date())))
              expect_error(get_na_counts(airquality,
                                         grouping_cols = "Nope"))
              
              
            })
            
            expect_equal(nrow(get_na_counts(iris, "Species")),
                         3)
            
            expect_equal(nrow(get_na_counts(airquality,
                                            grouping_cols = "Month")),
                         5)
            
            # If using na_counts, expect that we get the same value as
            # when calling via get_na_counts, using Ozone as an example
            # here.
            expect_equal(get_na_counts(airquality)[[1]],
                         na_counts(airquality$Ozone))
            
          })
