# Tidy recoding
recode_starts_with <- function(x,pattern,original_value,
                               new_value,...){
x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::starts_with(match = pattern,
                                        ignore.case = TRUE,
                                                    ...)),
                     function(y) ifelse(y %in% original_value ,
                                        new_value,
                                        y))
}
recode_ends_with <- function(x,pattern,original_value,new_value,
                             ...){
  x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::ends_with(match = pattern,
                                                    ignore.case = TRUE,
                                                    ...)),
            function(y) ifelse(y %in% original_value ,new_value,
                                        y))
}
recode_contains<- function(x,pattern,original_value,new_value,
                           ...){
  x %>%
    dplyr::mutate_at(dplyr::vars(dplyr::contains(match = pattern,
                                        ignore.case = TRUE,
                                                    ...)),
              function(y) ifelse(y %in% original_value ,new_value,
                                        y))
}