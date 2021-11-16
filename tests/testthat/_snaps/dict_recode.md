# Test Dictionary Style Recoding

    Code
      expect_error(dict_recode(airquality, pattern_type = "ends_with", patterns = c(
        "R", "e"), use_func = "not_mde_function", values = c(190, 41)))

