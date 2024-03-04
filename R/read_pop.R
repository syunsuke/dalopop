#' Read pop exceldata into R data.frame
#'
#' @param files vector of excel files path
#'
#' @return data.frame
#' @export
dalopop_read_file <- function(files){

  ans_pop <- NULL
  ans_5sai <- NULL

  for(i in seq_along(files)){
    data_format <- guess_dataformat(files[i])

    if(data_format == "format_5sai"){
      ans_5sai <- ans_5sai %>%
        dplyr::bind_rows(read_5sai(files[i]))
    }else if(data_format == "format_pop04"){
      ans_pop <- ans_pop %>%
        dplyr::bind_rows(read_pop04(files[i]))
    }else if(data_format == "format_pop03"){
      ans_pop <- ans_pop %>%
        dplyr::bind_rows(read_pop03(files[i]))
    }else if(data_format == "format_pop02"){
      ans_pop <- ans_pop %>%
        dplyr::bind_rows(read_pop02(files[i]))
    }else if(data_format == "format_cens"){
      ans_pop <- ans_pop %>%
        dplyr::bind_rows(read_cens(files[i]))
    }else{
      message(sprintf("%s is unknown format. so it's skipped.",basename(files[i])))
    }
  }

  ans <- ans_pop %>%
    dplyr::left_join(ans_5sai, by=c("area","date")) %>%
    dplyr::left_join(cityID, by=c("area" = "area_name")) %>%
    dplyr::relocate(date,area,area_id)

  return(ans)

}
