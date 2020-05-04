#' Drop missing values at columns that match a given pattern
#' @description Provides a simple yet efficient way to drop missing values("NA"s) at
#' columns that match a given pattern.
#' @param df A data.frame object
#' @param pattern_type One of "contains", "ends_with" or "starts_with"
#' @param pattern The type of pattern to use when matching the pattern_type. The pattern is case sensitive
#' @param ... Other params to other methods
#' @inheritParams recode_as_na
#' @return A data.frame object containing only columns that match the given pattern with the missing values removed.
#' @examples
#' head(drop_na_at(airquality,pattern_type = "starts_with","O"))
#' @export

drop_na_at <- function(df, pattern_type="contains",pattern=NULL,
                       case_sensitive=FALSE,...){
  UseMethod("drop_na_at")
}

#' @export

drop_na_at.data.frame <- function(df, pattern_type="contains",pattern=NULL,
                                  case_sensitive=FALSE,...){



if(!is.null(pattern_type)){
    if(any(!pattern_type %in% c("starts_with","ends_with","contains",
                                "regex"))){

      stop("pattern_type should be one of starts_with,ends_with,contains or regex")
    }
    if(is.null(pattern)) stop("A pattern must be supplied.")
    res<-df[recode_selectors(df,pattern_type=pattern_type,pattern=pattern,case_sensitive = case_sensitive,...)]
  }




na_counts <- get_na_counts(res)
na_counts_test <- all(na_counts == unname(na_counts)[1])
if(!na_counts_test){

  stop("Unequal number of missing values, cannot rebind data. Please check with get_na_counts first")

}

final_res <- stats::na.omit(res)
row.names(final_res) <- 1:nrow(final_res)
final_res




}
