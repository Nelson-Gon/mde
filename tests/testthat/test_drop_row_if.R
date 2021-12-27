test_that(desc="Test row dropping",
                    code={
                      
                      skip_on_oldrel()
                    # drop rows with at least 16% NAs
    no_percents <- head(drop_row_if(airquality, sign="gteq", type="percent",
                                    value = 0.167, as_percent=FALSE))
    use_percents <- head(drop_row_if(airquality, sign="gteq", type="percent",
                                     value = 16.7, as_percent=TRUE))
                      
    expect_true(nrow(no_percents) == nrow(use_percents))
    
   
  
    df <- data.frame(A=1:5, B=c(1,NA,NA,2, 3), C= c(1,NA,NA,2,3))
   
    # Test counts
    expect_equal(nrow(drop_row_if(df,type="count",value=2, sign = "gteq")),3)
    
    expect_snapshot({
      expect_error(drop_row_if(df,type="gibberish"))
      expect_error(drop_row_if(airquality,sign="nope", value = 20))
    })
   
    
    })