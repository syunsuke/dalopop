# 人口修正済値（前回国勢調査以前）
#
# DB_syusei
# 平成２７年（２０１５年）１１月から令和２年（２０２０年）９月まで
# 列名に準じる行??11列



###########################################
# DB用
###########################################
DB_read_syusei <- function(filepath){

  # シートを把握
  sheet_names <- openxlsx::getSheetNames(file = filepath)

  ans <- NULL

  for(i in seq_along(sheet_names)){

    # 左右別々の処理
    l_data <- DB_syusei_sub_left(filepath, sheet_names[i])
    r_data <- DB_syusei_sub_right(filepath, sheet_names[i])

    # 列名
    syusei_colname <- c(
      "area_name",# area name
      "total_households",  # households
      "total_population",   # population total
      "male_population",    # population male
      "female_population"  # population female
    )
    colnames(l_data) <- syusei_colname
    colnames(r_data) <- syusei_colname

    # 統合
    tmp <- dplyr::bind_rows(l_data,r_data)

    # 地域名の並びをチェック
    # 地域名を一意の名前に変更
    check_area_v002_DB(tmp[,1])
    tmp[,1] <- area_name_v002_DB

    # 日付列の追加
    tmp <- tmp %>%
      dplyr::mutate(observation_date = rabbit::fetch_date_from_string(sheet_names[i]))

    ans <- dplyr::bind_rows(ans, tmp)
  }

  return(ans)

}


DB_syusei_sub_left <- function(filepath, sheet){

  # 読み込み
  df <-
    openxlsx::read.xlsx(filepath,
                        sheet,
                        colNames = FALSE,
                        startRow = 7,
                        cols = (1:6)
                        )

  # 人口のない行を省く
  df <- df[!is.na(df[,3]),]

  # 選択と加工
  ans <- df %>%
    dplyr::mutate(X1 = paste0(X1,X2) %>%
             stringr::str_replace_all("\\s", "") %>%
             stringr::str_replace_all("NA", ""))
  ans <- ans[,c(1,3:6)]

  return(ans)
}

DB_syusei_sub_right <- function(filepath, sheet){

  # 読み込み
  df <-
    openxlsx::read.xlsx(filepath,
                        sheet,
                        colNames = FALSE,
                        startRow = 7,
                        cols = (7:11)
                        )

  # 人口のない行を省く
  df <- df[!is.na(df[,2]),]

  # 選択と加工
  ans <- df %>%
    dplyr::mutate(X1 = X1 %>%
             stringr::str_replace_all("\\s", "") %>%
             stringr::str_replace_all("NA", ""))
  return(ans)
}


