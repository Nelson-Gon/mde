testthat::test_that(desc="Check recoding",
                    code={
                      testthat::expect_error(mde::recode_as_na(airquality,
                                                               value=0,
                                                        subset_cols=c("Ozone",
                                                                  "not in")),
                                             "Some names not found in the dataset. Please check and try again.",
                                             fixed=TRUE)
dummy_test <- data.frame(ID = c("A","B","B","A"),values = c("n/a",NA,"Yes","No"))

testthat::expect_warning(recode_as_na(dummy_test,"n/a"),
                         "Factor columns have been converted to character",
                         fixed=TRUE)
testthat::expect_error(recode_as_na(airquality,value=0,
                                    pattern_type = "contains",
                                    subset_cols = "Ozone"),
                       "Only one of pattern_type or subset_cols should be used but not both.",
                       fixed = TRUE)
testthat::expect_error(recode_as_na(airquality,value=0,
                                    subset_cols = "nope"),
                       "Some names not found in the dataset. Please check and try again.",
                       fixed=TRUE)
testthat::expect_error(recode_as_na(airquality,value=0,
                                    pattern_type ="contains"),
                       "A pattern must be supplied. See help(recode_as_na) for details",
                       fixed=TRUE)
# expect that recoding works
subset_pattern<-head(recode_as_na(airquality,pattern_type="starts_with",
                                  pattern="Solar",value = c(190, 118)))
subset_pattern_more<-head(recode_as_na(airquality,pattern_type="ends_with",
                                  pattern="R",value = c(190, 118)))
testthat::expect_true(all(is.na(subset_pattern_more[[2]][1:2])))

testthat::expect_error(recode_as_na(airquality,value=190,pattern_type = "gibberish",
                                    pattern="R"),
                       "pattern_type should be one of starts_with, ends_with or contains",
                       fixed = TRUE)

                    })
