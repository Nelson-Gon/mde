#' Conditon based dropping of columns with missing values
#' @description "drop_na_if" provides a simple way to drop columns with missing values if
#' they meet certain criteria/conditions.
#' @param x A data.frame object 
#' @param percent_na The percentage to use when dropping columns with missing values
#' @param ... Other arguments to "percent_missing"
#' @return A data.frame object with columns  that meet the target criteria dropped
#' @details When dropping columns, percent_na is taken as the minimum percentage ie any columns
#' with greater than or equal to percent_na missingness are dropped(currently)
#' @seealso \code{\link{percent_missing}}
#' @examples 
#' drop_na_if(airquality, percent_na = 24)
#' @export

drop_na_if <- function(x,percent_na=50,...){
  UseMethod("drop_na_if")
}

#' @export
 
drop_na_if.data.frame <- function(x, percent_na= 50,...){
  # Get column missingness
  # First use >= percent_na
  # Can change this later
Filter(function(col_percentage) ! col_percentage >=percent_na,
         mde::percent_missing(x,...))
}