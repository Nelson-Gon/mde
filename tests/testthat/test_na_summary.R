testthat::test_that(desc="Test na_summary",
                    code = {

                      skip_on_oldrel()


    # expect that columns are excluded
    excluded <- na_summary(mtcars, exclude_cols = "mpg")

    expect_false( "mpg" %in% excluded$variable)

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

   # Check that we can use inclusion patterns
   only_ozone <- na_summary(airquality,
                            pattern_type = "starts_with",
                            pattern = "ozone",
                            regex_kind = "inclusion")
   # we expect this to have the same number of missing values as no inclusion.
   expect_true(na_summary(airquality)[3,"missing"] == only_ozone[["missing"]])
   # Check that we can exclude via a regex
   expect_false(any(c("Ozone", "Solar.R") %in% na_summary(airquality,
                     pattern_type = "starts_with",
              pattern = "oz|Sol",
              regex_kind = "exclusion")[["variable"]]))
   expect_snapshot(

     {
       # Error if a user provides unexpected args
       expect_error(na_summary(airquality,
                               pattern_type = "starts_with",
                               pattern = "oz|Sol",
                               regex_kind = "random"))
       expect_error(na_summary(airquality,
                               pattern_type = "starts_with",
                               pattern = "oz|Sol",
                               exclude_cols = "Solar.R"))
       expect_error(na_summary(airquality,sort_by = "not_in"))
       expect_warning(na_summary(airquality, grouping_cols=c("Month","Day")))
       expect_error(na_summary(airquality,grouping_cols="gibberish"))

     }
   )


                    })


testthat::test_that("test to check reset_rownames in na_summary",
                    {
                      tmp <- na_summary(airquality, sort_by = "variable", descending = TRUE, reset_rownames = TRUE)
                      expect_equal(rownames(tmp), as.character(1:6))
                    })
