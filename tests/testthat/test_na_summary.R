testthat::test_that(desc="Test na_summary",
                    code = {

                      skip_on_oldrel()

     expect_warning(na_summary(airquality, grouping_cols=c("Month","Day")),
                              "All non grouping values used. Using select non groups is currently not supported",
                              fixed=TRUE)
    expect_error(na_summary(airquality,grouping_cols="gibberish"), "All columns to group by should exist in the data set.",
                           fixed=TRUE)
    # expect that columns are excluded
    excluded <- na_summary(mtcars, exclude_cols = "mpg")

    expect_false( "mpg" %in% excluded$variable)
   expect_error(na_summary(airquality,sort_by = "not_in"), 
                "sort_by should be a valid name in the output of na_summary",
                fixed=TRUE)
   expect_true(na_summary(airquality,sort_by = "percent_missing")[1,1]=="Day")
   expect_true(na_summary(airquality,sort_by = "percent_missing",
                          descending = TRUE)[1,1]=="Ozone")
   expect_equal(ncol(na_summary(airquality)),5)
    # Check that string sorting works
   expect_true(na_summary(airquality,sort_by="variable", 
                          descending = TRUE)[[1]][1] == "Wind")

   expect_true(na_summary(airquality,sort_by="variable", 
                          descending = FALSE)[[1]][1] == "Day")
   
   # Check that rounding works as expected 
   expect_true(na_summary(airquality, round_to=2, sort_by="percent_missing", 
              descending = TRUE)[1,"percent_missing"] == 24.18)


                    })
