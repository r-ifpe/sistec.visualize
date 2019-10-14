#' @export
dados_app <- function(x){
  dados <- x %>%
    dplyr::filter(Carga.Horaria > 800) %>% # removido os FIC
    dplyr::transmute(`Situação` = variavel_situacao(`Situação.Matricula`),
                     Ano = variavel_ano(Dt.Data.Inicio),
                     Campus = Municipio,
                     `Tipo do Curso` = Tipo.Curso,
                     Curso = No.Curso,
                     Idade = variavel_idade(Dt.Nascimento.Aluno),
                     `Baixa Renda` = Atestado.Baixa.Renda,
                     Sexo = Sexo.Aluno,
                     Cota = Tipo.Cota,
                     `Duração do Curso` = variavel_duracao_do_curso(
                       Dt.Data.Fim.Previso, Dt.Data.Inicio)
                     )

  # contagem em cada campus por ano
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

  # inputs
  situacao <- inputs_app(dados$`Situação`, "ERRO")
  campus <- inputs_app(dados$Campus, c("PAGA", "PRONATEC", "GRATUITO"))
  ano <- inputs_app(dados$Ano)

  list(dados = dados, contagem_campus_ano = contagem_campus_ano,
       contagem_campus_ano_tipo = contagem_campus_ano_tipo,
       contagem_campus_ano_curso = contagem_campus_ano_curso,
       situacao = situacao, ano = ano, campus = campus)
}
