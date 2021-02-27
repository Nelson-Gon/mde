test_that(desc="drop_na_if errors as expected",
                    code =
                      {
                        skip_on_oldrel()
                expect_error(drop_na_if(airquality,sign="nope"),
                        "I was expecting one of  gteq lteq gt lt eq not nope",
                        fixed=TRUE)

          expect_true("Ozone" %in% names(drop_na_if(airquality,
                                     sign="gteq", percent_na=4,
                                      keep_columns = "Ozone")))
          # cannot drop both Solar.R and Ozone
          keep_cols_test<-drop_na_if(airquality,
                     sign="gteq", percent_na=4,keep_columns =
                       c("Ozone","Solar.R"))
          expect_true(ncol(keep_cols_test) == ncol(airquality))
          expect_error(drop_na_if(airquality,keep_columns = "gibberish"),
                                 "All columns to keep should exist in the data set.",
                                 fixed=TRUE)
          
          # Test grouped dropping
          grouped_drop <- structure(list(ID = c("A", "A", "B", "A", "B"), 
          Vals = c(4, NA,  NA, NA, NA), Values = c(5, 6, 7, 8, NA)), 
          row.names = c(NA, -5L), class = "data.frame")
          drop_groups <- drop_na_if(grouped_drop,percent_na = 67,
                                    grouping_cols = "ID")
          expect_false("B" %in% drop_groups$ID)
          # Check that switching signs works as expected 
          drop_groups_sign <- drop_na_if(grouped_drop,percent_na=50,
                                         sign="lteq", grouping_cols="ID")
          expect_equal(nrow(drop_groups_sign), 0)
          # Expect errors if we provide gibberish grouping columns
          expect_error(drop_na_if(grouped_drop,percent_na=67,sign="lteq",
                                  grouping_cols = "gibberish"),
                       "All columns to group by should exist in the data set.",
                       fixed=TRUE)
                      })
