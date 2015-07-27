### Andrew Hall
### Code to explore nyc taxi campaign finance

# preliminaries
setwd("~/Dropbox/Taxis")
library(dplyr)

# names of yellow cab drivers
# note: name dupes for medallion owners who are licensed for n>1 cars
data.cabs <- read.csv("Medallion_Drivers_-_Active.csv", stringsAsFactors=F)
data.money <- read.csv("nyc_13.csv", stringsAsFactors=F, encoding="latin1")

# clean up names to make them mergeable in both datasets
money <- data.money %>% mutate( 
  name=
    gsub(pattern=", ", replacement=",", x=
      tolower(NAME)
    )
  ) %>% select(name, amnt=AMNT, refno=REFNO, occupation=OCCUPATION, recipient=RECIPNAME) 

cabs <- data.cabs %>% mutate(
  name=tolower(Name)
) %>% select(License.Number, name, Type)

# for every contribution record, find if taxi license
# note there are likely many false positive matches here
merged <- money %>% semi_join(cabs, by="name")

# also look at donors who self disclose as cab drivers/owners
# should be 0 false positives here
# but lots of people don't put occupation info
money <- mutate(money, occ=tolower(occupation)) %>% select(-occupation)
self.reported.taxi <- 
  money %>% filter(
    grepl(
      pattern="(^[tT]axi\\b)|(^[cC]ab\\b)|(^[Mm]edallion\\b)", x = occ
    )
  )
