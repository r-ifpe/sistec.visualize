# plot para a aba PERFIL - RENDA
#' @import dplyr ggplot2
plot_sistec_perfil <- function(x,
                               qtd_campus,
                               ano,
                               campus,
                               situacao,
                               curso,
                               analise,
                               perfil){

  anos <-  seq(ano[1], ano[2], 1)

  expr <- perfil_expr(analise, perfil)

  x %>%
    filter(!!!expr$filter) %>%
    group_by(!!!syms(expr$group_by_1)) %>%
    tally() %>%
    left_join(qtd_campus, by = expr$by) %>%
    group_by(!!!syms(expr$group_by_2)) %>%
    summarise(n = sum(n), qtd_campus = sum(qtd_campus)) %>%
    ggplot() +
    aes(x = !!sym(perfil)) +
    geom_bar(aes(y = qtd_campus), stat = "identity", fill = "blue", alpha = 0.2) +
    geom_text(aes(label = qtd_campus, y = qtd_campus), vjust = 2) +
    geom_bar(aes(y = n), stat = "identity", fill='blue', alpha = 0.5) +
    geom_text(aes(label = n, y = n), vjust = 2) +
    theme(panel.grid.major.x = element_blank()) +
    ylab("Quantidade de Alunos")
}

perfil_expr <- function(analise, perfil){
  if(analise == "CAMPUS"){
    filter <- c("Ano %in% anos", "`Situação` == situacao", "Campus == campus")
    filter <- rlang::parse_exprs(filter)
    group_by_1 <- c("Campus", "Ano", perfil)
    by <- c("Campus" = "Campus", "Ano" = "Ano", perfil)
    names(by)[3] <- perfil
    group_by_2 <- c("Campus", perfil)
  } else {
    filter <- c("Ano %in% anos", "`Situação` == situacao",
                "Campus == campus", "Curso == curso")
    filter <- rlang::parse_exprs(filter)
    group_by_1 <- c("Campus", "Ano", "Curso", perfil)
    by <- c("Campus" = "Campus", "Ano" = "Ano", "Curso" = "Curso", perfil)
    names(by)[4] <- perfil
    group_by_2 <- c("Curso", perfil)
  }

  list(filter = filter,
       group_by_1 = group_by_1,
       by = by,
       group_by_2 = group_by_2)
}
