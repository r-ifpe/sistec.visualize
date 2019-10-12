#' @export
sistec_tidy <- function(x){

  #nomes que aparecem no sistec
  erro_cadastro <- c("não", "Federal", "08/2013")
  abandono <- c("DESLIGADO", "TRANSF_EXT", "REPROVADA")

  x %>%
    dplyr::select(`Situação.Matricula`,
                     Dt.Data.Inicio,
                     Municipio,
                     Tipo.Curso,
                     No.Curso) %>%
    corrigir_situacao("ERRO", erro_cadastro) %>%
    corrigir_situacao("ABANDONO", abandono)
}

corrigir_situacao <- function(x, nova_situacao, situacao_cadastro){
  x %>%
    dplyr::mutate(`Situação.Matricula` = ifelse(
      `Situação.Matricula` %in% situacao_cadastro,
      nova_situacao,
      `Situação.Matricula`))
}
