---
title: 'mde: Missing Data Explorer'
author: "Nelson Gonzabato"
date: "16/12/2019"
output: html_document
---

# mde version 0.1.1

Available functions

1. `get_na_counts`

2. `percent_missing`

3. `recode_as_na`

4. `sort_by_missingness`

5. `recode_na_as`

6. `drop_na_if`

7. `recode_na_if`

8. `drop_na_at`

9. `recode_as_na_for`

Key changes

10. Now supports tidy selection and exploration at specific columns

11. `percent_missing` supports grouping and exclusion of certain columns. The use of decimals was dropped. 

12. `drop_na_if` allows exclusion of columns. 

