library(shiny) # Package for shiny applications
library(dplyr) # Package for data manipulations
library(magrittr) # Package for pipe operator
library(ggplot2) # Package for creating graphs
library(shinythemes) # Package for shiny app themes
library(hrbrthemes) # Package for themes
library(viridis) # Package for color palette
library(plotly)

Bezirke <- c("Appenzell", "Schwende", "Rüte", "Schlatt-Haslen", "Gonten", "Oberegg")

# Define UI for application
ui <- navbarPage("Appenzell Innerrhoden in Zahlen",
                 # specify the theme
                 theme = shinytheme("paper"),
                 tabPanel("Bevölkerung",
                          sidebarLayout(
                            sidebarPanel(),
                            mainPanel(
                              fluidRow(
                                column(width = 8, plotOutput("bev_entwicklung")),
                                column(width = 4, p("Die Innerrhoder Bevölkerung ist im Jahr 2020 um 
                                0.7% leicht angestiegen. Die Bezirke Schwende, 
                                Rüte und Oberegg konnten 2020 ein Wachstum verzeichnen. 
                                In den Bezirken Appenzell, Schlatt-Haslen und 
                                Gonten waren die Bevölkerungszahlen dagegen leicht rückläufig."))
                              ),
                            ),
                          )),
                 tabPanel("Bildung"),
                 tabPanel("Gesundheit"),
                 tabPanel("Arbeit"),
                 tabPanel("Volkswirtschaft"),
                 tabPanel("Tourismus"),
                 tabPanel("Verkehr")
)

# Define server side logic
server <- function(input, output, session) {
  
  # vorbereiten: Bevölkerungsentwicklung -----
  bev_plot_df <- reactive({
    bev %>%
      mutate(Bezirk = factor(Bezirk, levels = Bezirke)) %>% 
      filter(Art == "Wohnbevölkerung") %>% 
      arrange(Jahr)
  })
  
  # Output: Bevölkerungsentwicklung -----
  output$bev_entwicklung <- renderPlot({
    ggplot(data = bev_plot_df(), mapping = aes(x = Jahr, y = Anz, group = Bezirk, fill = Bezirk)) +
      geom_area()+
      scale_fill_viridis(discrete = TRUE)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
