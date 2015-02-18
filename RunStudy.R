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
slides_file = "Slides_Olympics"

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

####################################
# Now run everything

# this loads the selected data: DO NOT EDIT THIS LINE
ProjectData <- read.csv(paste(paste(local_directory,"data",sep="/"), paste(datafile_name,"csv",sep="."),sep="/"), sep=",", dec=",") 
ProjectData=data.matrix(ProjectData) 

# ANALYZING THE DATA

if (datafile_name == "OlympicAthletesData")
  colnames(ProjectData)<-gsub("\\.","  ",colnames(ProjectData))

####################################
# SHINY

if (require(shiny) == FALSE) 
  install_libraries("shiny")

if (start_local_webapp){
  
  # first load the data files in the data directory so that the App see them
  OlympicAthletesData <- read.csv(paste(local_directory, "data/OlympicAthletesData.csv", sep = "/"), sep=";", dec=",") # this contains only the matrix ProjectData
  OlympicAthletesData=data.matrix(OlympicAthletesData) # this file needs to be converted to "numeric"....
  
  # now run the app
  runApp(paste(local_directory,"tools", sep="/"))  
}