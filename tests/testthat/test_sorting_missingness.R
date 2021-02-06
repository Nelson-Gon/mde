testthat::test_that(desc="sorting only by columns or percents",
                    code={

                      skip_on_oldrel()

        expect_error(mde::sort_by_missingness(airquality,
                                           sort_by="gibberish"),
                       "Use either counts or percents not gibberish",
                                         fixed=TRUE)
                    
                    
            expect_equal(sort_by_missingness(airquality, 
                                                     descend = TRUE)[1,2],
                                             37)
        expect_equal(sort_by_missingness(airquality, descend = FALSE)[1,2],
                                   0)
      expect_equal(as.character(mde::sort_by_missingness(airquality,
                    sort_by="percents",descend=TRUE)[[1]][1]),
                           "Ozone")
                    })
