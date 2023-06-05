server <- function(input, output, session) {
  
  admissions_plot <- eventReactive(eventExpr = input$submit_input,
                                   valueExpr = {
                                     
                                     start_year <- input$year_input[1]
                                     end_year <- input$year_input[2]
                                     
                                     if (input$filter_input == "Health Board") {
                                       
                                       admissions %>%
                                         filter(financial_year >= input$year_input[1],
                                                financial_year <= input$year_input[2],
                                                health_board %in% input$health_board_input) %>% 
                                         ggplot(aes(x = financial_year, y = number_of_admissions, colour = health_board)) +
                                         geom_line(linewidth = 2, show.legend = FALSE) +
                                         geom_point(size = 3) +
                                         scale_x_continuous(breaks=seq(start_year,
                                                                       end_year,
                                                                       1)) +
                                         expand_limits(y = 0) +
                                         scale_colour_manual(values = colour_scheme) +
                                         labs(x = "\n Year",
                                              y = "Total Number of Admissions \n",
                                              title = "Total Number of Admissions by Health Board",
                                              colour = "Health Board") +
                                         theme(plot.title = element_text(size = 25, face = "bold", hjust = 0.5, vjust = 2),
                                               panel.background = element_rect(fill = "#f5f5f5"),
                                               panel.grid = element_line(colour = "grey90", linetype = "dashed"),
                                               plot.background = element_rect(fill = "#e7ecef", color="#e7ecef"),
                                               axis.title.y = element_text(size = 15),
                                               axis.title.x = element_text(size = 15),
                                               axis.text.y = element_text(size = 10),
                                               axis.text.x = element_text(size = 10, angle = 45, vjust = 0.5),
                                               legend.title = element_text(size= 12, face = "bold"),
                                               legend.text= element_text(size= 12),
                                               legend.background = element_rect(fill = "#e7ecef",
                                                                                size=0.5, linetype="solid", 
                                                                                colour ="grey90"))
                                       
                                       
                                     } else {
                                       
                                       if (input$filter_input == "Sex") {
                                         
                                         admissions_age_sex %>%
                                           filter(financial_year >= input$year_input[1],
                                                  financial_year <= input$year_input[2],
                                                  sex %in% input$sex_input,
                                                  health_board == "All of Scotland") %>%
                                           group_by(financial_year, sex) %>%
                                           summarise(total_patient_count = sum(patients_count)) %>% 
                                           ggplot(aes(x = financial_year, y = total_patient_count, colour = sex)) +
                                           geom_line(linewidth = 2) +
                                           geom_point(size = 3) +
                                           scale_x_continuous(breaks=seq(start_year,
                                                                         end_year,
                                                                         1)) +
                                           expand_limits(y = 0) +
                                           scale_colour_manual(values = colour_scheme) +
                                           labs(x = "\n Year",
                                                y = "Total Number of Individual Patients Admitted \n",
                                                title = "Total Number of Individual Patients Admitted by Sex",
                                                colour = "Sex") +
                                           theme(plot.title = element_text(size = 25, face = "bold", hjust = 0.5, vjust = 2),
                                                 panel.background = element_rect(fill = "#f5f5f5"),
                                                 panel.grid = element_line(colour = "grey90", linetype = "dashed"),
                                                 plot.background = element_rect(fill = "#e7ecef", color="#e7ecef"),
                                                 axis.title.y = element_text(size = 15),
                                                 axis.title.x = element_text(size = 15),
                                                 axis.text.y = element_text(size = 10),
                                                 axis.text.x = element_text(size = 10, angle = 45, vjust = 0.5),
                                                 legend.title = element_text(size= 12, face = "bold"),
                                                 legend.text= element_text(size= 12),
                                                 legend.background = element_rect(fill = "#e7ecef",
                                                                                  size=0.5, linetype="solid", 
                                                                                  colour ="grey90"))
                                         
                                       } else {
                                         
                                         admissions_age_sex %>%
                                           filter(financial_year >= input$year_input[1],
                                                  financial_year <= input$year_input[2],
                                                  age_group %in% input$age_input,
                                                  health_board == "All of Scotland") %>%
                                           group_by(financial_year, age_group) %>%
                                           summarise(total_patient_count = sum(patients_count)) %>% 
                                           ggplot(aes(x = financial_year, y = total_patient_count, colour = age_group)) +
                                           geom_line(linewidth = 2) +
                                           geom_point(size = 3) +
                                           scale_x_continuous(breaks=seq(start_year,
                                                                         end_year,
                                                                         1)) +
                                           expand_limits(y = 0) +
                                           scale_colour_manual(values = colour_scheme) +
                                           labs(x = "\n Year",
                                                y = "Total Number of Individual Patients Admitted \n",
                                                title = "Total Number of Individual Patients Admitted by Age Group",
                                                colour = "Age Group") +
                                           theme(plot.title = element_text(size = 25, face = "bold", hjust = 0.5, vjust = 2),
                                                 panel.background = element_rect(fill = "#f5f5f5"),
                                                 panel.grid = element_line(colour = "grey90", linetype = "dashed"),
                                                 plot.background = element_rect(fill = "#e7ecef", color="#e7ecef"),
                                                 axis.title.y = element_text(size = 15),
                                                 axis.title.x = element_text(size = 15),
                                                 axis.text.y = element_text(size = 10),
                                                 axis.text.x = element_text(size = 10, angle = 45, vjust = 0.5),
                                                 legend.title = element_text(size= 12, face = "bold"),
                                                 legend.text= element_text(size= 12),
                                                 legend.background = element_rect(fill = "#e7ecef",
                                                                                  size=0.5, linetype="solid", 
                                                                                  colour ="grey90"))
                                       }
                                     }
                                   })
  
  
  output$admissions_plot <- renderPlot({
    
    admissions_plot()  
    
  })
  
}