---
title: "Lab 7 Homework"
author: "Christina Chen"
date: "2024-02-01"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries <- readr::read_csv(file = "data/FAO_1950to2012_111914.csv")
```

```
## Rows: 17692 Columns: 71
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (69): Country, Common name, ISSCAAP taxonomic group, ASFIS species#, ASF...
## dbl  (2): ISSCAAP group#, FAO major fishing area
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
names(fisheries)
```

```
##  [1] "Country"                 "Common name"            
##  [3] "ISSCAAP group#"          "ISSCAAP taxonomic group"
##  [5] "ASFIS species#"          "ASFIS species name"     
##  [7] "FAO major fishing area"  "Measure"                
##  [9] "1950"                    "1951"                   
## [11] "1952"                    "1953"                   
## [13] "1954"                    "1955"                   
## [15] "1956"                    "1957"                   
## [17] "1958"                    "1959"                   
## [19] "1960"                    "1961"                   
## [21] "1962"                    "1963"                   
## [23] "1964"                    "1965"                   
## [25] "1966"                    "1967"                   
## [27] "1968"                    "1969"                   
## [29] "1970"                    "1971"                   
## [31] "1972"                    "1973"                   
## [33] "1974"                    "1975"                   
## [35] "1976"                    "1977"                   
## [37] "1978"                    "1979"                   
## [39] "1980"                    "1981"                   
## [41] "1982"                    "1983"                   
## [43] "1984"                    "1985"                   
## [45] "1986"                    "1987"                   
## [47] "1988"                    "1989"                   
## [49] "1990"                    "1991"                   
## [51] "1992"                    "1993"                   
## [53] "1994"                    "1995"                   
## [55] "1996"                    "1997"                   
## [57] "1998"                    "1999"                   
## [59] "2000"                    "2001"                   
## [61] "2002"                    "2003"                   
## [63] "2004"                    "2005"                   
## [65] "2006"                    "2007"                   
## [67] "2008"                    "2009"                   
## [69] "2010"                    "2011"                   
## [71] "2012"
```


```r
dim(fisheries)
```

```
## [1] 17692    71
```


```r
glimpse(fisheries)
```

```
## Rows: 17,692
## Columns: 71
## $ Country                   <chr> "Albania", "Albania", "Albania", "Albania", …
## $ `Common name`             <chr> "Angelsharks, sand devils nei", "Atlantic bo…
## $ `ISSCAAP group#`          <dbl> 38, 36, 37, 45, 32, 37, 33, 45, 38, 57, 33, …
## $ `ISSCAAP taxonomic group` <chr> "Sharks, rays, chimaeras", "Tunas, bonitos, …
## $ `ASFIS species#`          <chr> "10903XXXXX", "1750100101", "17710001XX", "2…
## $ `ASFIS species name`      <chr> "Squatinidae", "Sarda sarda", "Sphyraena spp…
## $ `FAO major fishing area`  <dbl> 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, …
## $ Measure                   <chr> "Quantity (tonnes)", "Quantity (tonnes)", "Q…
## $ `1950`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1951`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1952`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1953`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1954`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1955`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1956`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1957`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1958`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1959`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1960`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1961`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1962`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1963`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1964`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1965`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1966`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1967`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1968`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1969`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1970`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1971`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1972`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1973`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1974`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1975`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1976`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1977`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1978`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1979`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1980`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1981`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1982`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1983`                    <chr> NA, NA, NA, NA, NA, NA, "559", NA, NA, NA, N…
## $ `1984`                    <chr> NA, NA, NA, NA, NA, NA, "392", NA, NA, NA, N…
## $ `1985`                    <chr> NA, NA, NA, NA, NA, NA, "406", NA, NA, NA, N…
## $ `1986`                    <chr> NA, NA, NA, NA, NA, NA, "499", NA, NA, NA, N…
## $ `1987`                    <chr> NA, NA, NA, NA, NA, NA, "564", NA, NA, NA, N…
## $ `1988`                    <chr> NA, NA, NA, NA, NA, NA, "724", NA, NA, NA, N…
## $ `1989`                    <chr> NA, NA, NA, NA, NA, NA, "583", NA, NA, NA, N…
## $ `1990`                    <chr> NA, NA, NA, NA, NA, NA, "754", NA, NA, NA, N…
## $ `1991`                    <chr> NA, NA, NA, NA, NA, NA, "283", NA, NA, NA, N…
## $ `1992`                    <chr> NA, NA, NA, NA, NA, NA, "196", NA, NA, NA, N…
## $ `1993`                    <chr> NA, NA, NA, NA, NA, NA, "150 F", NA, NA, NA,…
## $ `1994`                    <chr> NA, NA, NA, NA, NA, NA, "100 F", NA, NA, NA,…
## $ `1995`                    <chr> "0 0", "1", NA, "0 0", "0 0", NA, "52", "30"…
## $ `1996`                    <chr> "53", "2", NA, "3", "2", NA, "104", "8", NA,…
## $ `1997`                    <chr> "20", "0 0", NA, "0 0", "0 0", NA, "65", "4"…
## $ `1998`                    <chr> "31", "12", NA, NA, NA, NA, "220", "18", NA,…
## $ `1999`                    <chr> "30", "30", NA, NA, NA, NA, "220", "18", NA,…
## $ `2000`                    <chr> "30", "25", "2", NA, NA, NA, "220", "20", NA…
## $ `2001`                    <chr> "16", "30", NA, NA, NA, NA, "120", "23", NA,…
## $ `2002`                    <chr> "79", "24", NA, "34", "6", NA, "150", "84", …
## $ `2003`                    <chr> "1", "4", NA, "22", NA, NA, "84", "178", NA,…
## $ `2004`                    <chr> "4", "2", "2", "15", "1", "2", "76", "285", …
## $ `2005`                    <chr> "68", "23", "4", "12", "5", "6", "68", "150"…
## $ `2006`                    <chr> "55", "30", "7", "18", "8", "9", "86", "102"…
## $ `2007`                    <chr> "12", "19", NA, NA, NA, NA, "132", "18", NA,…
## $ `2008`                    <chr> "23", "27", NA, NA, NA, NA, "132", "23", NA,…
## $ `2009`                    <chr> "14", "21", NA, NA, NA, NA, "154", "20", NA,…
## $ `2010`                    <chr> "78", "23", "7", NA, NA, NA, "80", "228", NA…
## $ `2011`                    <chr> "12", "12", NA, NA, NA, NA, "88", "9", NA, "…
## $ `2012`                    <chr> "5", "5", NA, NA, NA, NA, "129", "290", NA, …
```

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries <- clean_names(fisheries)
```


