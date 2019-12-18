testthat::test_that(desc="Check recoding",
                    code={
                      testthat::expect_error(mde::recode_na_as(airquality,
                                                               value=0,
                                                               subset_df=TRUE,
                                                        subset_cols=c("Ozone",
                                                                  "not in")),
                                             "Some names not found in the dataset. Please check and try again.",
                                             fixed=TRUE)
                    })
