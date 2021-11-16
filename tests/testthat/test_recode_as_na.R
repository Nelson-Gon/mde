test_that(desc = "Check recoding",
          code = {
            skip_on_oldrel()
            
            dummy_test <- data.frame(ID = c("A", "B", "B", "A"),
                                     values = c("n/a", NA, "Yes", "No"))
            
            expect_true(is.na(recode_as_na(dummy_test, "n/a")[1, 2]))
            
            # expect that recoding works
            subset_pattern <-
              head(recode_as_na(
                airquality,
                pattern_type = "starts_with",
                pattern = "Solar",
                value = c(190, 118)
              ))
            subset_pattern_more <-
              head(recode_as_na(
                airquality,
                pattern_type = "ends_with",
                pattern = "R",
                value = c(190, 118)
              ))
            expect_true(all_na(subset_pattern_more[[2]][1:2]))
            
            
            expect_snapshot({
              expect_warning(recode_as_na(iris, value = 5.1))
              expect_error(
                recode_as_na(
                  airquality,
                  value = 0,
                  pattern_type = "contains",
                  subset_cols = "Ozone"
                )
              )
              expect_error(recode_as_na(airquality, value = 0,
                                        subset_cols = "nope"))
              expect_error(recode_as_na(airquality, value = 0,
                                        pattern_type = "contains"))
              expect_error(recode_as_na(
                airquality,
                value = 0,
                subset_cols = c("Ozone",
                                "not in")
              ))
              
              expect_error(recode_as_na(
                airquality,
                value = 190,
                pattern_type = "gibberish",
                pattern = "R"
              ))
            })
            
            expect_true(is.na(recode_as_na(
              iris,
              value = 5.1,
              subset_cols = c("Sepal.Length", "Petal.Length")
            )[[1]][1]))
            
            
          })
