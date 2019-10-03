# plot para a aba CAMPUS
plot_sistec_campus <- function(x, qtd_campus, ano, situacao){
  x %>%
    filter(Ano == ano, `Situação` == situacao) %>%
    group_by(Campus, Ano) %>%
    tally() %>%
    left_join(qtd_campus,
              by = c("Campus" = "Campus", "Ano" = "Ano")) %>%
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

# plot para a aba TIPO DO CURSO
plot_sistec_tipo <- function(x, qtd_campus, ano, campus, situacao){
  x %>%
    filter(Ano == ano, Campus == campus, `Situação` == situacao) %>%
    group_by(Campus, Ano, `Tipo do Curso`) %>%
    tally() %>%
    left_join(qtd_campus,
              by = c("Campus" = "Campus",
                     "Ano" = "Ano",
                     "Tipo do Curso" = "Tipo do Curso")) %>%
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
