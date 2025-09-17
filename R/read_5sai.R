# format_5sai_は全て修正値か推計値に割合を掛けたものであり
# その割合自体が真のデータのよう
#
# 現在のフォーマットは２種類
# v002 列が22 行数 95歳（地域少ない）
# v001 列が20 行数 85歳（地域多い）
#
# 出力は３つのテーブル
# list(total,male,female)のデータフレームで返す



DB_read_5sai_v002 <- function(filepath){

  # このファイルの時点を探索
  tmp_d <- openxlsx::read.xlsx(filepath, colNames = FALSE)
  day <- tmp_d[2,1] %>% rabbit::fetch_date_from_string()
  ## 2024年1月以降日付部分の型が文字列から日付型に変更されている
  if (is.na(day)){
    day <- openxlsx::convertToDate(as.numeric(tmp_d[2,1]))
  }

  # データ読込
  d <- openxlsx::read.xlsx(filepath,
                           colNames = FALSE,
                           startRow = 4)

  # 2列目がNA（人口データのない)行を削除
  d <- d[!is.na(d[,2]),]

  # 1列目（市区町村名）の文字列に含まれる空白を削除
  d[,1] <- stringr::str_replace_all(d[,1], "\\s", "")

  # 2列目が「市区町村」（人口データのない)行を削除
  #d <- d[!stringr::str_detect(d[,1],"市区町村"),]
  d <- d[!stringr::str_detect(d[,1],"\u5e02\u533a\u753a\u6751"),]

  ## 列名をつける
  suikei_5sai_colname <-
    c("area_name",
      "age_total",
      "age_00_04",
      "age_05_09",
      "age_10_14",
      "age_15_19",
      "age_20_24",
      "age_25_29",
      "age_30_34",
      "age_35_39",
      "age_40_44",
      "age_45_49",
      "age_50_54",
      "age_55_59",
      "age_60_64",
      "age_65_69",
      "age_70_74",
      "age_75_79",
      "age_80_84",
      "age_85_89",
      "age_90_94",
      "age_95plus")

  colnames(d) <- suikei_5sai_colname

  # 表題を含んで取り込むので型をあとから指定
  d <- d %>%
    dplyr::mutate(dplyr::across(2:22, as.numeric)) %>%
    dplyr::mutate(observation_date = day)

  # a1は全体、a2は男、a3は女
  # 86行づつになっている
  a1 <- d[1:86,]
  a2 <- d[87:172,]
  a3 <- d[173:258,]

  # 名前の並びの確認
  check_area_v002_DB(a1[[1]])
  check_area_v002_DB(a2[[1]])
  check_area_v002_DB(a3[[1]])

  # 一意になるように先に地域名を付け替える
  a1[,1] <- area_name_v002_DB
  a2[,1] <- area_name_v002_DB
  a3[,1] <- area_name_v002_DB

  return(list(a1,a2,a3))

}



DB_read_5sai_v001 <- function(filepath){

  # このファイルの時点を探索
  tmp_d <- openxlsx::read.xlsx(filepath, colNames = FALSE)
  day <- tmp_d[2,1] %>% rabbit::fetch_date_from_string()
  ## 2024年1月以降日付部分の型が文字列から日付型に変更されている
  if (is.na(day)){
    day <- openxlsx::convertToDate(as.numeric(tmp_d[2,1]))
  }

  # データ読込
  d <- openxlsx::read.xlsx(filepath,
                           colNames = FALSE,
                           startRow = 4)

  # 2列目がNA（人口データのない)行を削除
  d <- d[!is.na(d[,2]),]

  # 1列目（市区町村名）の文字列に含まれる空白を削除
  d[,1] <- stringr::str_replace_all(d[,1], "\\s", "")

  # 2列目が「市区町村」（人口データのない)行を削除
  #d <- d[!stringr::str_detect(d[,1],"市区町村"),]
  d <- d[!stringr::str_detect(d[,1],"\u5e02\u533a\u753a\u6751"),]

  ## 列名をつける
  suikei_5sai_short_colname <-
    c("area_name",
      "age_total",
      "age_00_04",
      "age_05_09",
      "age_10_14",
      "age_15_19",
      "age_20_24",
      "age_25_29",
      "age_30_34",
      "age_35_39",
      "age_40_44",
      "age_45_49",
      "age_50_54",
      "age_55_59",
      "age_60_64",
      "age_65_69",
      "age_70_74",
      "age_75_79",
      "age_80_84",
      "age_85plus")

  colnames(d) <- suikei_5sai_short_colname

  # 表題を含んで取り込むので型をあとから指定
  d <- d %>%
    dplyr::mutate(dplyr::across(2:20, as.numeric)) %>%
    dplyr::mutate(observation_date = day)


  # a1は全体、a2は男、a3は女
  # 93行づつになっている
  a1 <- d[1:93,]
  a2 <- d[94:186,]
  a3 <- d[187:279,]

  # 名前の並びの確認
  check_area_v001_DB(a1[[1]])
  check_area_v001_DB(a2[[1]])
  check_area_v001_DB(a3[[1]])

  # 一意になるように先に地域名を付け替える
  a1[,1] <- area_name_v001_DB
  a2[,1] <- area_name_v001_DB
  a3[,1] <- area_name_v001_DB

  return(list(a1,a2,a3))

}
