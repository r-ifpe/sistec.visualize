shiny_server <- function(input, output){
  # Define server logic required to draw a histogram
    output$plot_campus <- renderPlot({
      plot_sistec_campus(dados_campus$dados,
                         dados_campus$contagem_campus_ano,
                         input$ano,
                         input$situacao)
    })
}
