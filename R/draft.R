# # # library(dplyr)
# # # library(ggplot2)
# # #
# # # a %>%
# # #   filter(No.Curso == "GESTÃO AMBIENTAL") %>%
# # #   mutate(Dt.Data.Inicio = substring(Dt.Data.Inicio, 7)) %>%
# # #   select(Nome.Ciclo, Dt.Ocorrencia.Ciclo, Dt.Ocorrencia.Matricula, Dt.Data.Inicio)
# # #
#
#
# dados_campus[[1]] %>%
#   filter(Ano == "2018", `Situação` == "ABANDONO", Campus == "RECIFE") %>%
#   group_by(Campus, Ano, `Tipo do Curso`) %>%
#   tally() %>%
#   left_join(dados_campus$contagem_campus_ano_tipo,
#             by = c("Campus" = "Campus",
#                    "Ano" = "Ano",
#                    "Tipo do Curso" = "Tipo do Curso")) %>%
#   mutate(Porcentagem = round(100 * n /qtd_campus, 2))%>%
#   arrange(-Porcentagem) %>%
#   ungroup() %>%
#   mutate(`Tipo do Curso` = factor(`Tipo do Curso`, levels = .$`Tipo do Curso`)) %>%
#   ggplot() +
#   aes(x = `Tipo do Curso`, y = Porcentagem) +
#   geom_bar(stat = "identity") +
#   geom_text(aes(label = Porcentagem),
#             hjust = -0.1) +
#   coord_flip()
