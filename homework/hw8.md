---
title: "Homework 8"
author: "Christina Chen"
date: "2024-02-13"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
```

## Install `here`
The package `here` is a nice option for keeping directories clear when loading files. I will demonstrate below and let you decide if it is something you want to use.  

```r
#install.packages("here")
```

## Data
For this homework, we will use a data set compiled by the Office of Environment and Heritage in New South Whales, Australia. It contains the enterococci counts in water samples obtained from Sydney beaches as part of the Beachwatch Water Quality Program. Enterococci are bacteria common in the intestines of mammals; they are rarely present in clean water. So, enterococci values are a measurement of pollution. `cfu` stands for colony forming units and measures the number of viable bacteria in a sample [cfu](https://en.wikipedia.org/wiki/Colony-forming_unit).   

This homework loosely follows the tutorial of [R Ladies Sydney](https://rladiessydney.org/). If you get stuck, check it out!  

1. Start by loading the data `sydneybeaches`. Do some exploratory analysis to get an idea of the data structure.

```r
sydneybeaches <- read_csv("../data/sydneybeaches.csv") %>% clean_names()
```

```
## Rows: 3690 Columns: 8
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (4): Region, Council, Site, Date
## dbl (4): BeachId, Longitude, Latitude, Enterococci (cfu/100ml)
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

If you want to try `here`, first notice the output when you load the `here` library. It gives you information on the current working directory. You can then use it to easily and intuitively load files.

```r
library(here)
```

```
## here() starts at /Users/christic/Desktop/BIS15W2024_cchen
```

The quotes show the folder structure from the root directory.

```r
#sydneybeaches <-read_csv(here("homework", "data", "sydneybeaches.csv")) %>% clean_names()
```

2. Are these data "tidy" per the definitions of the tidyverse? How do you know? Are they in wide or long format?

This is tidy. The columns do not contain observational information. The dataset is in the long format.

3. We are only interested in the variables site, date, and enterococci_cfu_100ml. Make a new object focused on these variables only. Name the object `sydneybeaches_long`


```r
sydneybeaches_long <- sydneybeaches %>%
  select(site, date, enterococci_cfu_100ml)
```

4. Pivot the data such that the dates are column names and each beach only appears once (wide format). Name the object `sydneybeaches_wide`


```r
sydneybeaches_wide <- sydneybeaches_long %>%
  pivot_wider(names_from = "site",
    values_from = "enterococci_cfu_100ml"
  )
```

5. Pivot the data back so that the dates are data and not column names.


```r
sydneybeaches_wide %>%
  pivot_longer(-date,
    names_to = "site",
    values_to = "enterococci_cfu_100ml"
  )
```

```
## # A tibble: 3,784 × 3
##    date       site                    enterococci_cfu_100ml
##    <chr>      <chr>                                   <dbl>
##  1 02/01/2013 Clovelly Beach                             19
##  2 02/01/2013 Coogee Beach                               15
##  3 02/01/2013 Gordons Bay (East)                         NA
##  4 02/01/2013 Little Bay Beach                            9
##  5 02/01/2013 Malabar Beach                               2
##  6 02/01/2013 Maroubra Beach                              1
##  7 02/01/2013 South Maroubra Beach                        1
##  8 02/01/2013 South Maroubra Rockpool                    12
##  9 02/01/2013 Bondi Beach                                 3
## 10 02/01/2013 Bronte Beach                                4
## # ℹ 3,774 more rows
```

6. We haven't dealt much with dates yet, but separate the date into columns day, month, and year. Do this on the `sydneybeaches_long` data.


```r
sydneybeaches_long %>%
  separate(date, into=c("day", "month", "year"), sep="/")
```

```
## # A tibble: 3,690 × 5
##    site           day   month year  enterococci_cfu_100ml
##    <chr>          <chr> <chr> <chr>                 <dbl>
##  1 Clovelly Beach 02    01    2013                     19
##  2 Clovelly Beach 06    01    2013                      3
##  3 Clovelly Beach 12    01    2013                      2
##  4 Clovelly Beach 18    01    2013                     13
##  5 Clovelly Beach 30    01    2013                      8
##  6 Clovelly Beach 05    02    2013                      7
##  7 Clovelly Beach 11    02    2013                     11
##  8 Clovelly Beach 23    02    2013                     97
##  9 Clovelly Beach 07    03    2013                      3
## 10 Clovelly Beach 25    03    2013                      0
## # ℹ 3,680 more rows
```

7. What is the average `enterococci_cfu_100ml` by year for each beach. Think about which data you will use- long or wide.


```r
sydneybeaches_long %>%
  separate(date, into=c("day", "month", "year"), sep="/") %>%
  group_by(year, site) %>%
  summarise(mean_cfu = mean(enterococci_cfu_100ml, na.r = T))
```

```
## `summarise()` has grouped output by 'year'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 66 × 3
## # Groups:   year [6]
##    year  site                    mean_cfu
##    <chr> <chr>                      <dbl>
##  1 2013  Bondi Beach                32.2 
##  2 2013  Bronte Beach               26.8 
##  3 2013  Clovelly Beach              9.28
##  4 2013  Coogee Beach               39.7 
##  5 2013  Gordons Bay (East)         24.8 
##  6 2013  Little Bay Beach          122.  
##  7 2013  Malabar Beach             101.  
##  8 2013  Maroubra Beach             47.1 
##  9 2013  South Maroubra Beach       39.3 
## 10 2013  South Maroubra Rockpool    96.4 
## # ℹ 56 more rows
```

8. Make the output from question 7 easier to read by pivoting it to wide format.


```r
sydneybeaches_long %>%
  separate(date, into=c("day", "month", "year"), sep="/") %>%
  group_by(year, site) %>%
  summarise(mean_cfu = mean(enterococci_cfu_100ml, na.rm = T)) %>%
  pivot_wider(
    names_from = site,
    values_from = mean_cfu
  )
```

```
## `summarise()` has grouped output by 'year'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 6 × 12
## # Groups:   year [6]
##   year  `Bondi Beach` `Bronte Beach` `Clovelly Beach` `Coogee Beach`
##   <chr>         <dbl>          <dbl>            <dbl>          <dbl>
## 1 2013           32.2           26.8             9.28           39.7
## 2 2014           11.1           17.5            13.8            52.6
## 3 2015           14.3           23.6             8.82           40.3
## 4 2016           19.4           61.3            11.3            59.5
## 5 2017           13.2           16.8             7.93           20.7
## 6 2018           22.9           43.4            10.6            21.6
## # ℹ 7 more variables: `Gordons Bay (East)` <dbl>, `Little Bay Beach` <dbl>,
## #   `Malabar Beach` <dbl>, `Maroubra Beach` <dbl>,
## #   `South Maroubra Beach` <dbl>, `South Maroubra Rockpool` <dbl>,
## #   `Tamarama Beach` <dbl>
```

9. What was the most polluted beach in 2013?


```r
sydneybeaches_long %>%
  separate(date, into=c("day", "month", "year"), sep="/") %>%
  filter(year == 2013) %>%
  arrange(desc(enterococci_cfu_100ml)) %>%
  head(1)
```

```
## # A tibble: 1 × 5
##   site             day   month year  enterococci_cfu_100ml
##   <chr>            <chr> <chr> <chr>                 <dbl>
## 1 Little Bay Beach 30    06    2013                   4900
```

10. Please complete the class project survey at: [BIS 15L Group Project](https://forms.gle/H2j69Z3ZtbLH3efW6)

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
