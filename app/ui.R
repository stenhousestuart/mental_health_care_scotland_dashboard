ui <- fluidPage(
  
  titlePanel("Game Recommendations"),
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput(inputId = "year_input", 
                  label = tags$b("Time Period"),
                  min = 1997, 
                  max = 2021, 
                  value = c(1997, 2021)),
                  
                  actionButton(inputId = "submit_input",
                               label = "Submit / Update"),
                  
      ),
      
      mainPanel(
        # Plot Output 
        
        plotOutput("suggestion_plot")
        
      ),
    ),
  )



