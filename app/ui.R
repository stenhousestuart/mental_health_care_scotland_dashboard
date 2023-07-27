ui <- fluidPage(
  
  setBackgroundColor("#e7ecef"),
  setSliderColor(c("#3279b7"), c(1)),
  
  tags$script(src = "https://kit.fontawesome.com/d2641f9054.js"),
  
  # theme = bs_theme(bootswatch = "lumen"),
  
  titlePanel(h1(tags$i(class = "fa-solid fa-brain"), "Mental Health Care In Scotland",
                p("A Tool Designed to Support Basic Exploratory Analysis of Data Relating To Mental Health Care In Scotland", style = "font-size: 12px; color: #3279b7;"), 
                style="background-color:#FFFFFF; border-radius: 5px; padding: 10px; border-color: black; border-style: solid;")),
  
  tabsetPanel(
    tabPanel(title = h6(tags$i(class = "fa-solid fa-house fa-lg"), " Home"),
             
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
    
    
    tabPanel(title = h6(tags$i(class = "fa-solid fa-circle-info fa-lg"), " About"),
             
             
             tags$br(),
             
             p(tags$b("Aim/Purpose:"), 
               tags$br(), 
               "The purpose of this app is for learning purposes only. I 
               developed the initial version during my free time while completing 
               the CodeClan Professional Data Analysis Course. It serves as a 
               tool for personal development and to demonstrate relevant data 
               analysis skills.",
               tags$br(),
               tags$br(), 
               tags$b("Data:"), 
               tags$br(), 
               "- The data used is sourced from Public Health Scotland (PHS) and is made available 
               under the UK Open Government Licence (OGL). Data was downloaded in May & June 2023.",
               tags$br(),
               "- All figures displayed are a combined total of SMR01 and SMR04 entries. For more information
               on how thse records are compiled, please see the PHS publication on 'Mental Health Inpatient Activity', ", 
               tags$a(href="https://publichealthscotland.scot/publications/mental-health-inpatient-activity/mental-health-inpatient-activity-28-march-2023/data-summary/", "here."),
               tags$br(),
               style="background-color:#FFFFFF; border-radius: 5px; padding: 20px; border-color: black; border-style: solid;"),
             
    ),
  ),
  
  # FOOTER
  h5(
    tags$a(href="https://github.com/stenhousestuart", tags$i(class = "fa-brands fa-square-github fa-xl")),
    tags$a(href="https://www.linkedin.com/in/stuartstenhouse", tags$i(class = "fa-brands fa-linkedin fa-xl")),
    ("// Data Source:"), tags$a(href="https://www.opendata.nhs.scot", "Public Health Scotland"),
    ("// Licence:"), tags$a(href="https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/", "UK Open Government Licence"),
    style="background-color:#FFFFFF; border-radius: 5px; padding: 20px; border-color: black; border-style: solid;"),
  
)


