setwd("E:/HHS/")
#setwd("\\\\doitt.nycnet\\root\\4MTC_User_Data\\lnhernandez\\My Documents\\Projects\\ApplicationData2b\\Tagged Proposals Contracts - Site Addresses\\")
dir()

install.packages("dplyr")
install.packages("zipcode")
install.packages("data.table")
install.packages('stringr')
data("zipcode")
library(zipcode)
library(stringr)


##================+++++++ Clean the Addresses ++++++++==============================
address <- read.csv("Provider - Proposals Site Address.csv")
#cartodb <- read.csv('provider_proposals_site_address_6_23_3_cartodb.csv')

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

write.csv(address_latlong,"Provider - Proposals Site Address Clean.csv") 

##================+++++++ Merge Datasets: Address and tagged Contracts ++++++++==============================
tagged <- read.csv("Tagged Contracts_withProposalID.csv")
address <- read.csv("Provider - Proposals Site Address Clean.csv")

library(data.table)
tagg <- as.data.table(tagged)
address <- as.data.table(address)
#cartodb <- as.data.table(cartodb)

setkey(tagg,EIN,Proposal.ID)
setkey(address, EIN,Proposal.ID)
#setkey(cartodb, EIN,Proposal.ID)

address_tagged<-merge(address,tagged, all=TRUE)
#cartodb_tagged<- merge(cartodb,tagged, all=TRUE)

#filter those with 0 Proposal ID and thos where Agency Name =NA
address_tagged <- address_tagged[Proposal.ID!="0" & ï..Agency.Name !="NA",]

write.csv(address_tagged,"Tagged Contracts with_Addresses.csv") 

