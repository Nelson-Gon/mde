# Test na_summary

    Code
      expect_error(na_summary(airquality, pattern_type = "starts_with", pattern = "oz|Sol",
        regex_kind = "random"))
      expect_error(na_summary(airquality, pattern_type = "starts_with", pattern = "oz|Sol",
        exclude_cols = "Solar.R"))
      expect_error(na_summary(airquality, sort_by = "not_in"))
      expect_warning(na_summary(airquality, grouping_cols = c("Month", "Day")))
      expect_error(na_summary(airquality, grouping_cols = "gibberish"))
    Warning <simpleWarning>
      All non grouping values used. Using select non groups is currently not supported

