test_that(desc = "Check recoding",
          code = {
            skip_on_oldrel()
            expect_snapshot({
              expect_error(recode_na_as(
                airquality,
                value = 0,
                
                subset_cols = c("Ozone",
                                "not in")
              ))
              
              expect_error(recode_na_as(
                airquality,
                0,
                subset_cols = "Ozone",
                pattern_type = "starts_with"
              ))
              # test that patterns throw errors
              expect_error(recode_na_as(airquality, value = 0,
                                        pattern_type = "na"))
              # expect a pattern
              expect_error(recode_na_as(airquality, value = 0,
                                        pattern_type = "ends_with"))
            })
            
            # change all NAs to 0s
            expect_equal(head(recode_na_as(airquality, value = 0))[[2]][6],
                         0)
            # change only at Ozone
            only_ozone <-
              head(recode_na_as(airquality, value = 0,
                                subset_cols = "Ozone"))
            # expect that only NAs at Ozone are 0
            expect_true(is.na(only_ozone[[2]][5]))
            # expect 0s for ozone
            expect_false(is.na(only_ozone[[1]][5]))
            expect_equal(only_ozone[[1]][5], 0)
            
            expect_equal(mde::recode_na_as(
              airquality,
              value = 0,
              pattern_type = "regex",
              pattern = "^O"
            )[[1]][5],
            0)
            
          })
