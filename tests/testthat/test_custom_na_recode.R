testthat::test_that(desc="custom_na_recode works as expected",
                    code={
                      # This should replace values in all columns with the maximum
                    all_by_max <- custom_na_recode(airquality,func="max")
                    # Only at Ozone
                    max_ozone <- custom_na_recode(airquality,func="max",across_columns = "Ozone")
                    testthat::expect_false(is.na(all_by_max[6,2]))
                    # This should return true since we only recoded at Ozone
                    testthat::expect_true(is.na(max_ozone[6,2]))
                    
                    })