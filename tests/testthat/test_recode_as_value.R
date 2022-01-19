test_that(desc = "Recoding as value works",
          code = {
            skip_on_oldrel()
            
            
            expect_snapshot(expect_error(recode_as_value(airquality,
                                        subset_cols = c("Ozone.R"))))
            
            expect_true(is.na(recode_as_value(
              iris,
              value = 5.1,
              replacement_value = NA, 
              subset_cols = c("Sepal.Length", "Petal.Length")
            )[[1]][1]))
            
            expect_error(recode_as_value(
              airquality,
              value = 190,
              replacement_value = 520, 
              pattern_type = "gibberish",
              pattern = "R"
            ))
            
            expect_error(recode_as_value(airquality, value = 0,
                                      replacement_value = 42, 
                                      subset_cols = "nope"))
            expect_error(recode_as_value(airquality, value = 0,
                                         replacement_value = 642642642,
                                      pattern_type = "contains"))
            expect_error(recode_as_value(
              airquality,
              value = 0,
              replacement_value = NA, 
              subset_cols = c("Ozone",
                              "not in")
            ))
          })
 