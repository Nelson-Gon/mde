testthat::test_that(desc="Test row dropping",
                    code={
                      
                    # drop rows with at least 50% NAs
    no_percents <- head(drop_row_if(airquality, sign="gteq", percent_na = 0.5, as_percent=FALSE))
    use_percents <- head(drop_row_if(airquality, sign="gteq", percent_na = 50, as_percent=TRUE))
                      
    expect_true(nrow(no_percents) == nrow(use_percents))
    
    expect_error(drop_row_if(airquality,sign="nope", percent_na = 20),
                 "I was expecting one of  gteq lteq gt lt eq not nope",fixed=TRUE)
    
    })