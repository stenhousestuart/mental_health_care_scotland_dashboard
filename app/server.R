server <- function(input, output, session) {
  
  admissions_plot <- eventReactive(eventExpr = input$submit_input,
                                   valueExpr = {
                                     
                                     admissions %>% 
                                       filter(financial_year %in% input$year_input,
                                              health_board == "All of Scotland") %>% 
                                       ggplot(aes(x = financial_year, y = number_of_admissions)) +
                                       geom_line() +
                                       geom_point() +
                                       labs(x = "\n Year",
                                            y = "Total Number of Admissions \n",
                                            title = "Total Number of Admissions by Health Board")
                                     
                                   })
  
  
  output$admissions_plot <- renderPlot({

    admissions_plot()  
  
    })
  
}