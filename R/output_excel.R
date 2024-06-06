sub_easy_popdata <- function(dir){
  # エクセルファイルのURLのベクトルを得る
  file_urls <- dalopop_get_data_urls()

  # ファイルをダウンロード（既存ファイルはダウンロードしない）
  dalo::dalo_download_by_urls(urls = file_urls,
                        dest_dir = dir,
                        check = TRUE)

  # ダウンロードディレクトリ内のファイル一覧を
  # ファイルパスのベクトルにする
  datafiles <- dir(dir, full.names = TRUE)

  # ファイルパスを渡して読み込みdata.frameにする
  df <- dalopop_read_file(datafiles)

  return(df)
}


#' Get Easily ExcelData of population in osaka
#'
#' @param dir store download files directory
#' @param areasheet if TRUE, area goes into each sheet
#' @param output destinasion file name
#'
#' @export
dalopop_outputExcelData <- function(dir, areasheet = TRUE, output = NULL){

  # 日付型の表示の指定
  options("openxlsx.dateFormat" = "yyyy/mm/dd")

  # 出力ファイル名
  if (is.null(output)){
    now <- Sys.time()
    output <- sprintf("osakapop_%04d%02d%02d%02d%02d.xlsx",
                      lubridate::year(now),
                      lubridate::month(now),
                      lubridate::day(now),
                      lubridate::hour(now),
                      lubridate::minute(now))
  }

  # エクセルファイルからdf
  df <- sub_easy_popdata(dir)

  if (areasheet){

    obj <-
      openxlsx::createWorkbook()

    # 定義した地域名を使う
    cityNames <- cityID[[2]]

    for (i in seq_along(cityNames)){
      cityName <- cityNames[i]
      openxlsx::addWorksheet(obj, sheetName = cityName)

      # 合体したdata.frame 「ans」から該当地域をフィルタリング
      tmp_data <-
        df %>%
        dplyr::filter(area == cityName) %>%
        dplyr::relocate(date) %>%
        dplyr::arrange(date)

      openxlsx::writeData(obj,
                          sheet = cityName,
                          x = tmp_data)
    }

    openxlsx::saveWorkbook(obj,
                           file = output,
                           overwrite = TRUE)

  }else{

    openxlsx::write.xlsx(df,file = output)

  }

}


#' Get Easily Small ExcelData of population in osaka
#'
#' @param dir store download files directory
#' @param output destinasion file name
#'
#' @export
dalopop_outputSmallExcelData <- function(dir, output = NULL){

  # 日付型の表示の指定
  options("openxlsx.dateFormat" = "yyyy/mm/dd")

  # 出力ファイル名
  if (is.null(output)){
    now <- Sys.time()
    output <- sprintf("osakapop_%04d%02d%02d%02d%02d.xlsx",
                      lubridate::year(now),
                      lubridate::month(now),
                      lubridate::day(now),
                      lubridate::hour(now),
                      lubridate::minute(now))
  }

  # エクセルファイルからdf
  # いるものだけピックアップ
  df <- sub_easy_popdata(dir) %>%
    dplyr::select(area, date, hh, pt, t_child, t_young, t_old)

  # エクセルファイルオブジェクトを作成
  obj <- openxlsx::createWorkbook()

  # 定義した地域名を使う
  cityNames <- cityID[[2]]

  for (i in seq_along(cityNames)){
    cityName <- cityNames[i]
    openxlsx::addWorksheet(obj, sheetName = cityName)

    # 合体したdata.frame 「ans」から該当地域をフィルタリング
    tmp_data <-
      df %>%
      dplyr::filter(area == cityName) %>%
      dplyr::relocate(date) %>%
      dplyr::arrange(dplyr::desc(date)) %>%
      dplyr::rename(`総世帯数` = hh,
                    `総人口` = pt,
                    `地域名` = area,
                    `年少人口` = t_child,
                    `生産年齢人口` = t_young,
                    `老年人口` = t_old,
                    `時点` = date)

    openxlsx::writeData(obj,
                        sheet = cityName,
                        x = tmp_data)

    # 一行目の列名を常時見えるようにする
    openxlsx::freezePane(obj,
                         sheet = cityName,
                         firstRow = TRUE)

    # 数値部分をカンマ区切りにする
      hito_style <- openxlsx::createStyle(numFmt = "###,###人")

      openxlsx::addStyle(obj,
                         sheet = cityName,
                         style = hito_style,
                         cols = 4:7,
                         rows = 2:(nrow(tmp_data) + 1),
                         gridExpand = TRUE)

    # 数値部分をカンマ区切りにする
      setai_style <- openxlsx::createStyle(numFmt = "###,###世帯")

      openxlsx::addStyle(obj,
                         sheet = cityName,
                         style = setai_style,
                         cols = 3,
                         rows = 2:(nrow(tmp_data) + 1),
                         gridExpand = TRUE)

      openxlsx::setColWidths(obj,
                             sheet = cityName,
                             cols = 1:7,
                             widths = 15)

  }

  openxlsx::saveWorkbook(obj,
                         file = output,
                         overwrite = TRUE)

}

