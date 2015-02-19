shinyUI(pageWithSidebar(
  
  ##########################################
  # STEP 1: The name of the application
  ##########################################
  
  headerPanel("Web App"),
  
  ##########################################
  # STEP 2: The left menu, which reads the data as
  # well as all the inputs exactly like the inputs in RunStudy.R
  
  sidebarPanel(
    
    HTML("Please reload the web page any time the app crashes. <strong> When it crashes the whole screen turns into grey.</strong> If it only stops reacting it may be because of 
         heavy computation or traffic on the server, in which case you should simply wait. Plots may at times fade: you do <strong>not</strong> 
         need to reload the app when this happens, simply continue using the app.This is a test version. </h4>"),
    
    ###########################################################    
    # STEP 2.1: read the data
    
    HTML("<hr>"),    
    
    HTML("<center><h4>Choose a data file:<h4>"),    
    selectInput('datafile_name_coded', '',
                c("Olympics"),multiple = FALSE),
    
    ###########################################################
    # STEP 2.2: read the INPUTS. 
    # THESE ARE THE *SAME* AS THE NECESSARY INPUT PARAMETERS IN RunStudy.R
    
    HTML("<hr>"),
    HTML("<h4>Select the variables to use</h4>"),
    HTML("(<strong>Press 'ctrl' or 'shift'</strong> to select multiple  variables)"),
    HTML("<br>"),
    HTML("<br>"),
    selectInput("country_selected","Country of your choice",  choices=c("attributes used"),selected=NULL, multiple=TRUE),
    HTML("<br>"),
     ###########################################################
    # STEP 2.3: buttons to download the new report and new slides 
    
    HTML("<hr>"),
    HTML("<h4>Download the new HTML report </h4>"),
    HTML("<br>"),
    HTML("<br>"),
    downloadButton('report', label = "Download"),
    HTML("<br>"),
    HTML("<br>"),
    HTML("<h4>Download the new HTML5 slides </h4>"),
    HTML("<br>"),
    HTML("<br>"),
    HTML("<br>"),
    HTML("<br>"),
    downloadButton('slide', label = "Download"),
    HTML("<hr></center>")
    ),
  
  ###########################################################
  # STEP 3: The output tabs (these follow more or less the 
  # order of the Rchunks in the report and slides)
  mainPanel(
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    ),
    
    # Now these are the taps one by one. 
    # NOTE: each tab has a name that appears in the web app, as well as a
    # "variable" which has exactly the same name as the variables in the 
    # output$ part of code in the server.R file 
    # (e.g. tableOutput('parameters') corresponds to output$parameters in server.r)
    
    tabsetPanel(
    
      tabPanel("Parameters", 
               numericInput("factor1", "Select a country to use:",1),       
               actionButton("action_visual", "Show/Update Results"),
               HTML("<br>"),
               plotOutput("NEW_ProjectData")) 
    )
    
  )
  ))
