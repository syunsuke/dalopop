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
