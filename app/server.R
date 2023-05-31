server <- function(input, output, session) {
  
  admissions_plot <- eventReactive(eventExpr = input$submit_input,
                                   valueExpr = {
                                     
                                     start_year <- input$year_input[1]
                                     end_year <- input$year_input[2]
                                     
                                     admissions %>%
                                       filter(financial_year >= input$year_input[1],
                                              financial_year <= input$year_input[2],
                                              health_board == "All of Scotland") %>% 
                                       ggplot(aes(x = financial_year, y = number_of_admissions)) +
                                       geom_line() +
                                       geom_point() +
                                       scale_x_continuous(breaks=seq(start_year,
                                                                     end_year,
                                                                     1)) +
                                       expand_limits(y = 0) +
                                       labs(x = "\n Year",
                                            y = "Total Number of Admissions \n",
                                            title = "Total Number of Admissions by Health Board")
                                     
                                   })
  
  
  output$admissions_plot <- renderPlot({

    admissions_plot()  
  
    })
  
}