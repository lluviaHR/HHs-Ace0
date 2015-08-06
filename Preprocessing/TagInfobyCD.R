
tagged<-read.csv("data.csv")
install.packages("dplyr")
install.packages("tidyr")
install.packages("data.table")

require(dplyr)
require(tidyr)
require(data.table)

tagged<-as.data.table(Tagged)
setkey(tagged,Geography.Name)
#++++++++++++++++++++++++++++++++++++ All selected +++++++++++++++++++++++++++++++++++++++++++++++++++
##========++++++++++TOTAL Number of Contracts ++++++===========================
Total_Contracts <- aggregate(EIN ~ Geography.Name, data = tagged, length)

##======== +++++++ SERVICES: Get unique per CD and collapse
serv <-tagged[,list(service=unique(as.character(Service.Name))), by=Geography.Name]
services_aggregated <- serv[,list(service= paste(service, collapse = "," )), by=Geography.Name]

##======== +++++++ LANGUAGES: Get unique per CD and collapse++++++===========================
lang <-tagged[,list(language=unique(as.character(Language.Name))), by=Geography.Name]
languages_aggregated <- lang[,list(language= paste(language, collapse = "," )), by=Geography.Name]

##======== +++++++ SERVICES: Get unique per CD and collapse++++++===========================
pop <-tagged[,list(population=unique(as.character(Population.Name))), by=Geography.Name]
population_aggregated <- pop[,list(population= paste(population, collapse = "," )), by=Geography.Name]

##=========== ++++++++merge all the datasets ++++++===========================
mymerge = function(x,y) merge(x,y,by ="Geography.Name", all=TRUE) 
data<- Reduce(mymerge,list(Total_Contracts,services_aggregated,languages_aggregated,population_aggregated))
## filter the data to remove the unspecificified
data<- filter(tagged, Geography.Name !='Unspecified')
write.csv(data,"data CD.csv")

#---------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------
#++++++++++++++++++++++++++++++++++++ NO(/) proposal ID +++++++++++++++++++++++++++++++++++++++++++++++++++
tagged_subset <- tagged[Proposal.ID=="0" & Geography.Name!="Unspecified"]
##========++++++++++TOTAL Providers++++++===========================
Total <- aggregate(EIN ~ Geography.Name, data = tagged_subset, length)
##======== +++++++ SERVICES: Get unique per CD and collapse
serv <-tagged_subset[,list(service=unique(as.character(Service.Name))), by=Geography.Name]
services_aggregated <- serv[,list(service= paste(service, collapse = "," )), by=Geography.Name]

##======== +++++++ LANGUAGES: Get unique per CD and collapse++++++===========================
lang <-tagged_subset[,list(language=unique(as.character(Language.Name))), by=Geography.Name]
languages_aggregated <- lang[,list(language= paste(language, collapse = "," )), by=Geography.Name]

##======== +++++++ SERVICES: Get unique per CD and collapse++++++===========================
pop <-tagged_subset[,list(population=unique(as.character(Population.Name))), by=Geography.Name]
population_aggregated <- pop[,list(population= paste(population, collapse = "," )), by=Geography.Name]

##=========== ++++++++merge all++++++===========================
mymerge = function(x,y) merge(x,y,by ="Geography.Name", all=TRUE) 
data<- Reduce(mymerge,list(Total,services_aggregated,languages_aggregated,population_aggregated))
#write.csv(data,"data2 CD.csv")


