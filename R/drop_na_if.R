#' Conditon based dropping of columns with missing values
#' @description "drop_na_if" provides a simple way to drop columns with missing values if
#' they meet certain criteria/conditions.
#' @param x A data.frame object
#' @param percent_na The percentage to use when dropping columns with missing values
#' @param ... Other arguments to "percent_missing"
#' @param sign Character. One of gteq,lteq,lt,gt or eq which refer to greater than(gt) or equal(eq) or
#' less than(lt) or equal to(eq) respectively.
#' @return A data.frame object with columns  that meet the target criteria dropped
#' @seealso \code{\link{percent_missing}}
#' @examples
#' drop_na_if(airquality, percent_na = 24)
#' #drop columns that have less tan or equal to 4%
#' drop_na_if(airquality,sign="lteq", percent_na = 4)
#' @export

drop_na_if <- function(x, sign="gteq",percent_na= 50,
                       ...){
  UseMethod("drop_na_if")
}

#' @export

drop_na_if.data.frame <- function(x,sign="gteq",percent_na = 50,
                                  ...){
  # Get column missingness
  # First use >= percent_na
  # Can change this later
  # Solution to the above
  # We could use eval and parse but that is frowned upon
  # Instead, we shall use a switch statement which some consider
  # syntactic sugar

to_keep<- switch(sign,
       gteq = names(Filter(function(col_percentage) ! col_percentage >= percent_na ,
                             mde::percent_missing(x,...))),
         lteq = names(Filter(function(col_percentage) ! col_percentage <= percent_na,
                           mde::percent_missing(x,...))),
           gt = names(Filter(function(col_percentage) !col_percentage > percent_na,
                                 mde::percent_missing(x,...))),
              lt = names(Filter(function(col_percentage) ! col_percentage < percent_na,
                                 mde::percent_missing(x,...))),
                eq = names(Filter(function(col_percentage) !
                                     col_percentage == percent_na,
                                mde::percent_missing(x,...))))
x[to_keep]
}



