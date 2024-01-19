---
title: "Lab 3 Homework"
author: "Christina Chen"
date: "2024-01-19"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

### Mammals Sleep  
1. For this assignment, we are going to use built-in data on mammal sleep patterns. From which publication are these data taken from? Since the data are built-in you can use the help function in R. The name of the data is `msleep`.  

```r
?msleep # data was taken from V. M. Savage and G. B. West. A quantitative, theoretical framework for understanding mammalian sleep. Proceedings of the National Academy of Sciences, 104 (3):1051-1056, 2007.
```

2. Store these data into a new data frame `sleep`.  

```r
sleep <- msleep
```

3. What are the dimensions of this data frame (variables and observations)? How do you know? Please show the *code* that you used to determine this below.  

```r
dim(sleep) # there are 83 rows (observations) and 11 columns (variables)
```

```
## [1] 83 11
```

4. Are there any NAs in the data? How did you determine this? Please show your code.  

```r
glimpse(sleep) # there are several NAs
```

```
## Rows: 83
## Columns: 11
## $ name         <chr> "Cheetah", "Owl monkey", "Mountain beaver", "Greater shor…
## $ genus        <chr> "Acinonyx", "Aotus", "Aplodontia", "Blarina", "Bos", "Bra…
## $ vore         <chr> "carni", "omni", "herbi", "omni", "herbi", "herbi", "carn…
## $ order        <chr> "Carnivora", "Primates", "Rodentia", "Soricomorpha", "Art…
## $ conservation <chr> "lc", NA, "nt", "lc", "domesticated", NA, "vu", NA, "dome…
## $ sleep_total  <dbl> 12.1, 17.0, 14.4, 14.9, 4.0, 14.4, 8.7, 7.0, 10.1, 3.0, 5…
## $ sleep_rem    <dbl> NA, 1.8, 2.4, 2.3, 0.7, 2.2, 1.4, NA, 2.9, NA, 0.6, 0.8, …
## $ sleep_cycle  <dbl> NA, NA, NA, 0.1333333, 0.6666667, 0.7666667, 0.3833333, N…
## $ awake        <dbl> 11.9, 7.0, 9.6, 9.1, 20.0, 9.6, 15.3, 17.0, 13.9, 21.0, 1…
## $ brainwt      <dbl> NA, 0.01550, NA, 0.00029, 0.42300, NA, NA, NA, 0.07000, 0…
## $ bodywt       <dbl> 50.000, 0.480, 1.350, 0.019, 600.000, 3.850, 20.490, 0.04…
```

5. Show a list of the column names is this data frame.

```r
names(sleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```

6. How many herbivores are represented in the data?  

```r
table(sleep$vore) #there are 32 herbivores
```

```
## 
##   carni   herbi insecti    omni 
##      19      32       5      20
```

7. We are interested in two groups; small and large mammals. Let's define small as less than or equal to 19kg body weight and large as greater than or equal to 200kg body weight. Make two new dataframes (large and small) based on these parameters.

```r
large_animals <- filter(sleep, bodywt>=19)
small_animals <- filter(sleep, bodywt<=19)
```

8. What is the mean weight for both the small and large mammals?

```r
mean(large_animals$bodywt)
```

```
## [1] 570.1352
```


```r
mean(small_animals$bodywt)
```

```
## [1] 1.797847
```

9. Using a similar approach as above, do large or small animals sleep longer on average?  


```r
mean(large_animals$sleep_total)
```

```
## [1] 7.108333
```

```r
mean(small_animals$sleep_total)
```

```
## [1] 11.78644
```

It looks like small animals get more sleep on average.

10. Which animal is the sleepiest among the entire dataframe?


```r
filter(sleep, sleep_total>=19)
```

```
## # A tibble: 3 × 11
##   name    genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##   <chr>   <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
## 1 Big br… Epte… inse… Chir… lc                  19.7       3.9       0.117   4.3
## 2 Thick-… Lutr… carni Dide… lc                  19.4       6.6      NA       4.6
## 3 Little… Myot… inse… Chir… <NA>                19.9       2         0.2     4.1
## # ℹ 2 more variables: brainwt <dbl>, bodywt <dbl>
```

The Little brown bat gets the most sleep.

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
