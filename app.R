library(shiny) # Package for shiny applications
library(dplyr) # Package for data manipulations
library(magrittr) # Package for pipe operator
library(ggplot2) # Package for creating graphs
library(shinythemes) # Package for shiny app themes
library(hrbrthemes) # Package for themes
library(viridis) # Package for color palette
library(plotly)



# Define UI for application
ui <- navbarPage("Appenzell Innerrhoden in Zahlen",
                 # specify the theme
                 theme = shinytheme("paper"),
                 tabPanel("Bevölkerung"),
                 tabPanel("Bildung"),
                 tabPanel("Gesundheit"),
                 tabPanel("Arbeit"),
                 tabPanel("Volkswirtschaft"),
                 tabPanel("Tourismus"),
                 tabPanel("Verkehr")
)

# Define server side logic
server <- function(input, output, session) {
 
  
}

# Run the application 
shinyApp(ui = ui, server = server)
