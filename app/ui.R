ui <- fluidPage(
  
  titlePanel("MH Scotland"),
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("year_input", 
                  "Date range:",
                  min = 1997, 
                  max = 2021,
                  step = 1,
                  sep = "",
                  value = c(2010,2015)),

                  actionButton(inputId = "submit_input",
                               label = "Submit / Update"),
                  
      ),
      
      mainPanel(
        
        plotOutput("admissions_plot")
        
      ),
    ),
  )



