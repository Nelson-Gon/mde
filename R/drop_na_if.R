#' Conditon based dropping of columns with missing values
#' @description "drop_na_if" provides a simple way to drop columns with missing values if
#' they meet certain criteria/conditions.
#' @param df A data.frame object
#' @param percent_na The percentage to use when dropping columns with missing values
#' @param ... Other arguments to "percent_missing"
#' @param keep_columns Columns that should be kept despite meeting the target percent_na criterion(criteria)
#' @param sign Character. One of gteq,lteq,lt,gt or eq which refer to greater than(gt) or equal(eq) or
#' less than(lt) or equal to(eq) respectively.
#' @return A data.frame object with columns  that meet the target criteria dropped
#' @seealso \code{\link{percent_missing}}
#' @examples
#' head(drop_na_if(airquality, percent_na = 24))
#' #drop columns that have less tan or equal to 4%
#' head(drop_na_if(airquality,sign="lteq", percent_na = 4))
#' # Drop all except with greater than oe equal to 4% missing but keep Ozone
#' head(drop_na_if(airquality, sign="gteq",percent_na = 4, keep_columns = "Ozone"))
#' @export

drop_na_if <- function(df, sign="gteq",percent_na= 50,
                       keep_columns = NULL,
                       ...){
  UseMethod("drop_na_if")
}

#' @export

drop_na_if.data.frame <- function(df,sign="gteq",percent_na = 50,
                                  keep_columns  = NULL,
                                  ...){

available_options <- c("gteq","lteq","gt","lt","eq")

if(! sign %in% available_options ) {
  stop(paste(paste(c("I was expecting one of ",available_options),collapse=" "),
             "not",
              sign))
}

# get percent missingness

missing_percents <-  percent_missing(df,...)

to_drop<- switch(sign,
       gteq = which(missing_percents >=percent_na),
         lteq =  which(missing_percents <=percent_na),
           gt =  which(missing_percents >percent_na),
              lt = which(missing_percents <percent_na),
                eq = which(missing_percents == percent_na))

if(!is.null(keep_columns)){
  if(!all(keep_columns %in% names(df))){
    stop("All columns to keep should exist in the data set.")
  }
  keep_columns <- which(names(df) %in% keep_columns)

}
to_drop <- setdiff(to_drop, keep_columns)
if(length(to_drop) ==0){
  return(df)
}
df[-to_drop]
}



