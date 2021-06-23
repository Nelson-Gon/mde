test_that(desc="Test Dictionary Style Recoding",
          
          code = 
            {
              
              skip_on_oldrel()
              
              # Check that partial string match works
              
      recode_partial <- dict_recode(airquality, 
                                    pattern_type="starts_with",
                                    patterns = c("S", "O"), 
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
            })