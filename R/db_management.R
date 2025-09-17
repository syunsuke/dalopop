#' Update SQLite database for Osaka Population
#'
#' @param dir_name Character
#'   Path to the directory where cache files are stored.
#' @param dbname Character
#'   Path or file name of the SQLite database to initialize.
#' @returns No return value, called for side effects.
#' @export
#'
#' @examples
#' \dontrun{
#' # Requires a live SQLite database
#' dalopop_update_sqlite("mycache","osaka_pop.sqlite")
#' }
dalopop_update_sqlite <- function(dir_name, dbname){

  excel_urls <- dalopop_get_data_urls()

  # 最新のリストのうちキャッシュされていないものをDL
  dalo::dalo_download_by_urls(urls = excel_urls,
                              dest_dir = dir_name,
                              check = TRUE,
                              make_dir = TRUE)

  # ダウンロードされているエクセルファイル
  files <- dir(dir_name, full.names = TRUE)

  # ファイルをデータベースに読み込み
  for (f in files) {
    insert_anyfile(f, dbname)
  }
}

#' Export to Excel file
#'
#' @param dbname Character
#'   Path or file name of the SQLite database to initialize.
#' @param age85 logical
#'   Whether to use the 85+ age group (default: TRUE).
#'   If FALSE, the age groups will extend to 95+ instead.
#' @param areas character vector
#'   Vector of place names to export (e.g., c("枚方市", "交野市")).
#'   Defaults to NULL, in which case all areas are exported.
#' @param areasheet logical
#'   Whether to create separate sheets for each area (default: TRUE).
#'   If FALSE, all areas are written to a single sheet.
#' @param output character
#'   Name of the Excel file to export. Defaults to NULL, in which case the file
#'   name is automatically generated as "osaka_population_YYYYMMDDHHMMSS.xlsx".
#'
#' @returns No return value, called for side effects.
#' @export
#' @examples
#' \dontrun{
#' # Requires a live SQLite database
#' dalopop_export_excel(db, areas = c("大阪市北区"))
#' }
dalopop_export_excel <- function(dbname,
                                 age85 = TRUE,
                                 areas = NULL,
                                 areasheet = TRUE,
                                 output = NULL){

  # 日付型の表示の指定
  options("openxlsx.dateFormat" = "yyyy/mm/dd")

  # 出力ファイル名
  if (is.null(output)){
    now <- Sys.time()
    output <- sprintf("osaka_population_%04d%02d%02d%02d%02d%02d.xlsx",
                      lubridate::year(now),
                      lubridate::month(now),
                      lubridate::day(now),
                      lubridate::hour(now),
                      lubridate::minute(now),
                      as.integer(lubridate::second(now))
                      )
  }

  #データベースからdf
  con <- DBI::dbConnect(RSQLite::SQLite(),dbname)

  # 85歳までデータかどうか
  table <- "view_population_data_total"
  if (age85) {table <- "view_population_data_total_short"}

  sql <- sprintf("SELECT * FROM %s;", table)
  df <- DBI::dbGetQuery(con, sql)
  DBI::dbDisconnect(con)

  if (areasheet){

    obj <-
      openxlsx::createWorkbook()

    #cityNamseの決定方法
    if (is.null(areas)){
      # デフォルトで短い方の定義名を使う
      cityNames <- area_name_v002_DB
    }else{
      # 定義済みの名前のみ受付る
      areas <- areas[areas %in% area_name_v001_DB]
      if (length(areas) == 0) {
        message("No valid area names.")
        message("So use defalt set.")
        # デフォルトで短い方の定義名を使う
        cityNames <- area_name_v002_DB
      }else{
        cityNames <- areas
      }
    }

    for (i in seq_along(cityNames)){
      cityName <- cityNames[i]
      openxlsx::addWorksheet(obj, sheetName = cityName)

      # 合体したdata.frame 「ans」から該当地域をフィルタリング
      tmp_data <-
        df %>%
        dplyr::filter(area_name == cityName) %>%
        dplyr::arrange(observation_date)

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

