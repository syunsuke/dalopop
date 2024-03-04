# format_pop02
# 平成２７年（２０１５年）１１月から令和２年（２０２０年）９月まで
# 列名に準じる行??11列
read_pop02 <- function(filepath){

  # フォーマットの形式チェック
  if(guess_dataformat(filepath) != "format_pop02"){
    message(sprintf("%s is not format_pop02",filepath))
    message("reading this file has skipped.")
    return(NA)
  }

  # シートを把握
  sheet_names <- openxlsx::getSheetNames(file = filepath)

  ans <- NULL

  for(i in seq_along(sheet_names)){

    # 左右別々の処理
    l_data <- sub_left(filepath, sheet_names[i])
    r_data <- sub_right(filepath, sheet_names[i])

    # 統合して地域名の並びをチェック
    tmp <- dplyr::bind_rows(l_data,r_data)
    check_area_order(tmp$area)

    # 日付列の追加
    tmp <- tmp %>%
      dplyr::mutate(date = rabbit::fetch_date_from_string(sheet_names[i]))

    # 地域名を一意の名前に変更
    tmp$area <- cityID[,2]

    ans <- dplyr::bind_rows(ans, tmp)
  }

  return(ans)

}

sub_left <- function(filepath, sheet){

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

  # 列名の割り振り
  colnames(ans) <- pop02_colname
  return(ans)
}

sub_right <- function(filepath, sheet){

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
  colnames(ans) <- pop02_colname
  return(ans)
}


pop02_colname <- c(
  "area",# area name
  "hh",  # households
  "pt",  # population total
  "pm",  # polulation male
  "pf"  # polulation female
)