```r
fisheries$country <- as.factor(fisheries$country)
fisheries$isscaap_group_number <- as.factor(fisheries$isscaap_group_number)
fisheries$asfis_species_number <- as.factor(fisheries$asfis_species_number)
fisheries$fao_major_fishing_area <- as.factor(fisheries$fao_major_fishing_area)
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!  

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
table(fisheries_tidy$country)
```

```
## 
##                   Albania                   Algeria            American Samoa 
##                       934                      1561                       556 
##                    Angola                  Anguilla       Antigua and Barbuda 
##                      2119                       129                       356 
##                 Argentina                     Aruba                 Australia 
##                      3403                       172                      8183 
##                   Bahamas                   Bahrain                Bangladesh 
##                       423                      1169                       169 
##                  Barbados                   Belgium                    Belize 
##                       795                      2530                      1075 
##                     Benin                   Bermuda  Bonaire/S.Eustatius/Saba 
##                      1419                       846                         4 
##    Bosnia and Herzegovina                    Brazil  British Indian Ocean Ter 
##                        21                      4784                        97 
##    British Virgin Islands         Brunei Darussalam                  Bulgaria 
##                       332                       186                      1596 
##                Cabo Verde                  Cambodia                  Cameroon 
##                       462                       238                      1340 
##                    Canada            Cayman Islands           Channel Islands 
##                      5099                        84                      1313 
##                     Chile                     China      China, Hong Kong SAR 
##                      3878                      2801                      1782 
##          China, Macao SAR                  Colombia                   Comoros 
##                       206                      2710                       965 
##   Congo, Dem. Rep. of the        Congo, Republic of              Cook Islands 
##                       484                      1527                       810 
##                Costa Rica                   Croatia                      Cuba 
##                      1171                       947                      2981 
##                Cura\xe7ao                    Cyprus          C\xf4te d'Ivoire 
##                        18                      1703                      1859 
##                   Denmark                  Djibouti                  Dominica 
##                      3741                       352                       213 
##        Dominican Republic                   Ecuador                     Egypt 
##                      1958                      1595                      2467 
##               El Salvador         Equatorial Guinea                   Eritrea 
##                       620                       551                       653 
##                   Estonia                  Ethiopia    Falkland Is.(Malvinas) 
##                      1088                       129                       502 
##             Faroe Islands         Fiji, Republic of                   Finland 
##                      2283                      1798                       706 
##                    France             French Guiana          French Polynesia 
##                     10639                       231                       672 
##      French Southern Terr                     Gabon                    Gambia 
##                       139                      1089                      1214 
##                   Georgia                   Germany                     Ghana 
##                       428                      4813                      2462 
##                 Gibraltar                    Greece                 Greenland 
##                        61                      4091                      1311 
##                   Grenada                Guadeloupe                      Guam 
##                      1635                       372                       520 
##                 Guatemala                    Guinea              GuineaBissau 
##                       622                       697                       634 
##                    Guyana                     Haiti                  Honduras 
##                       251                       204                       842 
##                   Iceland                     India                 Indonesia 
##                      2346                      5588                      9274 
##    Iran (Islamic Rep. of)                      Iraq                   Ireland 
##                      1210                       150                      3235 
##               Isle of Man                    Israel                     Italy 
##                       952                      1359                      4567 
##                   Jamaica                     Japan                    Jordan 
##                       149                     15429                       226 
##                     Kenya                  Kiribati  Korea, Dem. People's Rep 
##                       958                       875                       210 
##        Korea, Republic of                    Kuwait                    Latvia 
##                     10824                       805                      1101 
##                   Lebanon                   Liberia                     Libya 
##                       614                      1514                       578 
##                 Lithuania                Madagascar                  Malaysia 
##                      1274                      1008                      6963 
##                  Maldives                     Malta          Marshall Islands 
##                       487                      2156                       292 
##                Martinique                Mauritania                 Mauritius 
##                       672                      1501                       991 
##                   Mayotte                    Mexico Micronesia, Fed.States of 
##                       194                      6202                       413 
##                    Monaco                Montenegro                Montserrat 
##                        43                       168                        63 
##                   Morocco                Mozambique                   Myanmar 
##                      4758                       434                       117 
##                   Namibia                     Nauru               Netherlands 
##                       905                       150                      2944 
##      Netherlands Antilles             New Caledonia               New Zealand 
##                       338                       789                      4594 
##                 Nicaragua                   Nigeria                      Niue 
##                       904                      1479                       145 
##            Norfolk Island      Northern Mariana Is.                    Norway 
##                        41                       488                      3747 
##                      Oman                 Other nei                  Pakistan 
##                      1086                      1556                      2166 
##                     Palau   Palestine, Occupied Tr.                    Panama 
##                       636                       429                      1773 
##          Papua New Guinea                      Peru               Philippines 
##                       686                      2767                      4548 
##          Pitcairn Islands                    Poland                  Portugal 
##                        63                      2553                     11570 
##               Puerto Rico                     Qatar                   Romania 
##                       918                       941                      1738 
##        Russian Federation                R\xe9union       Saint Barth\xe9lemy 
##                      4736                       736                         6 
##              Saint Helena     Saint Kitts and Nevis               Saint Lucia 
##                       609                       397                       558 
##  Saint Vincent/Grenadines               SaintMartin                     Samoa 
##                       715                         6                       386 
##     Sao Tome and Principe              Saudi Arabia                   Senegal 
##                      1035                      2200                      2988 
##     Serbia and Montenegro                Seychelles              Sierra Leone 
##                       516                      1142                      1526 
##                 Singapore              Sint Maarten                  Slovenia 
##                      1937                         4                       644 
##           Solomon Islands                   Somalia              South Africa 
##                       505                       141                      3881 
##                     Spain                 Sri Lanka   St. Pierre and Miquelon 
##                     17482                      1351                      1038 
##                     Sudan            Sudan (former)                  Suriname 
##                         3                        90                       234 
##    Svalbard and Jan Mayen                    Sweden      Syrian Arab Republic 
##                        41                      3115                       793 
##  Taiwan Province of China  Tanzania, United Rep. of                  Thailand 
##                      9927                      1277                      4843 
##                TimorLeste                      Togo                   Tokelau 
##                        98                      1723                       102 
##                     Tonga       Trinidad and Tobago                   Tunisia 
##                       403                       923                      3019 
##                    Turkey      Turks and Caicos Is.                    Tuvalu 
##                      3326                       193                       162 
##                   Ukraine        Un. Sov. Soc. Rep.      United Arab Emirates 
##                      1823                      7084                      1801 
##            United Kingdom  United States of America                   Uruguay 
##                      6577                     18080                      2134 
##         US Virgin Islands                   Vanuatu   Venezuela, Boliv Rep of 
##                       348                       789                      3409 
##                  Viet Nam     Wallis and Futuna Is.            Western Sahara 
##                       405                       128                         0 
##                     Yemen            Yugoslavia SFR                  Zanzibar 
##                      1278                      1383                       247
```

