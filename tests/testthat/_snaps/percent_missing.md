# percent_missing warns

    Code
      expect_error(percent_missing(as.POSIXct(Sys.Date())))
      expect_error(percent_missing(airquality, grouping_cols = "Nope"))
      expect_error(percent_missing(airquality, exclude_cols = "nope"))

