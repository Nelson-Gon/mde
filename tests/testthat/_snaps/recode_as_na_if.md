# Test condition based NA recoding

    Code
      expect_error(head(recode_as_na_if(airquality, sign = "gibberish", percent_na = 20)))