4. Refocus the data only to include country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
fisheries_tidy %>%
  select(country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch)
```

```
## # A tibble: 376,771 × 6
##    country isscaap_taxonomic_group asfis_species_name asfis_species_number  year
##    <fct>   <chr>                   <chr>              <fct>                <dbl>
##  1 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1995
##  2 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1996
##  3 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1997
##  4 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1998
##  5 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1999
##  6 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2000
##  7 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2001
##  8 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2002
##  9 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2003
## 10 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2004
## # ℹ 376,761 more rows
## # ℹ 1 more variable: catch <dbl>
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
fisheries_tidy %>%
  summarize(distinct_fish_species = n_distinct(asfis_species_number))
```

```
## # A tibble: 1 × 1
##   distinct_fish_species
##                   <int>
## 1                  1551
```

6. Which country had the largest overall catch in the year 2000?

```r
fisheries_tidy %>%
  filter(year == 2000) %>%
  arrange(desc(catch))
```

```
## # A tibble: 8,793 × 10
##    country               common_name isscaap_group_number isscaap_taxonomic_gr…¹
##    <fct>                 <chr>       <fct>                <chr>                 
##  1 China                 Marine fis… 39                   Marine fishes not ide…
##  2 Peru                  Anchoveta(… 35                   Herrings, sardines, a…
##  3 Russian Federation    Alaska pol… 32                   Cods, hakes, haddocks 
##  4 Viet Nam              Marine fis… 39                   Marine fishes not ide…
##  5 Chile                 Chilean ja… 37                   Miscellaneous pelagic…
##  6 China                 Marine mol… 58                   Miscellaneous marine …
##  7 China                 Largehead … 34                   Miscellaneous demersa…
##  8 United States of Ame… Alaska pol… 32                   Cods, hakes, haddocks 
##  9 China                 Marine cru… 47                   Miscellaneous marine …
## 10 Philippines           Scads nei   37                   Miscellaneous pelagic…
## # ℹ 8,783 more rows
## # ℹ abbreviated name: ¹​isscaap_taxonomic_group
## # ℹ 6 more variables: asfis_species_number <fct>, asfis_species_name <chr>,
## #   fao_major_fishing_area <fct>, measure <chr>, year <dbl>, catch <dbl>
```

7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?

```r
fisheries_tidy %>%
  filter(between(year, 1990, 2000), asfis_species_name == "Sardina pilchardus") %>%
  arrange(desc(catch))
