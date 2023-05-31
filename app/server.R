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
                                     
                                     length_of_stay_clean %>% 
                                       filter(health_board %in% c("All of Scotland")) %>%
                                       ggplot(aes(x = financial_year, y = number_of_stays, fill = length_of_stay)) +
                                       geom_col(position = "fill", colour = "white", size = 0.2) +
                                       labs(x = "\n Year",
                                            y = "Length of Stay Proportion \n",
                                            title = "Length of Stay Proportions by Health Board") +
                                       facet_wrap(~ health_board) +
                                       scale_y_continuous(labels = scales::percent)
                                     
                                   })
  
  
  output$admissions_plot <- renderPlot({

    admissions_plot()  
  
    })
  
}