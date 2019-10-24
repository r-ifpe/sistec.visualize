# plot para a aba CAMPUS
plot_sistec_campus <- function(x, qtd_campus, ano, situacao){

  anos <-  seq(ano[1], ano[2], 1)

  x %>%
    filter(Ano %in% anos, `Situação` == situacao) %>%
    group_by(Campus, Ano) %>%
    tally() %>%
    left_join(qtd_campus,
              by = c("Campus" = "Campus", "Ano" = "Ano")) %>%
    group_by(Campus) %>%
    summarise(n = sum(n), qtd_campus = sum(qtd_campus)) %>%
    mutate(Porcentagem = round(100 * n /qtd_campus, 2))%>%
    arrange(-Porcentagem) %>%
    ungroup() %>%
    mutate(Campus = factor(Campus, levels = .$Campus)) %>%
    ggplot() +
    aes(x = Campus, y = Porcentagem) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = Porcentagem),
              hjust = -0.1) +
    coord_flip()
}

# plot para a aba CURSO
#' @import ggplot2 dplyr
plot_sistec_curso <- function(x, qtd_campus, ano, campus, situacao){

  anos <-  seq(ano[1], ano[2], 1)

  x %>%
    filter(Ano %in% anos, Campus == campus, `Situação` == situacao) %>%
    group_by(Campus, Ano, Curso) %>%
    tally() %>%
    left_join(qtd_campus,
              by = c("Campus" = "Campus",
                     "Ano" = "Ano",
                     "Curso" = "Curso")) %>%
    group_by(Curso) %>%
    summarise(n = sum(n), qtd_campus = sum(qtd_campus)) %>%
    mutate(Porcentagem = round(100 * n /qtd_campus, 2))%>%
    arrange(-Porcentagem) %>%
    ungroup() %>%
    mutate(Curso = factor(Curso, levels = .$Curso)) %>%
    ggplot() +
    aes(x = Curso, y = Porcentagem) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = Porcentagem),
              hjust = -0.1) +
    coord_flip()
}

# plot para a aba TIPO DO CURSO
#' @import ggplot2 dplyr
plot_sistec_tipo <- function(x, qtd_campus, ano, campus, situacao){

  anos <-  seq(ano[1], ano[2], 1)

  x %>%
    filter(Ano %in% anos, Campus == campus, `Situação` == situacao) %>%
    group_by(Campus, Ano, `Tipo do Curso`) %>%
    tally() %>%
    left_join(qtd_campus,
              by = c("Campus" = "Campus",
                     "Ano" = "Ano",
                     "Tipo do Curso" = "Tipo do Curso")) %>%
    group_by(`Tipo do Curso`) %>%
    summarise(n = sum(n), qtd_campus = sum(qtd_campus)) %>%
    mutate(Porcentagem = round(100 * n /qtd_campus, 2))%>%
    arrange(-Porcentagem) %>%
    ungroup() %>%
    mutate(`Tipo do Curso` = factor(`Tipo do Curso`, levels = .$`Tipo do Curso`)) %>%
    ggplot() +
    aes(x = `Tipo do Curso`, y = Porcentagem) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = Porcentagem),
              hjust = -0.1) +
    coord_flip()
}

# plot para a aba PERFIL - SEXO
#' @import dplyr ggplot2
plot_sistec_perfil_sexo <- function(x,
                                    qtd_campus,
                                    ano,
                                    campus,
                                    situacao,
                                    curso,
                                    tipo_plot){

anos <-  seq(ano[1], ano[2], 1)

if(tipo_plot == "CAMPUS"){
  dados <- x %>%
    filter(Ano %in% anos, `Situação` == situacao, Campus == campus) %>%
    group_by(Campus, Ano, Sexo) %>%
    tally() %>%
    left_join(qtd_campus,
              by = c("Campus" = "Campus",
                     "Ano" = "Ano",
                     "Sexo" = "Sexo")) %>%
    group_by(Campus, Sexo) %>%
    summarise(n = sum(n), qtd_campus = sum(qtd_campus))
} else {
  dados <- x %>%
    filter(Ano %in% anos, `Situação` == situacao,
           Campus == campus, Curso == curso) %>%
    group_by(Campus, Ano, Curso, Sexo) %>%
    tally() %>%
    left_join(qtd_campus,
              by = c("Campus" = "Campus",
                     "Ano" = "Ano",
                     "Curso" = "Curso",
                     "Sexo" = "Sexo")) %>%
    group_by(Curso, Sexo) %>%
    summarise(n = sum(n), qtd_campus = sum(qtd_campus))
}

    ggplot(dados) +
    aes(x = Sexo) +
    geom_bar(aes(y = qtd_campus), stat = "identity", fill = "blue", alpha = 0.2) +
    geom_text(aes(label = qtd_campus, y = qtd_campus), vjust = 2) +
    geom_bar(aes(y = n), stat = "identity", fill='blue', alpha = 0.5) +
    geom_text(aes(label = n, y = n), vjust = 2) +
    theme(panel.grid.major.x = element_blank()) +
    ylab("Quantidade de Alunos")

}


