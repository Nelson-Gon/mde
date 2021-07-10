test_that(desc="Test Dictionary Style Recoding",
          
          code = 
            {
              
              skip_on_oldrel()
              
              # Check that partial string match works
              
      recode_partial <- dict_recode(airquality, 
                                    pattern_type="starts_with",
                                    patterns = c("S", "O"), 
                                    use_func = "recode_na_as",
                                    values = c(52, 520))
     # Check that nrow is equal to original datasets nrow 
      expect_true(nrow(recode_partial)==nrow(airquality))
      expect_true(ncol(recode_partial)==ncol(airquality))
      # expect no NAs 
      recode_partial
      anyNA(recode_partial["Solar.R"])
     # Check that Solar.R has 52s 
     expect_equal(recode_partial[[2]][5], 52)
     # Expect that Ozone has 520s 
     expect_equal(recode_partial[[1]][5], 520)
     # Check that we can use functions other than recode_na_as 
     # We expect that values in Solar.R that are 190 are NA and those in
     # Ozone that are 41 are NA 
     rasna <-dict_recode(airquality, pattern_type="ends_with",
                 patterns=c("R", "e"),
                 use_func="recode_as_na",
                 values = c(190, 41))
     expect_true(is.na(rasna[1,1]))
     expect_true(is.na(rasna[1,2]))
     # Check that if given a function that doesn't exist in mde, we throw an 
     # error 
     expect_error(dict_recode(airquality, pattern_type="ends_with",
                              patterns=c("R", "e"),
                              use_func="not_mde_function",
                              values = c(190, 41)),
                  "not_mde_function is not a valid function in package mde.",
                  fixed=TRUE)
            })