# drop_all_na errors on absent columns

    Code
      expect_error(drop_all_na(test2, grouping_cols = c("ID", "non_existant")))

