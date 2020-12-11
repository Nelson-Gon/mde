test_that(desc="Test partial string recoding", 
          code = {
            partial_match <- data.frame(A=c("Hi","match_me","nope"), B=c(NA, "not_me","nah"))
            partial_match
            
            expect_true(is.na(recode_as_na_str(partial_match,pattern_type="contains",
                                               pattern="me", case_sensitive=FALSE)[[2]][2]))
            expect_false(is.na(recode_as_na_str(partial_match,pattern_type="ends_with",
                                                pattern="ME", case_sensitive=TRUE)[[2]][2]))
            
            
          })