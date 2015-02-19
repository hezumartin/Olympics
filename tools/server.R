
#local_directory <- "~/INSEADjan2014/CourseSessions/Sessions23"
#source(paste(local_directory,"R/library.R",sep="/"))
#source(paste(local_directory,"R/heatmapOutput.R",sep="/"))

# To be able to upload data up to 30MB
options(shiny.maxRequestSize=30*1024^2)
options(rgl.useNULL=TRUE)
options(scipen = 50)

# Please enter the maximum number of observations to show in the report and slides (DEFAULT is 100)
max_data_report = 50 

shinyServer(function(input, output,session) {
  
  ############################################################
  # STEP 1: Read the data 
  read_dataset <- reactive({
    input$datafile_name_coded
    
    # First read the pre-loaded file, and if the user loads another one then replace 
    # ProjectData with the filethe user loads
    ProjectData <- read.csv(paste(paste(local_directory,"data",sep="/"), paste(input$datafile_name_coded, "csv", sep="."), sep = "/"), sep=";", dec=",") # this contains only the matrix ProjectData
  
    ProjectData=data.matrix(ProjectData)
    colnames(ProjectData)<-gsub("\\."," ",colnames(ProjectData))
    
    updateSelectInput(session, "country_selected","Country of your choice",  colnames(ProjectData), selected=colnames(ProjectData)[3])
    ProjectData
  })
  
user_inputs <- reactive({
    input$datafile_name_coded
    input$country_selected
   
    ProjectData = read_dataset()
    
    use_attributes = intersect(colnames(ProjectData),input$country_selected)
    
  }) 

the_avgage_countries_tab<-reactive({
    # list the user inputs the tab depends on (easier to read the code)
    input$datafile_name_coded
    input$country_selected
    all_inputs <- user_inputs()
    ProjectData = all_inputs$ProjectData 
   
    summarise(group_by(melt(ProjectData, id=c(2,3,6), measure=c(2)), country_selected, Sport), mean(Age))
  
})

output$parameters<-renderTable({
  the_parameters_tab()
})





  