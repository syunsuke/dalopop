# format_pop02
# 平成２７年（２０１５年）１１月から令和２年（２０２０年）９月まで
# 列名に準じる行??11列
#
# format_cens 令和２年（２０２０年）１０月
# 列名に準じる行?? 4列
#
# format_pop03
# 令和２年（２０２０年）１１月から令和３年（２０２１年）９月まで
# [1,2]に日付を含んだ文字列
# シートは１枚
# 列名に準じる行4行め 14列
#
# format_pop04
# 令和３年（２０２１年）１０月以降
# [1,2]に日付を含んだ文字列
# シートは１枚
# 列名に準じる行4行め 17列
#
# format_5sai
# 列名に準じる行?? 22列

guess_dataformat <- function(filepath){
  a <- openxlsx::read.xlsx(filepath, colNames = FALSE)

  # format_5sai
  # 年齢別人口
  if(ncol(a) == 22){
    return("format_5sai")
  }

  # format_pop04
  # 令和３年（２０２１年）１１月以降
  if(ncol(a) == 17){
    return("format_pop04")
  }

  # format_pop03
  #令和２年（２０２０年）１１月から令和３年（２０２１年）９月まで
  if(ncol(a) == 12){
    return("format_pop03")
  }

  # format_cens 令和２年（２０２０年）１０月
  if(ncol(a) == 4){
    return("format_cens")
  }

  # format_h27
  # 平成２７年（２０１５年）１１月から令和２年（２０２０年）９月まで
  if(ncol(a) == 11){
    return("format_pop02")
  }

  return("format_unknown")

}

check_area_order <- function(target_names){

  flag <- TRUE
  if (length(target_names) != length(area_name_format)){
    message(sprintf("input:%d format:%d",length(target_names),length(area_name_format)))
    stop("Area length  does not match with format.")

  }else{
    flag <- all(target_names == area_name_format)
  }

  if(!flag){
    for(i in seq_along(target_names)){
      if (target_names[i] != area_name_format[i]){
        message(sprintf("%10s,%10s",target_names[i],area_name_format[i]))
      }
    }
    stop("Area format is something wrong.")
  }
}



