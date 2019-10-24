library(shiny)
library(shinyWidgets)
library(dplyr)
library(ggplot2)


dados_app <- read_sistec("sistec.xlsx") %>%
   dados_app()

# inputs
situacao <- dados_app$situacao
ano <- dados_app$ano
campus <- dados_app$campus
campus_curso <- dados_app$dados %>% select(Campus, Curso) %>% distinct() %>% arrange(Curso)

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
                ),
                tabPanel("Perfil",
                         sidebarLayout(
                             sidebarPanel(width = 3,
                                          radioGroupButtons(
                                              inputId = "perfil_sexo_analise",
                                              label = "Análise por:",
                                              choices = c("CAMPUS", "CURSO"),
                                              justified = TRUE
                                              ),
                                          selectInput("perfil_sexo_situacao",
                                                      "Situação:",
                                                      choices = situacao),
                                          selectInput("perfil_sexo_campus",
                                                      "Campus:",
                                                      choices = campus),
                                          conditionalPanel(
                                              condition = "input.perfil_sexo_analise == 'CURSO'",
                                              selectInput("perfil_sexo_curso",
                                                          "Curso:",
                                                          choices = NULL)
                                          ),
                                          sliderTextInput("perfil_sexo_ano",
                                                          "Ano:",
                                                          choices = ano,
                                                          selected = c("2010", "2019"))
                             ),
                             mainPanel(
                                 plotOutput("perfil_sexo_plot")
                             )
                         )
                )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

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

    observeEvent(input$perfil_sexo_analise, {
        if(input$perfil_sexo_analise == "CURSO"){
            observeEvent(input$perfil_sexo_campus,
                         updateSelectInput(session,
                                           "perfil_sexo_curso",
                                           choices = campus_curso %>%
                                               filter(Campus == input$perfil_sexo_campus) %>%
                                               pull(Curso))
            )
        }
    })

    output$perfil_sexo_plot <- renderPlot({

        if(input$perfil_sexo_analise == "CAMPUS"){
            contagem <- dados_app$contagem_campus_ano_sexo
        } else{
            contagem <- dados_app$contagem_campus_ano_curso_sexo
        }

        sistec:::plot_sistec_perfil_sexo(dados_app$dados,
                                         contagem,
                                         input$perfil_sexo_ano,
                                         input$perfil_sexo_campus,
                                         input$perfil_sexo_situacao,
                                         input$perfil_sexo_curso,
                                         input$perfil_sexo_analise)

    })


}

# Run the application
shinyApp(ui = ui, server = server)
