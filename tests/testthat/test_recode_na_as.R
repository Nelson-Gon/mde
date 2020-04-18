testthat::test_that(desc="Check recoding",
                    code={
                      testthat::expect_error(mde::recode_na_as(airquality,
                                                               value=0,

                                                        subset_cols=c("Ozone",
                                                                  "not in")),
                                             "Some names not found in the dataset. Please check and try again.",
                                             fixed=TRUE)

                  testthat::expect_error(mde::recode_na_as(airquality,0,
                                                           subset_cols="Ozone",
                                                           pattern_type="starts_with"
                                                           ),
                                         "Only one of pattern_type or subset_cols should be used but not both.",
                                         fixed = TRUE)
                  # change all NAs to 0s
                  testthat::expect_equal(head(recode_na_as(airquality,value = 0))[[2]][6],
                                         0)
                  # change only at Ozone
                  only_ozone<-head(recode_na_as(airquality,value = 0, subset_cols = "Ozone"))
                  # expect that only NAs at Ozone are 0
                  testthat::expect_true(is.na(only_ozone[[2]][5]))
                  # expect 0s for ozone
                  testthat::expect_false(is.na(only_ozone[[1]][5]))
                  testthat::expect_equal(only_ozone[[1]][5], 0)
                  # test that patterns throw errors
                  testthat::expect_error(recode_na_as(airquality,value = 0,
                                                      pattern_type = "na"),
                                         "pattern_type should be one of starts_with, ends_with or contains.",
                                         fixed = TRUE)
                  # expect a pattern
                  testthat::expect_error(recode_na_as(airquality,value = 0,
                                                      pattern_type = "ends_with"),
                                         "A pattern must be supplied.")

                  })
