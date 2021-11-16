# test recode_as_na_for

    Code
      expect_error(recode_as_na_for(airquality, criteria = "gibberish"))
      expect_error(recode_as_na_for(airquality, subset_cols = "gibberish"))

