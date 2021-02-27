#' Condition based dropping of columns with missing values
#' @importFrom dplyr droup_by, filter, ungroup, across, everything, mutate
#' @description "drop_na_if" provides a simple way to drop columns with missing 
#' values if
#' they meet certain criteria/conditions.
#' @param df A data.frame object
#' @param percent_na The percentage to use when dropping columns with missing 
#' values
#' @param grouping_cols For dropping groups that meet a target criterion of 
#' percent missingness. 
#' @param target_columns If working on grouped data, drop all columns that meet 
#' target or only a specific column. 
#' @param ... Other arguments to "percent_missing"
#' @param keep_columns Columns that should be kept despite meeting the target 
#' percent_na 
#' criterion(criteria)
#' @param sign Character. One of gteq,lteq,lt,gt or eq which refer to greater 
#' than(gt) or equal(eq) or
#' less than(lt) or equal to(eq) respectively.
#' @return A data.frame object with columns  that meet the target criteria 
#' dropped. 
#' @seealso \code{\link{percent_missing}}
#' @examples
#' head(drop_na_if(airquality, percent_na = 24))
#' #drop columns that have less tan or equal to 4%
#' head(drop_na_if(airquality,sign="lteq", percent_na = 4))
#' # Drop all except with greater than ie equal to 4% missing but keep Ozone
#' head(drop_na_if(airquality, sign="gteq",percent_na = 4, 
#' keep_columns = "Ozone"))
#' # Drop groups that meet a given criterion
#' grouped_drop <- structure(list(ID = c("A", "A", "B", "A", "B"), Vals = c(4, NA, 
#' NA, NA, NA), Values = c(5, 6, 7, 8, NA)), row.names = c(NA, -5L),
#'  class = "data.frame")
#'  drop_na_if(grouped_drop,percent_na = 67,grouping_cols = "ID")
#' @export

drop_na_if <- function(df, sign="gteq",percent_na= 50,
                       keep_columns=NULL,
                       grouping_cols=NULL, 
                       target_columns=NULL,...){
  UseMethod("drop_na_if")
}

#' @export

drop_na_if.data.frame <- function(df, sign="gteq",percent_na= 50,
                                  keep_columns=NULL,
                                  grouping_cols=NULL, 
                                  target_columns=NULL,...){
  
  



# If we have grouping columns, use those instead
if(!is.null(grouping_cols)){
check_column_existence(df, grouping_cols,"to group by")

# Drop everything for now.
#use_column <- if(is.null(target_column)) everything() else 
#!!!dplyr::syms(target_column)

df %>% 
    dplyr::group_by(!!!dplyr::syms(grouping_cols)) %>% 
    dplyr::filter(across(everything(), ~!switches(mean(is.na(.)) * 100,
                                    sign=sign,
                                    percent_na=percent_na))) %>% 
    dplyr::ungroup()
}



else{

# get percent missing
missing_percents <- percent_missing(df,...)
#Drop as required
to_drop <- switches(target_value=missing_percents,sign,percent_na)
if(!is.null(keep_columns)){
    
check_column_existence(df,target_columns = keep_columns, 
                       unique_name = "to keep")
    
keep_columns <- which(names(df) %in% keep_columns)
    
}
to_drop <- setdiff(to_drop, keep_columns)
  
if(length(to_drop) ==0) return(df)
  
df[-to_drop]
}
}


