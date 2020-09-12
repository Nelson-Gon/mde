test_that(desc="drop_all_na errors on absent columns",
                    code={

                      skip_on_oldrel()

                      test2 <- data.frame(ID= c("A","A","B","A","B"),
                                          Vals = rep(NA, 5))

                    expect_error(drop_all_na(test2,
                                        grouping_cols = c("ID","non_existant")),
                                        "All columns to group by should exist in the data set.",
                                        fixed=TRUE)
                    test <- data.frame(ID= c("A","A","B","A","B"), Vals = c(rep(NA,4),2))

                    expect_equal(nrow(drop_all_na(test, grouping_cols = "ID")),2)
                    expect_false("Vals" %in% names(drop_all_na(test2)))
                    expect_equal(ncol(mde::drop_all_na(test2)),1)

                    })
