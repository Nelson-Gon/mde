# mde: Missing Data Explorer

[![Build Status](https://travis-ci.org/Nelson-Gon/mde.png?branch=master)](https://travis-ci.org/Nelson-Gon/mde) [![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-3.0.html) [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

The acronym `mde` stands for **M**issing **D**ata **E**xplorer, a package that  is intended to make missing data exploration as smooth and easy as possible. 

While several packages exist to handle the same, the author has placed user convenience at the core of design with the sole purpose of enabling anyone to easily and quickly explore missingness in their data without feeling overwhelmed by syntax. The focus is on simplicity, nothing more, nothing less! 

---

**Installation**

We can install `mde` as follows:

```
# install.packages("devtools")
devtools::install_github("Nelson-Gon/mde")
# if dev
devtools::install_github("Nelson-Gon/mde@develop")
# build vignettes
devtools::install_github("Nelson-Gon/mde@develop", 
build_vignettes=TRUE)
# browse vignettes
browseVignettes("mde")

```

---

**Loading the package**

```
library(mde)

```

---

**Currently available functions.**

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

3. `recode_as_na`

As the name might imply, this converts any value or vector of values with `NA` i.e we take a value such as "missing" and convert it to R's known handler for missing values(`NA`).

To use the function out of the box(with default arguments), one simply does something like:

```

dummy_test <- data.frame(ID = c("A","B","B","A"), 
                         values = c("n/a",NA,"Yes","No"))
# Convert n/a to NA
recode_as_na(dummy_test, value = "n/a")
#  ID values
#1  1     NA
#2  2     NA
#3  2      3
#4  1      2

```

Great, but I want to do so for specific columns not the entire dataset. You can do this by setting `subset_df` to `TRUE` and providing column names to `subset_cols`. 

```

another_dummy <- data.frame(ID = 1:5, Subject = 7:11, 
Change = c("missing","n/a",2:4 ))
# Only change values at the column Change
recode_as_na(another_dummy, subset_df = TRUE,
             subset_cols = "Change", value = c("n/a",
                                               "missing"))
                                               
#  ID Subject Change
#1  1       7     NA
#2  2       8     NA
#3  3       9      1
#4  4      10      2
#5  5      11      3

```

4. `sort_by_missingness`

This provides a very simple but relatively fast way to sort variables by missingness. Unless otherwise stated, this does not currently support arranging grouped percents.

Usage:

```

sort_by_missingness(airquality, sort_by = "counts")

#  variable count
#1     Wind     0
#2     Temp     0
#3    Month     0
#4      Day     0
#5  Solar.R     7
#6    Ozone    37

# sort in descending order

sort_by_missingness(airquality, sort_by = "counts",
descend = TRUE)

# variable count
#1    Ozone    37
#2  Solar.R     7
#3     Wind     0
#4     Temp     0
#5    Month     0
#6      Day     0

# Use percents
sort_by_missingness(airquality, sort_by = "percents")
#  variable   percent
#1     Wind  0.000000
#2     Temp  0.000000
#3    Month  0.000000
#4      Day  0.000000
#5  Solar.R  4.575163
#6    Ozone 24.183007

```

5. `recode_na_as`

Sometimes, for whatever reason one would like to replace `NA`s with whatever value they would like. `recode_na_as` provides a very simple way to do just that. 

```
# defaults
head(recode_na_as(airquality))
# Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5     0       0 14.3   56     5   5
#6    28       0 14.9   66     5   6

# use a different value

head(recode_na_as(airquality, value=NaN))
#  Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5   NaN     NaN 14.3   56     5   5
#6    28     NaN 14.9   66     5   6

```

As a "bonus", you can manipulate the data only at specific columns as shown here:

```
head(recode_na_as(airquality, value=0, subset_df=TRUE, subset_cols="Ozone"))

#  Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5     0      NA 14.3   56     5   5
#6    28      NA 14.9   66     5   6

```
The above also supports `tidy` selection as follows:

```
head(mde::recode_na_as(airquality, subset_df=TRUE, tidy=TRUE,
                  value=0, pattern_type="starts_with",
                  pattern="solar",ignore.case=TRUE))
#Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5    NA       0 14.3   56     5   5
#6    28       0 14.9   66     5   6
                  
```

6. `recode_na_if`

Given a `data.frame` object, one can recode `NA`s as another value based on a grouping variable. In the example below, we replace all `NA`s in all columns with 0s if the ID is `A2` or `A3`

```
some_data <- data.frame(ID=c("A1","A2","A3", "A4"), 
                        A=c(5,NA,0,8), B=c(10,0,0,1),
                        C=c(1,NA,NA,25))
                        
recode_na_if(some_data,grouping_col="ID", target_groups=c("A2","A3"),
           replacement= 0)   
# A tibble: 4 x 4
#  ID        A     B     C
#  <fct> <dbl> <dbl> <dbl>
#1 A1        5    10     1
#2 A2        0     0     0
#3 A3        0     0     0
#4 A4        8     1    25

```

7. `drop_na_if`

Suppose you wanted to drop any column that has a percentage of `NA`s greater than or equal to a certain value? `drop_na_if` does just that. 

We can drop any columns that have greater than or equal to 24% of the values missing from `airquality`:

```
drop_na_if(airquality, percent_na = 24)
# Solar.R Wind Temp Month Day
#1       190  7.4   67     5   1
#2       118  8.0   72     5   2
#3       149 12.6   74     5   3
#4       313 11.5   62     5   4

# Use decimals, not percentages

drop_na_if(airquality, percent_na = 0.24, percent = FALSE)
#    Solar.R Wind Temp Month Day
#1       190  7.4   67     5   1
#2       118  8.0   72     5   2
#3       149 12.6   74     5   3
#4       313 11.5   62     5   4
#5        NA 14.3   56     5   5


```

For more information, please see the documentation for `drop_na_if` especially for grouping support.


8. `drop_na_at`

This provides a simple way to drop missing values only at specific columns. It currently only returns those columns with their missing values removed. See usage below. Further details are given in the documentation. It is currently case sensitive. 

```
drop_na_at(airquality,pattern_type = "starts_with","O")

#     Ozone
#1      41
#2      36
#3      12
#4      18
#5      28
#6      23
#7      19

```

---

To raise an issue, please do so [here](https://www.github.com/Nelson-Gon/mde/issues)

Thank you, feedback is always welcome :)
