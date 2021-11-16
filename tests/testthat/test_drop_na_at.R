test_that(desc = "drop_na_at works as expected",
          code = {
            # use unequal rows
            skip_on_oldrel()
            
            expect_false(anyNA(
              drop_na_at(airquality,
                         pattern_type = "starts_with",
                         pattern = "O")
            ))
            expect_snapshot({
              expect_error(drop_na_at(airquality,
                                      pattern_type = "contains",
                                      pattern = "o"))
              expect_error(drop_na_at(airquality,
                                      pattern_type = "contains"))
              expect_error(mde::drop_na_at(airquality, 
                                           pattern_type = "gibberish"))
            })
            
            
          })
