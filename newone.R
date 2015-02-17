#rm(list = ls( ))

local_directory <- getwd()

cat("\n *********\n WORKING DIRECTORY IS ", local_directory, "\n PLEASE CHANGE IT IF IT IS NOT CORRECT using setwd(..) - type help(setwd) for more information \n *********")

# Please ENTER the name of the file with the data used. The file should contain a matrix with one row per observation (e.g. person) and one column per attribute. THE NAME OF THIS MATRIX NEEDS TO BE ProjectData (otherwise you will need to replace the name of the ProjectData variable below with whatever your variable name is, which you can see in your Workspace window after you load your file)
datafile_name="OlympicsAthletesData" # do not add .csv at the end! make sure the data are numeric!!!! check your file!

# Please ENTER the filename of the Report and Slides (in the doc dfi

ProjectData <- read.csv(paste(local_directory, "OlympicAthletesData.csv", sep = "/"), sep=",", dec=",") 

ProjectData=data.matrix(ProjectData) 

colnames(ProjectData)<-gsub("\\.","  ",colnames(ProjectData))

  # now run the app
  runApp(paste(local_directory,"tools", sep="/"))