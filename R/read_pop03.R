# format_pop03
# 令和２年（２０２０年）１１月から令和３年（２０２１年）９月まで
# [1,2]に日付を含んだ文字列
# シートは１枚
# 列名に準じる行4行め 14列
#
read_pop03 <- function(filepath){

  # フォーマットの形式チェック
  if(guess_dataformat(filepath) != "format_pop03"){
    message(sprintf("%s is not format_pop03",filepath))
    message("reading this file has skipped.")
    return(NA)
  }

  # 日付の取得
  day_tmp <- openxlsx::read.xlsx(filepath, colNames = FALSE)
  day <- rabbit::fetch_date_from_string(day_tmp[1,2])


  # エクセルファイルからRのデータフレームへ
  xlsxdata <- openxlsx::read.xlsx(filepath, colNames = FALSE, startRow = 8)

  # 以下データフレーム処理

  ## 2列目がNA（人口データのない)行を削除
  xlsxdata <- xlsxdata[!is.na(xlsxdata[,2]),]

  ## 1列目（市区町村名）の文字列に含まれる空白を削除
  xlsxdata[,1] <- stringr::str_replace_all(xlsxdata[,1], "\\s", "")

  ## 現在の地域名の並びをチェック
  check_area_order(xlsxdata[,1])

  ## 地域名を付け替える
  xlsxdata[,1] <- cityID[,2]

  ## 列名をつける
  colnames(xlsxdata) <- pop03_colname

  ans <- xlsxdata %>%
    dplyr::mutate(date = day)

  return(ans)

}

pop03_colname <- c(
  "area",# area name
  "hh",  # households
  "pt",  # population total
  "pm",  # polulation male
  "pf",  # polulation female

  "mct",  # total change of month 月間の増減 総数
  "mcn",  # total natural change of month 月間の増減 自然
  "mib",  # total natural increase by birth of month 月間の増減 自然 出生
  "mdd",  # total natural decrease by death of month 月間の増減 自然 死亡
  "mcs",  # total natural change of month 月間の増減 社会

  "pph",  # person per household 1世帯当たり人口
  "ppa"   # person per area size(km^2)  人口密度

)
