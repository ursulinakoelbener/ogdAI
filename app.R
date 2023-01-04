library(shiny) # Package for shiny applications
library(dplyr) # Package for data manipulations
library(magrittr) # Package for pipe operator
library(ggplot2) # Package for creating graphs
library(shinythemes) # Package for shiny app themes
library(hrbrthemes) # Package for themes
library(viridis) # Package for color palette
library(plotly)
library(rio) # package to load data

Bezirke <- c("Appenzell", "Schwende", "Rüte", "Schlatt-Haslen", "Gonten", "Oberegg")
arb_al <- rio::import("data_orig/arbeit_arbeitslosenquoten2009_2022.csv")



###############################################################################
# Define UI for application -----
###############################################################################
ui <- navbarPage("Appenzell Innerrhoden in Zahlen",
                 # specify the theme
                 theme = shinytheme("paper"),
                 # Bevölkerung -----
                 tabPanel("Bevölkerung",
                          sidebarLayout(
                            sidebarPanel(),
                            mainPanel(),
                            ),
                          ),
                 # Bildung -----
                 tabPanel("Bildung"),
                 # Gesundheit -----
                 tabPanel("Gesundheit"),
                 # Arbeit -----
                 tabPanel("Arbeit",
                 sidebarLayout(
                   sidebarPanel(
                     h2("Sidebar Panel"),
                     sliderInput("jahr", label = h3("Zeitraum"),
                                 min = 2009, max = 2022, value = c(2016,2022),
                                 sep = '')
                     ),
                   
                   mainPanel(
                     h1("Arbeitslosigkeit in Appenzell I.Rh."),
                     plotOutput("plot_arb_al")
                     
                        ),
                 ),
                 ),
                 #Volkswirtschaft -----
                 tabPanel("Volkswirtschaft"),
                 # Tourismus -----
                 tabPanel("Tourismus"),
                 # Verkehr -----
                 tabPanel("Verkehr")
)
###############################################################################
# Define server side logic ----
###############################################################################
server <- function(input, output, session) {
  
  #Output Arbeit: Arbeitslosenquote -----
  output$plot_arb_al <- renderPlotly({
    ggplot(data = arb_al()) +
      geom_line(mapping = aes(x = Monat, AI))
  })
  
  # # vorbereiten: Bevölkerungsentwicklung -----
  # bev_plot_df <- reactive({
  #   bev %>%
  #     mutate(Bezirk = factor(Bezirk, levels = Bezirke)) %>% 
  #     filter(Art == "Wohnbevölkerung") %>% 
  #     arrange(Jahr)
  # })
  # 
  # # Output: Bevölkerungsentwicklung -----
  # output$bev_entwicklung <- renderPlot({
  #   ggplot(data = bev_plot_df(), mapping = aes(x = Jahr, y = Anz, group = Bezirk, fill = Bezirk)) +
  #     geom_area()+
  #     scale_fill_viridis(discrete = TRUE)
  # })
  
}
###############################################################################
# Run the application -----
###############################################################################
shinyApp(ui = ui, server = server)
