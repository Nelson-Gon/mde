# custom_na_recode works as expected

    Code
      expect_error(custom_na_recode(test_groups, func = "mean", across_columns = "nope"))

