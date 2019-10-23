variavel_situacao <- function(x){
  #nomes que aparecem no sistec
  erro_cadastro <- c("não", "Federal", "08/2013")
  abandono <- c("DESLIGADO", "TRANSF_EXT", "REPROVADA")

  x <- ifelse(x %in% erro_cadastro, "ERRO", x)
  x <- ifelse(x %in% abandono, "ABANDONO", x)
  x
}

variavel_ano <- function(x){
  # o ano começa na setima posição
  substring(x, 7)
}

#' @importFrom lubridate decimal_date dmy
variavel_idade <- function(x){
  floor(decimal_date(Sys.Date()) - decimal_date(dmy(x)))
}

#' @importFrom lubridate decimal_date dmy
variavel_duracao_do_curso <- function(fim,inicio){
  decimal_date(dmy(fim)) - decimal_date(dmy(inicio))
}

# inputs como aparecerão no app
inputs_app <- function(x, erro = ""){
  x <- unique(x)
  x <- x[!x %in% erro]
  sort(x, na.last = NA)
}

# função para criar as contagens de alunos que serão
# passadas para dados_app
#' @importFrom dplyr syms
contagem_alunos <- function(x, variaveis){
  x %>%
    dplyr::group_by(!!!syms(variaveis)) %>%
    dplyr::summarise(qtd_campus = n())
}

