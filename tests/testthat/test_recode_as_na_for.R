testthat::test_that(desc = "test recode_as_na_for",
                    code={

                      testthat::expect_error(recode_as_na_for(airquality,
                                      criteria = "gibberish"),
                                      "criteria should be one of gteq, lt, lteq,gteq or eq.",
                                      fixed = TRUE)


                  testthat::expect_error(recode_as_na_for(airquality,
                               subset_cols = "gibberish"),
                               "All subset_cols should exist in the data set.",
                               fixed = TRUE)
          testthat::expect_true(is.na(recode_as_na_for(airquality,
                                        criteria = "gt",value = 25,
                                   subset_cols = "Ozone")[[1]][1]))
          # should only be true at ozone
          testthat::expect_false(is.na(recode_as_na_for(airquality, criteria = "gt",
                                                        value = 25,
                                                      subset_cols = "Ozone")[[2]][1]))
          # expect false since first value is not less than 25
          testthat::expect_false(is.na(recode_as_na_for(airquality, criteria = "lt",
                                            value = 25,
                                  subset_cols = "Ozone")[[2]][1]))
          # should be true since we're not subset
          testthat::expect_true(all(is.na(recode_as_na_for(airquality,
                                                           criteria = "gt",
                                       value=0)[1:2,c(1,2)])))
         testthat::expect_true(is.na(recode_as_na_for(airquality,
                                                      criteria="eq",
                                                      value = 41)[1,1]))




                    })
