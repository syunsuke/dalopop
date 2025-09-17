# format_cens 令和２年（２０２０年）１０月
# 列名に準じる行?? 4列
# 各国勢調査毎に用意する
# データはどこから入手してもよいが、大阪府のページとして

DB_read_census_2020 <- function(filepath){

  tmp_data <-
    openxlsx::read.xlsx(filepath,
                        colNames = FALSE,
                        #sheet = "表9-1",
                        sheet = "\u88689-1",
                        rows = c(6:56,63:103))

  # 2列目がNA（人口データのない)行を削除
  tmp_data <- tmp_data[!is.na(tmp_data[,2]),]

  # 1列目（市区町村名）の文字列に含まれる空白を削除
  # 見えないカタカナを消す処理
  tmp_data  <-
    tmp_data %>%
    dplyr::mutate(X1 = X1 %>%
                    stringr::str_replace_all("\\s", "") %>%

                    #stringr::str_replace_all("チイキ$", "") %>%
                    stringr::str_replace_all("\u30c1\u30a4\u30ad$", "") %>%

                    #stringr::str_replace_all("カワチ$", "") %>%
                    stringr::str_replace_all("\u30ab\u30ef\u30c1$", "") %>%

                    #stringr::str_replace_all("チョウ$", "") %>%
                    stringr::str_replace_all("\u30c1\u30e7\u30a6$", "") %>%

                    #stringr::str_replace_all("ハラ$", "") %>%
                    stringr::str_replace_all("\u30cf\u30e9$", "") %>%

                    #stringr::str_replace_all("シ$", "") %>%
                    stringr::str_replace_all("\u30b7$", "") %>%

                    #stringr::str_replace_all("ク$", "") %>%
                    stringr::str_replace_all("\u30af$", "") %>%

                    #stringr::str_replace_all("[（|）]", ""))
                    stringr::str_replace_all("[\uff08|\uff09]", ""))


  # 採取する列
  tmp_data <- tmp_data[,c(1:4,7:11)]


  ## 列名の定義
  census_colname <- c(
    "area_name",# area name
    "total_population",   # population total
    "male_population",    # population male
    "female_population",  # population female

    "total_households",  # total households count(施設、病院含む)
    "households",  # households count
    "households_member",  # households member
    "household_size",  # person per household 1世帯当たり人口
    "population_density"   # person per area size(km^2)  人口密度
  )

  colnames(tmp_data) <- census_colname

  # 名前の並びの確認と置き換え
  check_area_v002_DB(tmp_data[,1])
  tmp_data[,1] <- area_name_v002_DB

  ans <- tmp_data %>%
    dplyr::mutate(observation_date = lubridate::as_date("2020/10/1"))

  return(ans)
}

