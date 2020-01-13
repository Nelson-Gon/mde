# Tests that recode_na_if fails if either of the required args is missing
testthat::test_that(desc="recode_na_if errors on absence of args",
                    code={
                      some_data <- data.frame(ID=c("A1","A2","A3", "A4"), 
                                         A=c(5,NA,0,8), B=c(10,0,0,1),
                                      C=c(1,NA,NA,25))
                      
          testthat::expect_error(mde::recode_na_if(some_data,grouping_col="ID"),
                "Need both grouping cols and target_groups.", fixed = TRUE)
                    })