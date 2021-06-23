test_that(desc="Test partial string recoding",
          code = {
            
            partial_match <- data.frame(A=c("Hi","match_me","nope"), 
                                        B=c(NA, "not_me","nah"))
            

            expect_true(is.na(recode_as_na_str(partial_match,
                                               pattern_type="contains",
                                               pattern="me", 
                                               
                                      case_sensitive=FALSE)[[2]][2]))
            expect_false(is.na(recode_as_na_str(partial_match,
                                                pattern_type="ends_with",
                                                pattern="ME", 
                                  case_sensitive=TRUE)[[2]][2]))


          })

test_that(desc="Test factor to character conversion and warning message",
          code = {
            partial_match <- data.frame(A=factor(c("Hi","match_me","nope")),
                                        B=c(NA, "not_me","nah"))
            

            expect_true(is.na(recode_as_na_str(partial_match,
                                               pattern_type="contains",
                                               pattern="me", 
                                               case_sensitive=FALSE)[[2]][2]))
            expect_false(is.na(recode_as_na_str(partial_match,
                                                pattern_type="ends_with",
                                                pattern="ME", 
                                                case_sensitive=TRUE)[[2]][2]))
            
          expect_warning(recode_as_na_str(partial_match,
                                          pattern_type="contains",
                                          pattern="me", 
                                          case_sensitive=FALSE),
                         "Factor columns converted to character.")
          })
