test_that(desc = "Test condition based NA recoding",
          code = {
            skip_on_oldrel()
            # Change all values in Ozone to NA
            test_recode <-
              head(recode_as_na_if(airquality, sign = "gt", percent_na = 20))
            test_recode_ignore <-
              head(recode_as_na_if(
                airquality,
                sign = "gt",
                percent_na = 20,
                keep_columns = "Ozone"
              ))
            expect_true(is.na(test_recode[1, 1]))
            expect_false(is.na(test_recode_ignore[1, 1]))
            expect_snapshot({
              expect_error(head(
                recode_as_na_if(airquality, sign = "gibberish",
                                percent_na = 20)
              ))
            })
            
            
            
            
          })
