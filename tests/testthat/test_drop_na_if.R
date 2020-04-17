testthat::test_that(desc="drop_na_if errors as expected",
                    code =
                      {

                testthat::expect_error(drop_na_if(airquality,sign="nope"),
                        "I was expecting one of  gteq lteq gt lt eq not nope",
                        fixed=TRUE)

          testthat::expect_true("Ozone" %in% names(drop_na_if(airquality,
                                     sign="gteq", percent_na=4,
                                      keep_columns = "Ozone")))
          # cannot drop both Solar.R and Ozone
          keep_cols_test<-drop_na_if(airquality,
                     sign="gteq", percent_na=4,keep_columns =
                       c("Ozone","Solar.R"))
          testthat::expect_true(ncol(keep_cols_test) == ncol(airquality))
          testthat::expect_error(drop_na_if(airquality,keep_columns = "gibberish"),
                                 "All columns to keep should exist in the data set.",
                                 fixed=TRUE)
                      })
