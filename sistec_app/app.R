library(shiny)
library(shinyWidgets)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
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
                                              inputId = "perfil_analise",
                                              label = "Análise por:",
                                              choices = c("CAMPUS", "CURSO"),
                                              justified = TRUE
                                              ),
                                          selectInput("perfil_situacao",
                                                      "Situação:",
                                                      choices = situacao),
                                          selectInput("perfil_campus",
                                                      "Campus:",
                                                      choices = campus),
                                          conditionalPanel(
                                              condition = "input.perfil_analise == 'CURSO'",
                                              selectInput("perfil_curso",
                                                          "Curso:",
                                                          choices = NULL)
                                          ),
                                          sliderTextInput("perfil_ano",
                                                          "Ano:",
                                                          choices = ano,
                                                          selected = c("2010", "2019"))
                             ),
                             mainPanel(
                                 tabsetPanel(
                                     tabPanel("Sexo", plotOutput("perfil_sexo_plot")),
                                     tabPanel("Cota", plotOutput("perfil_cota_plot")),
                                     tabPanel("Renda", plotOutput("perfil_renda_plot"))
                                     )

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

    # inputs da aba de perfil
    observeEvent(input$perfil_analise, {
        if(input$perfil_analise == "CURSO"){
            observeEvent(input$perfil_campus,
                         updateSelectInput(session,
                                           "perfil_curso",
                                           choices = campus_curso %>%
                                               filter(Campus == input$perfil_campus) %>%
                                               pull(Curso))
            )
        }
    })

    output$perfil_sexo_plot <- renderPlot({

        if(input$perfil_analise == "CAMPUS"){
            contagem <- dados_app$contagem_campus_ano_sexo
        } else{
            contagem <- dados_app$contagem_campus_ano_curso_sexo
        }

        sistec:::plot_sistec_perfil(dados_app$dados,
                                    contagem,
                                    input$perfil_ano,
                                    input$perfil_campus,
                                    input$perfil_situacao,
                                    input$perfil_curso,
                                    input$perfil_analise,
                                    "Sexo")
    })

    output$perfil_cota_plot <- renderPlot({

        if(input$perfil_analise == "CAMPUS"){
            contagem <- dados_app$contagem_campus_ano_cota
        } else{
            contagem <- dados_app$contagem_campus_ano_curso_cota
        }

        sistec:::plot_sistec_perfil(dados_app$dados,
                                    contagem,
                                    input$perfil_ano,
                                    input$perfil_campus,
                                    input$perfil_situacao,
                                    input$perfil_curso,
                                    input$perfil_analise,
                                    "Cota")
    })

    output$perfil_renda_plot <- renderPlot({

        if(input$perfil_analise == "CAMPUS"){
            contagem <- dados_app$contagem_campus_ano_renda
        } else{
            contagem <- dados_app$contagem_campus_ano_curso_renda
        }

        sistec:::plot_sistec_perfil(dados_app$dados,
                                    contagem,
                                    input$perfil_ano,
                                    input$perfil_campus,
                                    input$perfil_situacao,
                                    input$perfil_curso,
                                    input$perfil_analise,
                                    "Baixa Renda")
    })
}

# Run the application
shinyApp(ui = ui, server = server)
