library(shiny)
library(shinyWidgets)


dados_app <- read_sistec("sistec.xlsx") %>%
   dados_app()

# inputs
situacao <- dados_app$situacao
ano <- dados_app$ano
campus <- dados_app$campus



# Define UI for application that draws a histogram
ui <- fluidPage(
    navbarPage("SISTEC - IFPE",
               tabPanel("Campus",
                        sidebarLayout(
                            sidebarPanel(width = 3,
                                         selectInput("situacao_campus",
                                                     "Situação:",
                                                     choices = situacao),
                                         sliderTextInput("ano_campus",
                                                     "Ano:",
                                                     choices = ano,
                                                     selected = c("2010", "2019"))
                            ),
                            mainPanel(
                                tabsetPanel(
                                    tabPanel("Situação", plotOutput("campus_plot")
                                    )
                                )

                            )
                        )
               ),
               tabPanel("Curso",
                        sidebarLayout(
                            sidebarPanel(width = 3,
                                         selectInput("situacao_curso",
                                                     "Situação:",
                                                     choices = situacao),
                                         selectInput("campus_curso",
                                                     "Campus:",
                                                     choices = campus),
                                         sliderTextInput("ano_curso",
                                                         "Ano:",
                                                         choices = ano,
                                                         selected = c("2010", "2019"))
                            ),
                            mainPanel(
                                plotOutput("curso_plot")
                            )
                        )
               ),
               tabPanel("Tipo do Curso",
                        sidebarLayout(
                            sidebarPanel(width = 3,
                                         selectInput("situacao_tipo",
                                                     "Situação:",
                                                     choices = situacao),
                                         selectInput("campus_tipo",
                                                     "Campus:",
                                                     choices = campus),
                                         sliderTextInput("ano_tipo",
                                                         "Ano:",
                                                         choices = ano,
                                                         selected = c("2010", "2019"))
                            ),
                            mainPanel(
                                plotOutput("tipo_plot")
                            )
                        )
               # ),
               # ####################### FIX ME ###################
               # tabPanel("Perfil",
               #          sidebarLayout(
               #              sidebarPanel(width = 3,
               #                           selectInput("situacao_perfil",
               #                                       "Situação:",
               #                                       choices = dados_app$situacao),
               #                           conditionalPanel(
               #                               condition = "input.plotType == 'hist'"
               #                           ),
               #                           selectInput("campus_tipo",
               #                                       "Campus:",
               #                                       choices = dados_app$campus),
               #                           sliderTextInput("ano_tipo",
               #                                           "Ano:",
               #                                           choices = dados_app$ano,
               #                                           selected = c("2010", "2019"))
               #              ),
               #              mainPanel(
               #                  plotOutput("tipo_plot")
               #              )
               #          )
                )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$campus_plot <- renderPlot({
        sistec:::plot_sistec_campus(dados_app$dados,
                           dados_app$contagem_campus_ano,
                           input$ano_campus,
                           input$situacao_campus)
    })

    output$curso_plot <- renderPlot({
        sistec:::plot_sistec_curso(dados_app$dados,
                          dados_app$contagem_campus_ano_curso,
                          input$ano_curso,
                          input$campus_curso,
                          input$situacao_curso)
    })

    output$tipo_plot <- renderPlot({
        sistec:::plot_sistec_tipo(dados_app$dados,
                         dados_app$contagem_campus_ano_tipo,
                         input$ano_tipo,
                         input$campus_tipo,
                         input$situacao_tipo)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