```

```
## # A tibble: 336 × 10
##    country            common_name    isscaap_group_number isscaap_taxonomic_gr…¹
##    <fct>              <chr>          <fct>                <chr>                 
##  1 Morocco            European pilc… 35                   Herrings, sardines, a…
##  2 Morocco            European pilc… 35                   Herrings, sardines, a…
##  3 Spain              European pilc… 35                   Herrings, sardines, a…
##  4 Morocco            European pilc… 35                   Herrings, sardines, a…
##  5 Morocco            European pilc… 35                   Herrings, sardines, a…
##  6 Morocco            European pilc… 35                   Herrings, sardines, a…
##  7 Morocco            European pilc… 35                   Herrings, sardines, a…
##  8 Morocco            European pilc… 35                   Herrings, sardines, a…
##  9 Russian Federation European pilc… 35                   Herrings, sardines, a…
## 10 Russian Federation European pilc… 35                   Herrings, sardines, a…
## # ℹ 326 more rows
## # ℹ abbreviated name: ¹​isscaap_taxonomic_group
## # ℹ 6 more variables: asfis_species_number <fct>, asfis_species_name <chr>,
## #   fao_major_fishing_area <fct>, measure <chr>, year <dbl>, catch <dbl>
```

8. Which five countries caught the most cephalopods between 2008-2012?

```r
fisheries_tidy %>%
  filter(between(year, 2008, 2012), asfis_species_name == "Cephalopoda") %>%
  arrange(desc(catch))
