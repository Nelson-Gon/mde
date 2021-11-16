# recode_na_if errors on absence of args

    Code
      expect_error(mde::recode_na_if(some_data, grouping_col = "ID"))
      expect_error(recode_na_if(some_data, "nuh", c("A2", "A3"), replacement = 0))
      expect_error(recode_na_if(some_data, "ID", c("A2", "no"), replacement = 0))

