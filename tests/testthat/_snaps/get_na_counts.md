# get_na_counts works as expected

    Code
      expect_error(get_na_counts(as.POSIXct(Sys.Date())))
      expect_error(get_na_counts(airquality, grouping_cols = "Nope"))

