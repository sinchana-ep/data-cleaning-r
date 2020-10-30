#read csv
honey_1998 <- read.csv("Data/honeyraw_1998to2002.csv", 
                       header = FALSE, na.strings = c("","NA"),
                       stringsAsFactors = FALSE)
#rename columns
colnames(honey_1998) <-
  c("Year", "type", "state",
    "numcol", "yieldpercol",
    "totalprod", "stocks",
    "priceperlb", "prodvalue")

#remove columns
honey_1998 <- filter(honey_1998, type == "d")

distinct(honey_1998, state)
honey_1998 <- filter(honey_1998, nchar(honey_1998$state)==2)

#recode years
honey_1998 <- mutate(honey_1998, year = case_when(
  Year == 1 ~ "1998",
  Year == 2 ~ "1999",
  Year == 3 ~ "2000",
  Year == 4 ~ "2001",
  Year == 5 ~ "2002",
  TRUE ~ "NA"
))

#remove Year column and type - select
honey_1998 <-
  select(honey_1998, -c("Year", "type"))
#explore dataset
str(honey_1998) #all are char
#change data type
typeof(honey_1998)
honey_1998[, 2:7] <- as.numeric(unlist(honey_1998[ , 2:7]))
str(honey_1998)

#change to right units - mutate
honey_1998 <- mutate(honey_1998,
                     numcol = numcol*1000,
                     totalprod = totalprod*1000,
                     stocks = stocks*1000,
                     priceperlb = priceperlb/100,
                     prodvalue = prodvalue*1000)

#save cleaned dataset to csv
write.csv(honey_1998, "Data/Better_honey_1998.csv", row.names = FALSE)
