# drop_na_if errors as expected

    Code
      expect_error(drop_na_if(airquality, sign = "nope"))
      expect_error(drop_na_if(grouped_drop, percent_na = 67, sign = "lteq",
        grouping_cols = "gibberish"))
      expect_error(drop_na_if(grouped_drop, sign = "lteq", percent_na = 20,
        grouping_cols = "ID", target_columns = "Values", keep_columns = "Vals"))

