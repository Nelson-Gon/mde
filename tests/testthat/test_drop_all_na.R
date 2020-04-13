testthat::test_that(desc="drop_all_na errors on absent columns",
                    code={
                      test2 <- data.frame(ID= c("A","A","B","A","B"), 
                                          Vals = rep(NA, 5))
                    
                    testthat::expect_error(drop_all_na(test2,
                                        grouping_cols = c("ID","non_existant")),
                                        "All grouping columns should exist in the dataset.",
                                        fixed=TRUE)
                      
                    })