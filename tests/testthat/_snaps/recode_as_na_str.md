# Test factor to character conversion and warning message

    Code
      expect_warning(recode_as_na_str(partial_match, pattern_type = "contains",
        pattern = "me", case_sensitive = FALSE))

