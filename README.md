# missplore: Missing Data Explorer

As the name suggests, `missplore` is intended to make missing data exploration as smooth and as easy as possible. While several packages exist to handle the same, differences in syntax and preferences will often lead to different people using different packages.

`missplore` therefore hopes to fill this gap by offering a very simple yet robust way to explore missingness. 

## Installation

We can install `missplore` as follows:

```
# install.packages("devtools")
devtools::install_github("Nelson-Gon/missplore")

```

## Currently available functions.

1. `get_na_counts`

This provides a convenient way to show the number of missing values columnwise. It is relatively fast(tests done on about 400,000 rows, took a few microseconds.)

To get the number of missing values in each column of `airquality`, we can use the function as follows:

```
get_na_counts(airquality)

# Ozone Solar.R    Wind    Temp   Month     Day 
# 37       7       0       0       0       0 

```

The above might be less useful if one would like to get the results by group. In that case, one can set `grouped` to `TRUE` and provide a vector of names in `grouping_cols` that will be used for grouping. 

```

test <- structure(list(Subject = structure(c(1L, 1L, 2L, 2L), .Label = c("A", 
"B"), class = "factor"), res = c(NA, 1, 2, 3), ID = structure(c(1L, 
1L, 2L, 2L), .Label = c("1", "2"), class = "factor")), class = "data.frame", row.names = c(NA, 
-4L))

get_na_counts(test, grouped = TRUE, grouping_cols = "ID")

# A tibble: 2 x 3
#  ID    Subject   res
#  <fct>   <int> <int>
#1 1           0     1
#2 2           0     0

```

2. `percent_missing`

This is a very simple to use but quick way to take a look at the percentage of data that is missing columnwise.

```

percent_missing(airquality)
#   Ozone   Solar.R      Wind      Temp     Month       Day 
# 24.183007  4.575163  0.000000  0.000000  0.000000  0.000000 

# I don't want percentages, give me decimals

percent_missing(airquality, percent = FALSE)

#  Ozone    Solar.R       Wind       Temp      Month        Day 
# 0.24183007 0.04575163 0.00000000 0.00000000 0.00000000 0.00000000 



```

Again, we can get the results by group by setting `grouped` to `TRUE`

```
percent_missing(test, grouped = TRUE, grouping_cols = "Subject")

# A tibble: 2 x 3
#  Subject   res    ID
#  <fct>   <dbl> <dbl>
#1 A          50     0
#2 B           0     0

```
