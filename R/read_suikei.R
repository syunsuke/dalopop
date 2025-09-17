# 人口推計値（前回国勢調査後、次回国勢調査未到来）
#
# 平成27年（２０１５年）１１月以降のデータがある
# 直前国勢調査前の部分について修正データと重複
# #令和２年（２０２０年）１１月から令和３年（２０２１年）９月まで
# #令和３年（２０２１年）１０月以降
#
# 対前年差があるもの(v002)とない(v001)ものがある
# 期間は関係なし
#
# DB_suikei_v001
# [1,2]に日付を含んだ文字列
# シートは１枚
# 列名に準じる行4行め 14列
#
# DB_suikei_v002
# [1,2]に日付を含んだ文字列
# シートは１枚
# 列名に準じる行4行め 17列
#
# 推計データフォーマット１４列バージョン
DB_read_suikei_v001 <- function(filepath){

  # 日付の取得
  day_tmp <- openxlsx::read.xlsx(filepath, colNames = FALSE)
  day <- rabbit::fetch_date_from_string(day_tmp[1,2])

  # エクセルファイルからRのデータフレームへ
  xlsxdata <- openxlsx::read.xlsx(filepath, colNames = FALSE, startRow = 8)

  ## 2列目がNA（人口データのない)行を削除
  xlsxdata <- xlsxdata[!is.na(xlsxdata[,2]),]

  ## 1列目（市区町村名）の文字列に含まれる空白を削除
  xlsxdata[,1] <- stringr::str_replace_all(xlsxdata[,1], "\\s", "")

  ## 現在の地域名の並びをチェックしてから
  ## 地域名を付け替える
  #check_area_v002_DB(xlsxdata[,1])
  #xlsxdata[,1] <- area_name_v002_DB
  xlsxdata[,1] <- guess_area_order_DB(xlsxdata[,1])

  ## 列名の定義
  suikei_colname <- c(
    "area_name",# area name
    "total_households",  # households これは総世帯数を表す
    "total_population",   # population total
    "male_population",    # population male
    "female_population",  # population female

    "monthly_population_change", #mct 1月間の増減 総数
    "monthly_natural_change",    #mcn 1月間の増減 自然
    "births_monthly",            #mib 1月間の増減 自然 出生
    "deaths_montyly",            #mdd 1月間の増減 自然 死亡
    "monthly_net_migration",     #mcs 1月間の増減 社会

    "total_household_size",  # person per household 1世帯当たり人口
    "population_density"   # person per area size(km^2)  人口密度
  )

  ## 列名をつける
  colnames(xlsxdata) <- suikei_colname

  ans <- xlsxdata %>%
    dplyr::mutate(observation_date = day)

  return(ans)
}


# 推計データフォーマット１７列バージョン
DB_read_suikei_v002 <- function(filepath){

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

  ## 現在の地域名の並びをチェックしてから
  ## 地域名を付け替える
  xlsxdata[,1] <- guess_area_order_DB(xlsxdata[,1])

  ## 列名の定義
  suikei_colname <- c(
    "area_name",# area name
    "total_households",  # households
    "total_population",   # population total
    "male_population",    # population male
    "female_population",  # population female

    "annual_population_change", #yct 1年間の増減 総数
    "annual_natural_change",    #ycn 1年間の増減 自然
    "births_per_year",          #yib 1年間の増減 自然 出生
    "deaths_per_year",          #ydd 1年間の増減 自然 死亡
    "annual_net_migration",     #ycs 1年間の増減 社会

    "monthly_population_change", #mct 1月間の増減 総数
    "monthly_natural_change",    #mcn 1月間の増減 自然
    "births_monthly",            #mib 1月間の増減 自然 出生
    "deaths_montyly",            #mdd 1月間の増減 自然 死亡
    "monthly_net_migration",     #mcs 1月間の増減 社会

    "total_household_size",  # person per household 1世帯当たり人口
    "population_density"   # person per area size(km^2)  人口密度
  )

  ## 列名をつける
  colnames(xlsxdata) <- suikei_colname

  ## 時間を付ける
  ans <- xlsxdata %>%
    dplyr::mutate(observation_date = day)

  return(ans)

}
