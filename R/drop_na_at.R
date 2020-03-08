#' Drop missing values at columns that match a given pattern
#' @description Provides a simple yet efficient way to drop missing values("NA"s) at
#' columns that match a given pattern.
#' @param df A data.frame object
#' @param pattern_type One of "contains", "ends_with" or "starts_with"
#' @param pattern The type of pattern to use when matching the pattern_type. The pattern is case sensitive
#' @param ... Other params to other methods
#' @return A data.frame object containing only columns that match the given pattern with the missing values removed.
#' @examples
#' head(drop_na_at(airquality,pattern_type = "starts_with","O"))
#' @export

drop_na_at <- function(df, pattern_type="contains",pattern=NULL,
                       ...){
  UseMethod("drop_na_at")
}

#' @export

drop_na_at.data.frame <- function(df, pattern_type="contains",
                                  pattern=NULL,...){

  # First start with case sensitive
  # Of course you can do this with dplyr/rlang
  # Just trying to stick with base as much as possible
  # First check if all NA sums are equal
  # Confirm user hasn't forgotten to provide a pattern
  if(is.null(pattern)){
    stop("No pattern was provided. Please provide one.")
  }



columns_list <- list(columns_ends_with = df[endsWith(names(df),pattern)],
                     column_starts_with = df[startsWith(names(df),pattern)],
                     column_contains_string = df[grepl(pattern, names(df),...)]
)

res<-switch (pattern_type,
        starts_with = columns_list[[2]],
        ends_with = columns_list[[1]],
        contains = columns_list[[3]])




na_counts <- get_na_counts(res)
na_counts_test <- all(na_counts == unname(na_counts)[1])
if(na_counts_test){
  final_res <- stats::na.omit(res)
  row.names(final_res) <- 1:nrow(final_res)
  final_res
}

else{

  stop("Unequal number of missing values, cannot rebind data. Please check with get_na_counts first")

}


}
