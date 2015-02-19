cat("\014")

###################################

# Project Name: "Olympic Athletes"

###################################

# THESE ARE THE PROJECT PARAMETERS NEEDED TO GENERATE THE REPORT

# When running the case on a local computer, modify this in case you saved the case in a different directory 
# (e.g. local_directory <- "C:/user/MyDocuments" )
# type in the Console below help(getwd) and help(setwd) for more information

local_directory <- paste(getwd())

cat("\n *********\n WORKING DIRECTORY IS ", local_directory, "\n PLEASE CHANGE IT IF IT IS NOT CORRECT using setwd(...) - type help(setwd) for more information \n *********")

# Please ENTER the name of the file with the data used. The file should contain a matrix with one row per observation (e.g. person) and one column per attribute. THE NAME OF THIS MATRIX NEEDS TO BE ProjectData (otherwise you will need to replace the name of the ProjectData variable below with whatever your variable name is, which you can see in your Workspace window after you load your file)
datafile_name="OlympicAthletesData" # do not add .csv at the end! make sure the data are numeric!!!! check your file!

# Please ENTER the filename of the Report and Slides (in the doc directory) to generate 

report_file = "Report_Olympics"

# Please ENTER the country for which you want the regression
reg_country = "Austria"


###################################
# Would you like to also start a web application on YOUR LOCAL COMPUTER once the report and slides are generated?
# Select start_webapp <- 1 ONLY if you run the case on your local computer
# NOTE: Running the web application on your LOCAL computer will open a new browser tab
# Otherwise, when running on a server the application will be automatically available
# through the ShinyApps directory

# 1: start application on LOCAL computer, 0: do not start it
# SELECT 0 if you are running the application on a server 
# (DEFAULT is 0). 
start_local_webapp <- 0
# NOTE: You need to make sure the shiny library is installing (see below)
# Load required libraries
if (require(dplyr) == FALSE) 
  install.packages("dplyr") 
library(dplyr)
if (require(reshape2) == FALSE) 
  install.packages("reshape2") 
library(reshape2)
if (require(reshape) == FALSE) 
  install.packages("reshape") 
library(reshape)
####################################
# Now run everything

# this loads the selected data: DO NOT EDIT THIS LINE
ProjectData <- read.csv(paste(paste(local_directory,"data",sep="/"), paste(datafile_name,"csv",sep="."),sep="/"), sep=",", dec=",") 
#ProjectData=data.matrix(ProjectData) 
table1 <- summarise(group_by(melt(ProjectData, id=c(3,6,10), measure=c(10)),Country, Sport), sum(value))
shiny1 <- summarise(group_by(melt(ProjectData, id=c(3,4,6,10), measure=c(10)),Country, Year, Sport), sum(value))
table2 <- cast(melt(ProjectData, id=c(6), measure=c(2)), Sport ~ variable, mean)
shiny2 <- summarise(group_by(melt(ProjectData, id=c(2,3,6), measure=c(2)), Country, Sport), mean(value))

# REGRESSSION

# Step 1: Convert data into a Pivot Table
regdata <- ProjectData
names(regdata)[10] <- "Total.Medals"
groupedData <- summarise(group_by(regdata, Country, Year), totalMedals = sum(Total.Medals)) 
groupedData <- dcast(groupedData, Country ~ Year, value.var = "totalMedals")
head(groupedData)

# Step 2: Choose the selected country and summer games
selectedCountry = filter(groupedData, Country == reg_country)
selectedCountry[is.na(selectedCountry)] <- 0
selectedSummer <- as.numeric(selectedCountry[,c(2,4,6,8)])

# Step 3: Run the regression and display the scatter plot
years <- c(2000,2004,2008,2012)
fit <- lm(selectedSummer ~ years)
coeffs = coefficients(fit)
head(fit)

####################################
# SHINY

source(paste(local_directory,"R/library.R", sep="/"))
if (require(shiny) == FALSE) 
  install_libraries("shiny")
source(paste(local_directory,"R/runcode.R", sep = "/"))

if (start_local_webapp){
  
  # first load the data files in the data directory so that the App see them
  OlympicAthletesData <- read.csv(paste(local_directory, "data/OlympicAthletesData.csv", sep = "/"), sep=";", dec=",") # this contains only the matrix ProjectData
  OlympicAthletesData=data.matrix(OlympicAthletesData) # this file needs to be converted to "numeric"....
  
  # now run the app
  runApp(paste(local_directory,"tools", sep="/"))  
}