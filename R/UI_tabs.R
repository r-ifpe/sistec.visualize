# UI da aba CAMPUS
campus_tab_layout <- function(dados_campus){
  tabPanel("Campus",
           sidebarLayout(
             sidebarPanel(width = 3,
               selectInput("situacao",
                           "Situação:",
                           choices = dados_campus$situacao),
               selectInput("ano",
                           "Ano:",
                           choices = dados_campus$ano)
             ),
             mainPanel(
               plotOutput("campus_plot")
             )
           )
  )
}

# UI da aba TIPO DO CURSO
tipo_tab_layout <- function(dados_campus){
  tabPanel("Tipo do Curso",
           sidebarLayout(
             sidebarPanel(width = 3,
               selectInput("situacao",
                           "Situação:",
                           choices = dados_campus$situacao),
               selectInput("campus",
                           "Campus:",
                           choices = dados_campus$campus),
               selectInput("ano",
                           "Ano:",
                           choices = dados_campus$ano)
             ),
             mainPanel(
               plotOutput("tipo_plot")
             )
           )
  )
}
