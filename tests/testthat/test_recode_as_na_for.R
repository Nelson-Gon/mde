test_that(desc = "test recode_as_na_for",
          code = {
            skip_on_oldrel()
            expect_snapshot({
              expect_error(recode_as_na_for(airquality,
                                            criteria = "gibberish"))
              
              
              expect_error(recode_as_na_for(airquality,
                                            subset_cols = "gibberish"))
              
            })
            
            expect_true(is.na(
              recode_as_na_for(
                airquality,
                criteria = "gt",
                value = 25,
                subset_cols = "Ozone"
              )[[1]][1]
            ))
            # should only be true at ozone
            expect_false(is.na(
              recode_as_na_for(
                airquality,
                criteria = "gt",
                value = 25,
                subset_cols = "Ozone"
              )[[2]][1]
            ))
            # expect false since first value is not less than 25
            expect_false(is.na(
              recode_as_na_for(
                airquality,
                criteria = "lt",
                value = 25,
                subset_cols = "Ozone"
              )[[2]][1]
            ))
            # expect true
            expect_true(is.na(
              recode_as_na_for(
                airquality,
                criteria = "eq",
                subset_cols = "Solar.R",
                value = 190
              )[[2]][1]
            ))
            expect_true(is.na(
              recode_as_na_for(
                airquality,
                criteria = "lteq",
                subset_cols = "Solar.R",
                value = 190
              )[[2]][1]
            ))
            expect_false(is.na(
              recode_as_na_for(
                airquality,
                criteria = "gt",
                value = 25,
                subset_cols = "Ozone"
              )[[2]][1]
            ))
            expect_false(is.na(
              recode_as_na_for(
                airquality,
                criteria = "gteq",
                value = 25,
                subset_cols = "Ozone"
              )[[2]][1]
            ))
            
            # should be true since we're not subsetting
            expect_true(all(all_na(
              recode_as_na_for(airquality,
                               criteria = "gt",
                               value = 0)[1:2, c(1, 2)]
            )))
            expect_true(is.na(recode_as_na_for(
              airquality,
              criteria = "eq",
              value = 41
            )[1, 1]))
            head(airquality)
            
            expect_true(all_na(recode_as_na_for(
              airquality, criteria = "gteq", value = 118
            )[[2]][1:2]))
            expect_false(is.na(recode_as_na_for(
              airquality, criteria = "lteq", value = 12
            )[[1]][1]))
            expect_false(is.na(recode_as_na_for(
              airquality, criteria = "lt", value = 12
            )[[1]][1]))
            
            
            
          })
