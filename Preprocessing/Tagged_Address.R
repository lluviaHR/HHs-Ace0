
install.packages("dplyr")
install.packages("zipcode")
install.packages("data.table")
install.packages('stringr')
data("zipcode")
library(zipcode)
library(stringr)


##================+++++++ Clean the Addresses ++++++++==============================
address <- read.csv("data.csv")


## Exploring the variables
table(address$City)
table(address$State)
unique(address, by="City")

##======== +++++++  Check the zipcodes 
# Attempts to detect and clean up suspected ZIP codes. 
# Will strip "ZIP+4" suffixes to match format of zipcode 
# data.frame. Restores leading zeros, converts invalid entries to NAs,
# and returns character vector.
address$zip <- clean.zipcodes(address$Zip.Code)

##======== +++++++  Convert to Title
#Returns a string with the first character of each word in str capitalized,
#if that character is alphabetic

address$City <- str_to_title(address$City)
address$Site.Name <- str_to_title(address$Site.Name)
address$Address.1 <- str_to_title(address$Address.1)

##======== +++++++ Get the lat an long
address_latlong <-merge (address, zipcode,by="zip", all.x =TRUE)

write.csv(address_latlong,"lat_long.csv") 

##================+++++++ Merge Datasets: Address and tagged Contracts ++++++++==============================
tagged <- read.csv("data1.csv")
address <- read.csv("lat_long.csv")

library(data.table)
tagg <- as.data.table(tagged)
address <- as.data.table(address)
#db <- as.data.table(cartodb)

setkey(tagg,EIN,Proposal.ID)
setkey(address, EIN,Proposal.ID)
#setkey(db, EIN,Proposal.ID)

address_tagged<-merge(address,tagged, all=TRUE)
#db_tagged<- merge(db,tagged, all=TRUE)

#filter those with 0 Proposal ID and thos where Agency Name =NA
address_tagged <- address_tagged[Proposal.ID!="0" & ï..Agency.Name !="NA",]

#write.csv(address_tagged,"lat_long final version.csv") 

