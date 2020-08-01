test_that(desc="Test column based recoding",
          
          code = {
            
            
            skip_on_oldrel()
        pairwise_na <- head(column_based_recode(airquality,criterion = "all_na",
                                values_from = "Temp", values_to="Test",
                                value=420,pattern_type = "contains",
                                pattern = "Solar.R|Ozone"))
      pairwise_na_inplace <- head(column_based_recode(airquality,criterion = "all_na",
                                                values_from = "Temp",
                                                value=420,pattern_type = "contains",
                                                pattern = "Solar.R|Ozone"))
        expect_equal(pairwise_na[5,7], 420)
        expect_true("Test" %in% names(pairwise_na))
        # same name 
        expect_equal(pairwise_na_inplace[5,4], 420)
        
        
          })
            