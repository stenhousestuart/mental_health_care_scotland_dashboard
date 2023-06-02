ui <- fluidPage(
  
  setBackgroundColor("#e7ecef"),
  
  # theme = bs_theme(bootswatch = "litera"),
  
  titlePanel(h1("Mental Health Admissions & Discharges: Scotland",
                style='background-color:#6096ba; border-radius: 5px; padding: 20px;')),
  
  tabsetPanel(
    tabPanel(title = "App",
             
             tags$br(),
             
             sidebarLayout(
               sidebarPanel(
                 
                 tags$h3("Step 1:"),
                 
                 sliderInput(inputId = "year_input", 
                             label = "Select Date Range:",
                             min = 1997, 
                             max = 2021,
                             step = 1,
                             sep = "",
                             value = c(2010,2015)),
                 
                 tags$hr(),
                 
                 tags$h3("Step 2:"),
                 
                 awesomeRadio(
                   inputId = "filter_input",
                   label = "Select Filter:",
                   choices = c("Health Board", "Age", "Sex"),
                   inline = TRUE, 
                   status = "info"
                 ),
                 
                 tags$hr(),
                 
                 conditionalPanel(
                   condition = "input.filter_input == 'Health Board'",
                 
                 tags$h3("Step 3:"),
                 
                 pickerInput(
                   inputId = "health_board_input",
                   label = "Select Health Board (Max. 5):", 
                   choices = health_board_choice,
                   selected = "All of Scotland",
                   multiple = TRUE,
                   options =  list("max-options" = 5),
                 ),
                 ),
                 
                 conditionalPanel(
                   condition = "input.filter_input == 'Age'",
                   
                   tags$h3("Step 3:"),
                   
                   awesomeCheckboxGroup(
                     inputId = "age_input",
                     label = "Select Age Group(s):", 
                     choices = age_choice,
                     inline = TRUE, 
                     status = "info"
                   ),
                   
                 ),
                 
                 conditionalPanel(
                   condition = "input.filter_input == 'Sex'",
                   
                   tags$h3("Step 3:"),
                   
                   awesomeCheckboxGroup(
                     inputId = "sex_input",
                     label = "Select Sex(s):", 
                     choices = c("Male", "Female"),
                     inline = TRUE, 
                     status = "info"
                   )
                 ),
                 
                 actionBttn(
                   inputId = "submit_input",
                   label = "Submit / Update",
                   style = "bordered", 
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
     style='background-color:#8b8c89; padding: 10px;'),
  
  
)



