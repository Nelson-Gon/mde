testthat::test_that(desc="drop_na_if errors as expected",
                    code = 
                      {
                        
                testthat::expect_error(drop_na_if(airquality,sign="nope"),
                        "I was expecting one of  gteq lteq gt lt eq not nope",
                        fixed=TRUE)
    
                      })