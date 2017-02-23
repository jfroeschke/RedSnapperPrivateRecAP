## v040
## NOTES based on discussion with M. Larkin
# Use tab with fewest variables necessary for query
# include_record = Y
# Gray triggerfish = gray triggerfish + triggerfishes
# King mackerel = King mackerel + King & Cero mackerel
# White grunt = white grunt + grunt unclassified 

Author <- "John Froeschke"
Email <- "John.Froeschke@gulfcouncil.org"
#Data1 <- "MRIPACLspec_rec81_15wv4_28Oct15_wLACreel.xlsx"
#Data2 <- "MRFSSassess_rec81_15wv2_21Jul15_w_LAcreel.xlsx"

## Check and install if necessary required packages
if (!require("readxl")) install.packages('readxl')
if (!require("doBy")) install.packages('doBy')
## set working directory
setwd("X:/Data_John/acldata/20161215")

##load MRFSS and MRIP data
library(readxl)
library(doBy)
aclFiles<- read_excel("ACL_FILES_12152016.xlsx",
                  sheet = "YEAR_REG", na = "NA")
#str(aclFiles)
aclNames <- sort(unique(aclFiles$COMMON_NAME_STANDARD))


TAXA <- c("COBIA",
          "SPANISH MACKEREL",
          "MACKEREL,KING",
          "MACKEREL,KING AND CERO",
          "DRUM,RED",
          "ALMACO JACK",
          "BANDED RUDDERFISH",
          "SNAPPER,QUEEN",
          "SNAPPER,MUTTON",
          "SNAPPER,BLACKFIN",
          "SNAPPER,RED",
          "SNAPPER,CUBERA",
          "SNAPPER,GRAY AT (MANGROVE)",
          "SNAPPER,LANE",
          "SNAPPER,SILK",
          "SNAPPER,YELLOWTAIL",
          "WENCHMAN",
          "SNAPPER,VERMILION",
          "HIND,SPECKLED",
          "GROUPER,GOLIATH",
          "GROUPER,RED",
          "GROUPER,YELLOWEDGE",
          "GROUPER,WARSAW",
          "GROUPER,SNOWY",
          "GROUPER,BLACK",
          "GROUPER,YELLOWMOUTH",
          "GROUPER,GAG",
          "SCAMP",
          "GROUPER,YELLOWFIN",
          "TILEFISH,GOLDFACE",
          "TILEFISH,BLUELINE",
          "TILEFISH,GOLDFACE",
          "TILEFISH",
          "AMBERJACK",
          "LESSER AMBERJACK",
          "TRIGGERFISH,GRAY",
          "TRIGGERFISHES", 
          "HOGFISH") ## NO SHRIMP

na.replace <- function (x) {
  x[is.na(x)] <- -9999
  return(x)
}
          
dfFish <- c()   
dfYear <- data.frame(YEARLAND=1986:2015)
for(i in 1:length(TAXA)){
  #for(i in 1:1){
tmp <- subset(aclFiles, 
              REGION=="GULF"&
              YEARLAND >= 1986 & 
              YEARLAND <= 2015 & 
              INCLUDE_RECORD=="Y" & 
              COMMON_NAME_STANDARD ==TAXA[i])

df <- summaryBy(pounds ~ YEARLAND, data=tmp, FUN=sum, id="COMMON_NAME_STANDARD") 

dfTmp <- merge(dfYear, df, by="YEARLAND", all=TRUE) 
dfTmp[,2] <- na.replace(dfTmp[,2])

dfFish <- cbind(dfFish, dfTmp[,2])
colnames(dfFish)[i] <- TAXA[i]
}

dfOut <- cbind(dfYear, dfFish)
RedSnapperCommercial <- dfOut[,c(1,12)]

write.csv(RedSnapperCommercial, "X:/Data_John/council meetings/April 2017/Private Recreational AP/R/RedSnapperCommercial.csv", row.names=FALSE)






