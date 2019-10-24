
#' @export
read_sistec <- function(path){
  openxlsx::read.xlsx(path, 1)
}

