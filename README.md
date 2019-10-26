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

``

