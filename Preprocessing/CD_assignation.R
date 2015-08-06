
install.packages("dplyr")
install.packages("tidyr")
install.packages("data.table")

##======= Readig the files
tagged <- read.csv("data.csv")
require(dplyr)
require(tidyr)
require(data.table)

##================+++++++ Define a CD ++++++++==============================

##==== Geography: Staten Island
#Filtering the data
staten_Island <-filter(tagged, Geography.Name=='Staten Island')

#Adding the column with the geographies
staten_Island <-mutate(staten_Island, Geography.Name2=("SI01,SI02,SI03"))

## Assigning the geographies to each contract 
staten_Island <-staten_Island %>%
  transform(Geography.Name2 = strsplit(Geography.Name2, ",")) %>%
  unnest(Geography.Name2)

##==== Geography: Brooklyn
Brooklyn <-filter(tagged, Geography.Name=='Brooklyn')
Brooklyn <-mutate(Brooklyn, Geography.Name2=("BK01,BK02,BK03,BK04,BK05,BK06,BK07,BK08,BK09,BK10,BK11,BK12,BK13,BK14,BK15,BK16,BK17,BK18"))
Brooklyn <-Brooklyn %>%
  transform(Geography.Name2 = strsplit(Geography.Name2, ",")) %>%
  unnest(Geography.Name2)

##==== Geography: Bronx
Bronx <-filter(tagged, Geography.Name=='Bronx')
Bronx <-mutate(Bronx, Geography.Name2=("BX01,BX02,BX03,BX04,BX05,BX06,BX07,BX08,BX09,BX10,BX11,BX12"))
Bronx <-Bronx %>%
  transform(Geography.Name2 = strsplit(Geography.Name2, ",")) %>%
  unnest(Geography.Name2)

##==== Geography: Manhattan
Manhattan <-filter(tagged, Geography.Name=='Manhattan')
Manhattan <-mutate(Manhattan, Geography.Name2=("M01,M02,M03,M04,M05,M06,M07,M08,M09,M10,M11,M12"))
Manhattan <-Manhattan %>%
  transform(Geography.Name2 = strsplit(Geography.Name2, ",")) %>%
  unnest(Geography.Name2)

##==== Geography:  Queens
Queens <-filter(tagged, Geography.Name=='Queens')
Queens <-mutate( Queens, Geography.Name2=("Q01,Q02,Q03,Q04,Q05,Q06,Q07,Q08,Q09,Q10,Q11,Q12,Q13,Q14"))
Queens <- Queens %>%
  transform(Geography.Name2 = strsplit(Geography.Name2, ",")) %>%
  unnest(Geography.Name2)

##==== CONCATENATE ALL
taggedWithAssignedCD <- rbind_all(list(Bronx,Brooklyn,Manhattan,staten_Island,Queens))
##drop column Geography.Name
taggedWithAssignedCD$Geography.Name <- NULL 
##change the name of column Geography.Name2 to Geography.Name
taggedWithAssignedCD <- rename(taggedWithAssignedCD, Geography.Name = Geography.Name2)


##================+++++++ Created a unique Dataset  ++++++++==============================

##==== filter the rest of the contracts and 
subset_tagged<-filter(tagged, 
                      Geography.Name !='Staten Island' & Geography.Name !='Brooklyn' & Geography.Name!='Bronx' & Geography.Name!='Queens' & Geography.Name!='Manhattan')
##==== Join to those that already had a CD
tagged_with_geography <- rbind(subset_tagged,taggedWithAssignedCD)

##===== Copy this new dataset to a csv file
write.csv(tagged_with_geography,"data formatted.csv")