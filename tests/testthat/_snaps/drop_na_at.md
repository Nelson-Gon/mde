# drop_na_at works as expected

    Code
      expect_error(drop_na_at(airquality, pattern_type = "contains", pattern = "o"))
      expect_error(drop_na_at(airquality, pattern_type = "contains"))
      expect_error(mde::drop_na_at(airquality, pattern_type = "gibberish"))

