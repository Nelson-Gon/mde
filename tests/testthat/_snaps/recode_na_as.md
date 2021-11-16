# Check recoding

    Code
      expect_error(recode_na_as(airquality, value = 0, subset_cols = c("Ozone",
        "not in")))
      expect_error(recode_na_as(airquality, 0, subset_cols = "Ozone", pattern_type = "starts_with"))
      expect_error(recode_na_as(airquality, value = 0, pattern_type = "na"))
      expect_error(recode_na_as(airquality, value = 0, pattern_type = "ends_with"))

