testthat::test_that(desc="Test na_summary",
                    code = {

     expect_warning(mde::na_summary(airquality, grouping_cols=c("Month",
                                                                          "Day")),
                              "All non grouping values used. Using select non groups is currently not supported",
                              fixed=TRUE)
    expect_error(mde::na_summary(airquality,grouping_cols="gibberish"),
                           "All grouping_cols should exist in the dataset.",
                           fixed=TRUE)
    # expect that all rows are equal as required
    expect_error(na_summary(mtcars, exclude_cols = "mpg"),
                           "Binding of datasets failed. Please check using percent_missing and get_na_counts first",
                           fixed = TRUE)
   expect_error(na_summary(airquality,sort_by = "not_in"), "sort_by should be a valid name in the output of na_summary",
                fixed=TRUE)
   expect_true(na_summary(airquality,sort_by = "percent_missing")[1,1]=="Day")
   expect_true(na_summary(airquality,sort_by = "percent_missing",descending = TRUE)[1,1]=="Ozone")
   expect_equal(ncol(na_summary(airquality)),5)


                    })
