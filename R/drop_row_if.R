#' Conditionally drop rows based on percent missingness
#' @inheritParams drop_na_if
#' @param as_percent Logical. If set to TRUE, percent_na is treated as a percentage. Otherwise, decimals(fractions) are 
#' used. 
#' @examples 
#' head(drop_row_if(airquality, sign="gteq", percent_na = 50))
#' # should give the same output as above. 
#' head(drop_row_if(airquality, sign="gteq", percent_na = 0.5, as_percent=FALSE))
#' @export 
drop_row_if<- function(df, sign="gt", percent_na=20, as_percent=TRUE){
  UseMethod("drop_row_if")
}

#' @export 

drop_row_if.data.frame <- function(df, sign="gt", percent_na=20, as_percent=TRUE){
row_missingness <- rowMeans(is.na(df)) 
if(as_percent) row_missingness <- row_missingness * 100
rows_to_drop<- switch(sign,
                   gteq = row_missingness >=percent_na,
                   lteq =  row_missingness <=percent_na,
                   gt =  row_missingness >percent_na,
                   lt =  row_missingness <percent_na,
                   eq =  row_missingness == percent_na)

df[!rows_to_drop, ]

}


