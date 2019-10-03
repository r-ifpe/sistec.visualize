
sistec <- read_sistec("sistec.xlsx")
dados_campus <- aba_campus(sistec)

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    navbarPage("SISTEC - IFPE",
               tabPanel("Campus",
                        sidebarLayout(
                            sidebarPanel(width = 3,
                                         selectInput("situacao_campus",
                                                     "Situação:",
                                                     choices = dados_campus$situacao),
                                         selectInput("ano_campus",
                                                     "Ano:",
                                                     choices = dados_campus$ano)
                            ),
                            mainPanel(
                                plotOutput("campus_plot")
                            )
                        )
               ),
               tabPanel("Tipo do Curso",
                        sidebarLayout(
                            sidebarPanel(width = 3,
                                         selectInput("situacao_tipo",
                                                     "Situação:",
                                                     choices = dados_campus$situacao),
                                         selectInput("campus_tipo",
                                                     "Campus:",
                                                     choices = dados_campus$campus),
                                         selectInput("ano_tipo",
                                                     "Ano:",
                                                     choices = dados_campus$ano)
                            ),
                            mainPanel(
                                plotOutput("tipo_plot")
                            )
                        )
               )

    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$campus_plot <- renderPlot({
        plot_sistec_campus(dados_campus$dados,
                           dados_campus$contagem_campus_ano,
                           input$ano_campus,
                           input$situacao_campus)
    })

    output$tipo_plot <- renderPlot({
        plot_sistec_tipo(dados_campus$dados,
                         dados_campus$contagem_campus_ano_tipo,
                         input$ano_tipo,
                         input$campus_tipo,
                         input$situacao_tipo)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
