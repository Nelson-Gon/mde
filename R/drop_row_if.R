#' Conditionally drop rows based on percent missingness
#' @inheritParams drop_na_if
#' @param as_percent Logical. If set to TRUE, percent_na is treated as a percentage. Otherwise, decimals(fractions) are
#' used.
#' @param type One of either count or percent. Defaults to count
#' @param value Value to use for the drop. 
#' @examples
#' head(drop_row_if(airquality,sign = "gteq",
#' type = "percent",value=16, as_percent = TRUE))
#' # should give the same output as above.
#' head(drop_row_if(airquality, sign="gteq", type="percent",value = 0.15, as_percent=FALSE))
#' # Drop based on NA counts
#' df <- data.frame(A=1:5, B=c(1,NA,NA,2, 3), C= c(1,NA,NA,2,3))
#' drop_row_if(df, type="count",value=2,sign="eq")
#' @export
drop_row_if<- function(df, sign="gt",type="count",value=20,as_percent=TRUE){
  UseMethod("drop_row_if")
}

#' @export

drop_row_if.data.frame <- function(df, sign="gt",type="count",value=20,as_percent=TRUE){

unexpected_argument(type ,c("percent","count"))

row_missingness <- rowSums(is.na(df))   
if(type=="percent"){
row_missingness <- if(as_percent) rowMeans(is.na(df)) * 100 else rowMeans(is.na(df))
}

rows_to_drop<- switches(target_value=row_missingness, sign, value)

res <-df[!rows_to_drop, ]
msg <- if(nrow(df)-nrow(res)==1) " row." else " rows."
message(paste0("Dropped ", nrow(df)-nrow(res),msg))
res

}


