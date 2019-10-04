
#' @export
read_sistec <- function(path){
  openxlsx::read.xlsx(path, 1)
}

#' @importFrom dplyr %>%
#' @export
aba_campus <- function(x){
  dados <- x %>%
    dplyr::transmute(`Situação` = `Situação.Matricula`,
                     Ano = substring(Dt.Data.Inicio, 7),
                     Campus = Municipio,
                     `Tipo do Curso` = Tipo.Curso,
                     Curso = No.Curso)

  # inserir contagem em cada campus por ano
  contagem_campus_ano <- dados %>%
    dplyr::group_by(Campus, Ano) %>%
    dplyr::summarise(qtd_campus = n())

  # contagem por campus e ano da quantidade de tipo de cursos
  contagem_campus_ano_tipo <- dados %>%
    dplyr::group_by(Campus, Ano, `Tipo do Curso`) %>%
    dplyr::summarise(qtd_campus = n())

  # contagem por campus e ano da quantidade de alunos nos cursos
  contagem_campus_ano_curso <- dados %>%
    dplyr::group_by(Campus, Ano, Curso) %>%
    dplyr::summarise(qtd_campus = n())

  situacao <- dados$`Situação` %>% unique()
  campus <- dados$Campus %>% unique() %>% sort()

  ano <- dados$Ano %>%
    unique() %>%
    sort(decreasing = TRUE, na.last = NA)

  list(dados = dados, contagem_campus_ano = contagem_campus_ano,
       contagem_campus_ano_tipo = contagem_campus_ano_tipo,
       contagem_campus_ano_curso = contagem_campus_ano_curso,
       situacao = situacao, ano = ano, campus = campus)
}

valores_unicos <- function(x, variavel){
  x %>%
    dplyr::select(variavel) %>%
    dplyr::distinct()
}

