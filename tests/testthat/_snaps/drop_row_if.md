# Test row dropping

    Code
      expect_error(drop_row_if(df, type = "gibberish"))
      expect_error(drop_row_if(airquality, sign = "nope", value = 20))

