ui <- fluidPage(
  
  theme = bs_theme(bootswatch = "zephyr"),
  
  titlePanel(h1("Mental Health Data: Scotland",
                style='background-color:#e6f0ff; border-radius: 5px; padding: 20px;')),
  
  tabsetPanel(
    tabPanel(title = "App",
             
             tags$br(),
             
             sidebarLayout(
               sidebarPanel(
                 
                 radioButtons(inputId = "data_view_input",
                              label = tags$b("Data Type:"),
                              choices = data_view_options
                              ),
                 
                 tags$hr(),
                 
                 sliderInput("year_input", 
                             tags$b("Date range:"),
                             min = 1997, 
                             max = 2021,
                             step = 1,
                             sep = "",
                             value = c(2010,2015)),
                 
                 tags$hr(),
                 
                 # Admissions Additional Input Options
                 
                 conditionalPanel(
                   condition = "input.data_view_input == 'total_admissions'",
                   
                   
                   pickerInput(
                     inputId = "health_board_input",
                     label = tags$b("Select Health Board (Max. 5):"), 
                     choices = health_board_choice,
                     selected = "All of Scotland",
                     multiple = TRUE,
                     options =  list("max-options" = 5),
                   ),
                 ),
                 
                 actionBttn(
                   inputId = "submit_input",
                   label = "Submit / Update",
                   style = "jelly", 
                   color = "primary"
                 ),
               ),
               
               mainPanel(
                 
                 plotOutput("admissions_plot")
                 
               ),
             ),
          ),
    
    tabPanel(title = "Instructions",
             
    ),
    
    tabPanel(title = "Credits",
             
    ),
  ),
  
  # FOOTER
  tags$hr(),
  
  h5("GitHub Link / LinkedIn Link / Data Source Link",
     style='background-color:#e6f0ff; padding: 10px;'),
  
  
)



