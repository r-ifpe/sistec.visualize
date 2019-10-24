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

  # contagens de alunos
  contagem_campus_ano <- contagem_alunos(dados)
  contagem_campus_ano_tipo <- contagem_alunos(dados, "Tipo do Curso")
  contagem_campus_ano_curso <- contagem_alunos(dados, "Curso")
  contagem_campus_ano_sexo <- contagem_alunos(dados, "Sexo")
  contagem_campus_ano_renda <-contagem_alunos(dados, "Baixa Renda")
  contagem_campus_ano_cota <- contagem_alunos(dados, "Cota")
  contagem_campus_ano_curso_sexo <- contagem_alunos(dados, c("Curso", "Sexo"))
  contagem_campus_ano_curso_renda <- contagem_alunos(dados, c("Curso", "Baixa Renda"))
  contagem_campus_ano_curso_cota <- contagem_alunos(dados, c("Curso", "Cota"))

  # inputs
  situacao <- inputs_app(dados$`Situação`, "ERRO")
  campus <- inputs_app(dados$Campus, c("PAGA", "PRONATEC", "GRATUITO"))
  ano <- inputs_app(dados$Ano)

  list(dados = dados, contagem_campus_ano = contagem_campus_ano,
       contagem_campus_ano_tipo = contagem_campus_ano_tipo,
       contagem_campus_ano_curso = contagem_campus_ano_curso,
       contagem_campus_ano_sexo = contagem_campus_ano_sexo,
       contagem_campus_ano_renda = contagem_campus_ano_renda,
       contagem_campus_ano_cota = contagem_campus_ano_cota,
       contagem_campus_ano_curso_sexo = contagem_campus_ano_curso_sexo,
       contagem_campus_ano_curso_renda = contagem_campus_ano_curso_renda,
       contagem_campus_ano_curso_cota = contagem_campus_ano_curso_cota,
       situacao = situacao, ano = ano, campus = campus)
}
