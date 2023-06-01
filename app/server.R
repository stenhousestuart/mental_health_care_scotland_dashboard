server <- function(input, output, session) {
  
  admissions_plot <- eventReactive(eventExpr = input$submit_input,
                                   valueExpr = {
                                     
                                     start_year <- input$year_input[1]
                                     end_year <- input$year_input[2]
                                     
                                     if (input$data_view_input == "total_admissions") {
                                     
                                     admissions %>%
                                       filter(financial_year >= input$year_input[1],
                                              financial_year <= input$year_input[2],
                                              health_board %in% input$health_board_input) %>% 
                                       ggplot(aes(x = financial_year, y = number_of_admissions, colour = health_board)) +
                                       geom_line() +
                                       geom_point() +
                                       scale_x_continuous(breaks=seq(start_year,
                                                                     end_year,
                                                                     1)) +
                                       expand_limits(y = 0) +
                                       labs(x = "\n Year",
                                            y = "Total Number of Admissions \n",
                                            title = "Total Number of Admissions by Health Board")
                                     
                                     
                                     } else {
                                       
                                       length_of_stay %>% 
                                         filter(financial_year >= input$year_input[1],
                                                financial_year <= input$year_input[2],
                                                health_board == "All of Scotland") %>%
                                         ggplot(aes(x = financial_year, y = number_of_stays, fill = length_of_stay)) +
                                         geom_col(position = "fill", colour = "white", size = 0.2) +
                                         scale_x_continuous(breaks=seq(start_year,
                                                                       end_year,
                                                                       1)) +
                                         scale_y_continuous(labels = scales::percent) +
                                         labs(x = "\n Year",
                                              y = "Length of Stay Proportion \n",
                                              title = "Length of Stay Proportions")
                                       
                                     }
                                     
                                   })
  
  
  output$admissions_plot <- renderPlot({

    admissions_plot()  
  
    })
  
}