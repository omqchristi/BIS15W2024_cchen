library(shiny)
library(tidyverse)

homerange <- readr::read_csv("../data/Tamburelloetal_HomeRangeDatabase.csv")

ui <- fluidPage(
  
  radioButtons("x", "Select Fill Variable" , choices = c("trophic.guild", "thermoregulation"), selected = "trophic.guild"),
  
  plotOutput("plot") 
  
) # closes ui

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    
    ggplot(data = homerange, aes_string(x = "locomotion", fill = input$x)) +
      geom_bar(position = "dodge", alpha = 0.8, color = "black") +
      labs(x = NULL,
           fill = "Fill Variable")
    
  }) # closes render plot
  
} # closes server

shinyApp(ui, server)