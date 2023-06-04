ui <- fluidPage(
  
  setBackgroundColor("#e7ecef"),
  setSliderColor(c("#3279b7"), c(1)),
  
  tags$script(src = "https://kit.fontawesome.com/d2641f9054.js"),
  
  # theme = bs_theme(bootswatch = "lumen"),
  
  titlePanel(h1(tags$i(class = "fa-solid fa-brain"), "Mental Health Care In Scotland",
                p("A Tool Designed to Support Basic Exploratory Analysis of Data Relating To Mental Health Care In Scotland", style = "font-size: 12px; color: #3279b7;"), 
                style="background-color:#FFFFFF; border-radius: 5px; padding: 10px; border-color: black; border-style: solid;")),
  
  tabsetPanel(
    tabPanel(title = "App",
             
             tags$br(),
             
             sidebarLayout(
               sidebarPanel(
                 
                 tags$h4("Step 1:"),
                 
                 sliderInput(inputId = "year_input", 
                             label = "Select Date Range:",
                             min = 1997, 
                             max = 2021,
                             step = 1,
                             sep = "",
                             value = c(2010,2015)),
                 
                 tags$hr(),
                 
                 tags$h4("Step 2:"),
                 
                 awesomeRadio(
                   inputId = "filter_input",
                   label = "Select Filter:",
                   choices = c("Health Board", "Age", "Sex"),
                   inline = TRUE, 
                   status = "primary"
                 ),
                 
                 tags$hr(),
                 
                 conditionalPanel(
                   condition = "input.filter_input == 'Health Board'",
                 
                 tags$h4("Step 3:"),
                 
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
                   
                   tags$h4("Step 3:"),
                   
                   awesomeCheckboxGroup(
                     inputId = "age_input",
                     label = "Select Age Group(s):", 
                     choices = age_choice,
                     inline = TRUE, 
                     status = "primary"
                   ),
                   
                 ),
                 
                 conditionalPanel(
                   condition = "input.filter_input == 'Sex'",
                   
                   tags$h4("Step 3:"),
                   
                   awesomeCheckboxGroup(
                     inputId = "sex_input",
                     label = "Select Sex(s):", 
                     choices = c("Male", "Female"),
                     inline = TRUE, 
                     status = "primary"
                   )
                 ),
                 
                 actionButton(
                   inputId = "submit_input",
                   label = "Submit / Update",
                   icon = icon("refresh"),
                   style= "color: #fff; background-color: #3279b7; border-color: black"
                 ),
               ),
               
               mainPanel(
                 
                 tags$br(),
                 tags$br(),
                 
                 plotOutput("admissions_plot")
                 
               ),
             ),
    ),
    
    tabPanel(title = "Info",
             
    ),
  ),
  
  # FOOTER
  h5(
  tags$a(href="https://github.com/stenhousestuart", tags$i(class = "fa-brands fa-square-github fa-xl")),
  tags$a(href="https://www.linkedin.com/in/stuartstenhouse", tags$i(class = "fa-brands fa-linkedin fa-xl")),
  ("// Data Source:"), tags$a(href="https://www.opendata.nhs.scot", "Public Health Scotland"),
  style="background-color:#FFFFFF; border-radius: 5px; padding: 20px; border-color: black; border-style: solid;"),
  
)



