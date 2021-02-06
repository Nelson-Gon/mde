#' Sort Variables according to missingness
#' @description Provides a useful way to sort the variables(columns) according
#' to their missingness.
#' @inheritParams get_na_counts
#' @importFrom utils stack
#' @param sort_by One of counts or percents. This determines whether the results are sorted by counts or percentages.
#' @param descending Logical. Should missing values be sorted in decreasing order ie largest to smallest? Defaults to FALSE.
#' @param ... Other arguments to specific functions. See "See also below"
#' @return A `data.frame` object sorted by number/percentage of missing values
#' @examples
#' sort_by_missingness(airquality, sort_by = "counts")
#' # sort by percents
#' sort_by_missingness(airquality, sort_by="percents")
#' # descending order
#' sort_by_missingness(airquality, descend = TRUE)
#' @seealso \code{\link{get_na_counts}} \code{\link{percent_missing}}
#' @export
# Might as well just give classes to the package's "objects"
# That would make it easier to just define a new sort method
# Would require a lot of time to give classes, decided to write it
# From "scratch"
sort_by_missingness <- function(x, sort_by = "counts",
                                descending = FALSE, ...){
  UseMethod("sort_by_missingness")
}

#' @export
# This will fail for grouped percentages
sort_by_missingness.data.frame <- function(x, sort_by = "counts",
                                        descending = FALSE,
                                        ...){
  
unexpected_argument(sort_by,c("counts", "percents"))

use_df <-get_na_counts(x,...)

if(sort_by=="percents") use_df <- percent_missing(x,...)


res <- use_df[do.call(order, list(use_df, decreasing=descending))]


# Make result more "sensible" res -h

res_stacked <- unname(stack(res)[,c(2,1)])
names(res_stacked) <- c("variable","percent") 
res_stacked


}

