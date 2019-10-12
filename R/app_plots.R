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
