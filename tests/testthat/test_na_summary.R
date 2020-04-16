testthat::test_that(desc="Test na_summary",
                    code = {
                      
     testthat::expect_warning(mde::na_summary(airquality, grouping_cols=c("Month",
                                                                          "Day")),
                              "All non grouping values used. Using select non groups is currently not supported",
                              fixed=TRUE)
    testthat::expect_error(mde::na_summary(airquality,grouping_cols="gibberish"),
                           "All grouping_cols should exist in the dataset.",
                           fixed=TRUE)                  
                    })