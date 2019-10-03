library(shiny)

shiny_ui <- function(){
  # Define UI for application that draws a histogram
  fluidPage(

    # Application title
    titlePanel("Sistec - IFPE"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        selectInput("situacao",
                    "Situação:",
                    choices = dados_campus$situacao),
        selectInput("ano",
                    "Ano:",
                    choices = dados_campus$ano),
        width = 3
      ),

      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Campus", plotOutput("plot_campus")),
                    tabPanel("Summary", verbatimTextOutput("summary")),
                    tabPanel("Table", tableOutput("table"))
        )
      )
    )
  )

}
