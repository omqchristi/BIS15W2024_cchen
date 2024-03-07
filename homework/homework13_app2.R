# Libraries

library("tidyverse")
library("shiny")
library("shinydashboard")

# Reading Data

UC_admit <- readr::read_csv("../data/UC_admit.csv")

# Fixing Data

UC_admit <- UC_admit %>%
  separate(`Perc FR`, into = c("percentage", "temp"), sep = "%") %>%
  select(-temp)
UC_admit$percentage <- as.numeric(UC_admit$percentage)
UC_admit$Academic_Yr <- as.factor(UC_admit$Academic_Yr)

# Shiny App

ui <- dashboardPage(
  dashboardHeader(title = "UC Admissions"),
  dashboardSidebar(disable = T),
  dashboardBody(
    
    box(
    
    selectInput("x", "Select Ethnicity", choices = unique(UC_admit$Ethnicity)),
    
    selectInput("y", "Select Campus", choices = unique(UC_admit$Campus)),
    
    selectInput("z", "Select Category", choices = unique(UC_admit$Category))
    
    ), # closes box
    
    plotOutput("plot")
    
  ) # closes dashboard body
  
) # closes ui dashboard page

server <- function(input, output, session) {
  
  session$onSessionEnded(stopApp)
  
  output$plot <- renderPlot({
    
    UC_admit %>%
      filter(Ethnicity == input$x) %>%
      filter(Campus == input$y) %>%
      filter(Category == input$z) %>%
      ggplot(aes(x = Academic_Yr, y = `percentage`, fill = Academic_Yr)) +
      geom_col()
    
  }) # closes render plot
  
} # closes server

shinyApp(ui, server)