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


rows_to_drop<- switches(target_value=row_missingness, sign, percent_na)

df[!rows_to_drop, ]

}


