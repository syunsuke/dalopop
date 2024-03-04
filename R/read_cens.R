# format_cens 令和２年（２０２０年）１０月
# 列名に準じる行?? 4列
read_cens <- function(filepath){

  # フォーマットの形式チェック
  if(guess_dataformat(filepath) != "format_cens"){
    message(sprintf("%s is not format_cens",filepath))
    message("reading this file has skipped.")
    return(NA)
  }

  tmp_data <-
    openxlsx::read.xlsx(filepath,
                        colNames = FALSE,
                        #sheet = "表9-1",
                        sheet = "\u88689-1",
                        rows = c(6:56,63:103))

  # 2列目がNA（人口データのない)行を削除
  tmp_data <- tmp_data[!is.na(tmp_data[,2]),]

  rn <- nrow(tmp_data)
  # 1列目（市区町村名）の文字列に含まれる空白を削除
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

  tmp_data <- tmp_data[,c(1:4,7,11)]

  # 列名の割り振り
  colnames(tmp_data) <- cens_colname

  # 名前の並びの確認
  check_area_order(tmp_data$area)

  # 名前を付け替える
  tmp_data[,1] <- cityID[,2]

  ans <- tmp_data %>%
    dplyr::mutate(pph = pt / hh,
                  date = lubridate::as_date("2020/10/1"))


  return(ans)
}

cens_colname <- c(
  "area",# area name
  "pt",  # population total
  "pm",  # polulation male
  "pf",  # polulation female

  "hh",  # households

  "ppa"   # person per area size(km^2)  人口密度
)
