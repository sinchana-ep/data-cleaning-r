#load car csv dataset
car <- read.csv("Data/CarPurchase.csv", na.strings = "", stringsAsFactors = FALSE)
#explore dataset
str(car)
head(car)
tail(car)
dim(car)
anyNA(car)
summary(car)
colnames(car)
#rename a variable-base R
colnames(car)[colnames(car) == "engine.size...type"] <- "engine"
#rename a variable-dplyr
#car <- dplyr::rename(car, engine = engine.size...type)

library(tidyr)
#separate
car <- separate(car, engine, c("size","cyl"), sep = 'L')

car <- separate(car, cyl, c("cyl","hybrid"), sep = '-', fill = "right")

#gather
car <- gather(car, key = Gender, value = PurchaseNo, "male":"female")

#fill na values
car$PurchaseNo[is.na(car$PurchaseNo)] <- 0

#mutate
car <- mutate(car, hybrid = case_when(is.na(hybrid)~"No", 
                                      hybrid == "Hybrid"~"Yes",TRUE ~ "NA"))
#save cleaned dataset to csv
write.csv(car, "Data/Better_CarPurchase.csv", row.names = FALSE)
