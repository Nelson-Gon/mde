# Check recoding

    Code
      expect_warning(recode_as_na(iris, value = 5.1))
      expect_error(recode_as_na(airquality, value = 0, pattern_type = "contains",
        subset_cols = "Ozone"))
      expect_error(recode_as_na(airquality, value = 0, subset_cols = "nope"))
      expect_error(recode_as_na(airquality, value = 0, pattern_type = "contains"))
      expect_error(recode_as_na(airquality, value = 0, subset_cols = c("Ozone",
        "not in")))
      expect_error(recode_as_na(airquality, value = 190, pattern_type = "gibberish",
        pattern = "R"))

