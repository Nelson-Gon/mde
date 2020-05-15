testthat::test_that(desc="sorting only by columns or percents",
                    code={

                    expect_error(mde::sort_by_missingness(airquality,
                                                                      sort_by="gibberish"),
                                             "sort_by should be one of counts or percents",
                                             fixed=TRUE)

                    expect_equal(sort_by_missingness(airquality, descend = TRUE)[1,2],
                                             37)
                      expect_equal(sort_by_missingness(airquality, descend = FALSE)[1,2],
                                             0)
                     expect_equal(as.character(mde::sort_by_missingness(airquality,sort_by="percents",descend=TRUE)[[1]][1]),
                                            "Ozone")
                    })
