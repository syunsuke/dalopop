# format_5sai
# 列名に準じる行?? 22列
read_5sai <- function(filepath){

  # フォーマットの形式チェック
  if(guess_dataformat(filepath) != "format_5sai"){
    message(sprintf("%s is not format_5sai",filepath))
    message("reading this file has skipped.")
    return(NA)
  }

  # データ読込
  d <- openxlsx::read.xlsx(filepath,
                           colNames = FALSE,
                           startRow = 4)

  # このファイルの時点を探索
  tmp_d <- openxlsx::read.xlsx(filepath, colNames = FALSE)
  day <- tmp_d[2,1] %>% rabbit::fetch_date_from_string()

  ## 2024年1月以降日付部分の型が文字列から日付型に変更されている
  if (is.na(day)){
    day <- openxlsx::convertToDate(as.numeric(tmp_d[2,1]))
  }

  # 2列目がNA（人口データのない)行を削除
  d <- d[!is.na(d[,2]),]

  # 1列目（市区町村名）の文字列に含まれる空白を削除
  d[,1] <- stringr::str_replace_all(d[,1], "\\s", "")

  # 2列目が「市区町村」（人口データのない)行を削除
  #d <- d[!stringr::str_detect(d[,1],"市区町村"),]
  d <- d[!stringr::str_detect(d[,1],"\u5e02\u533a\u753a\u6751"),]


  d[,2] <- as.numeric(d[,2])
  d[,3] <- as.numeric(d[,3])
  d[,4] <- as.numeric(d[,4])
  d[,5] <- as.numeric(d[,5])
  d[,6] <- as.numeric(d[,6])
  d[,7] <- as.numeric(d[,7])
  d[,8] <- as.numeric(d[,8])
  d[,9] <- as.numeric(d[,9])
  d[,10] <- as.numeric(d[,10])
  d[,11] <- as.numeric(d[,11])
  d[,12] <- as.numeric(d[,12])
  d[,13] <- as.numeric(d[,13])
  d[,14] <- as.numeric(d[,14])
  d[,15] <- as.numeric(d[,15])
  d[,16] <- as.numeric(d[,16])
  d[,17] <- as.numeric(d[,17])
  d[,18] <- as.numeric(d[,18])
  d[,19] <- as.numeric(d[,19])
  d[,20] <- as.numeric(d[,20])
  d[,21] <- as.numeric(d[,21])
  d[,22] <- as.numeric(d[,22])


  # a1は全体、a2は男、a3は女
  # 86行づつになっている
  a1 <- d[1:86,]
  a2 <- d[87:172,]
  a3 <- d[173:258,]

  # 名前の並びの確認
  check_area_order(a1[[1]])
  check_area_order(a2[[1]])
  check_area_order(a3[[1]])

  # 一意になるように先に地域名を付け替える
  a1[,1] <- cityID[,2]
  a2[,1] <- cityID[,2]
  a3[,1] <- cityID[,2]

  colnames(a1) <- total_5sai_colname
  a1 <- a1 %>%
    dplyr::mutate(t_chile = t_00_04 + t_05_09 + t_10_14,
                  t_young = t_15_19 + t_20_24 + t_25_29 + t_30_34 + t_35_39 +
                    t_40_44 + t_45_49 + t_50_54 + t_55_59 + t_60_64,
                  t_old   = t_65_69 + t_70_74 + t_75_79 + t_80_84 + t_85_89 +
                    t_90_94 + t_95_ )

  colnames(a2) <- male_5sai_colname
  a2 <- a2 %>%
    dplyr::mutate(m_chile = m_00_04 + m_05_09 + m_10_14,
                  m_young = m_15_19 + m_20_24 + m_25_29 + m_30_34 + m_35_39 +
                    m_40_44 + m_45_49 + m_50_54 + m_55_59 + m_60_64,
                  m_old   = m_65_69 + m_70_74 + m_75_79 + m_80_84 + m_85_89 +
                    m_90_94 + m_95_ )

  colnames(a3) <- female_5sai_colname
  a3 <- a3 %>%
    dplyr::mutate(f_chile = f_00_04 + f_05_09 + f_10_14,
                  f_young = f_15_19 + f_20_24 + f_25_29 + f_30_34 + f_35_39 +
                    f_40_44 + f_45_49 + f_50_54 + f_55_59 + f_60_64,
                  f_old   = f_65_69 + f_70_74 + f_75_79 + f_80_84 + f_85_89 +
                    f_90_94 + f_95_ )
  ans <- a1 %>%
    dplyr::left_join(a2,by="area") %>%
    dplyr::left_join(a3,by="area") %>%
    dplyr::mutate(date = day)

  return(ans)

}


total_5sai_colname <-
  c("area",
    "t_total",
    "t_00_04",
    "t_05_09",
    "t_10_14",
    "t_15_19",
    "t_20_24",
    "t_25_29",
    "t_30_34",
    "t_35_39",
    "t_40_44",
    "t_45_49",
    "t_50_54",
    "t_55_59",
    "t_60_64",
    "t_65_69",
    "t_70_74",
    "t_75_79",
    "t_80_84",
    "t_85_89",
    "t_90_94",
    "t_95_")


male_5sai_colname <-
  c("area",
    "m_total",
    "m_00_04",
    "m_05_09",
    "m_10_14",
    "m_15_19",
    "m_20_24",
    "m_25_29",
    "m_30_34",
    "m_35_39",
    "m_40_44",
    "m_45_49",
    "m_50_54",
    "m_55_59",
    "m_60_64",
    "m_65_69",
    "m_70_74",
    "m_75_79",
    "m_80_84",
    "m_85_89",
    "m_90_94",
    "m_95_")

female_5sai_colname <-
  c("area",
    "f_total",
    "f_00_04",
    "f_05_09",
    "f_10_14",
    "f_15_19",
    "f_20_24",
    "f_25_29",
    "f_30_34",
    "f_35_39",
    "f_40_44",
    "f_45_49",
    "f_50_54",
    "f_55_59",
    "f_60_64",
    "f_65_69",
    "f_70_74",
    "f_75_79",
    "f_80_84",
    "f_85_89",
    "f_90_94",
    "f_95_")