```

```
## # A tibble: 80 × 10
##    country common_name     isscaap_group_number isscaap_taxonomic_group        
##    <fct>   <chr>           <fct>                <chr>                          
##  1 India   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
##  2 India   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
##  3 India   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
##  4 China   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
##  5 China   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
##  6 Italy   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
##  7 India   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
##  8 India   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
##  9 India   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
## 10 Spain   Cephalopods nei 57                   Squids, cuttlefishes, octopuses
## # ℹ 70 more rows
## # ℹ 6 more variables: asfis_species_number <fct>, asfis_species_name <chr>,
## #   fao_major_fishing_area <fct>, measure <chr>, year <dbl>, catch <dbl>
```

9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
fisheries_tidy %>%
  filter(between(year, 2008, 2012), asfis_species_name != "Osteichthyes") %>%
  arrange(desc(catch))
```

```
## # A tibble: 49,554 × 10
##    country            common_name    isscaap_group_number isscaap_taxonomic_gr…¹
##    <fct>              <chr>          <fct>                <chr>                 
##  1 China              Largehead hai… 34                   Miscellaneous demersa…
##  2 Russian Federation Alaska polloc… 32                   Cods, hakes, haddocks 
##  3 Peru               Anchoveta(=Pe… 35                   Herrings, sardines, a…
##  4 Norway             Atlantic herr… 35                   Herrings, sardines, a…
##  5 Norway             Atlantic herr… 35                   Herrings, sardines, a…
##  6 Peru               Anchoveta(=Pe… 35                   Herrings, sardines, a…
##  7 China              Largehead hai… 34                   Miscellaneous demersa…
##  8 Chile              Anchoveta(=Pe… 35                   Herrings, sardines, a…
##  9 China              Largehead hai… 34                   Miscellaneous demersa…
## 10 Russian Federation Alaska polloc… 32                   Cods, hakes, haddocks 
## # ℹ 49,544 more rows
## # ℹ abbreviated name: ¹​isscaap_taxonomic_group
## # ℹ 6 more variables: asfis_species_number <fct>, asfis_species_name <chr>,
## #   fao_major_fishing_area <fct>, measure <chr>, year <dbl>, catch <dbl>
```

10. Use the data to do at least one analysis of your choice.


```r
fisheries_tidy %>%
  group_by(year) %>%
  summarise(mean_catch = mean(catch, na.rm = T),
            min_catch = min(catch, na.rm = T),
            max_catch = max(catch, na.rm = T))
```

```
## # A tibble: 63 × 4
##     year mean_catch min_catch max_catch
##    <dbl>      <dbl>     <dbl>     <dbl>
##  1  1950       18.6         0       935
##  2  1951       21.1         0      5600
##  3  1952       25.4         0      3800
##  4  1953       20.0         0       900
##  5  1954       24.5         0      1500
##  6  1955       25.4         0      4000
##  7  1956       24.7         0      4500
##  8  1957       20.1         0       998
##  9  1958       21.9         0       994
## 10  1959       24.6         0      6800
## # ℹ 53 more rows
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
