
#' Export report from SQLite database to Excel file
#'
#' @param cities Character vector. Names of cities (or regions) to filter.
#' @param db Character. File name of the SQLite database (e.g., "population.db").
#' @param dir dir Character. Directory path where the Excel file will be saved.
#'   Must exist; otherwise, an error will be raised.
#' @returns No return value, called for side effects.
#' @export
#'
#' @examples
#' \dontrun{
#'   dalopop_report_by_excel(
#'     cities = c("枚方市", "寝屋川市"),
#'     db = "population.db",
#'     dir = "output"
#'   )
#' }
#'


dalopop_report_by_excel <- function(cities, db, dir = "./"){


  # データベースの最新内容をdata.frameで受け取る
  con <- DBI::dbConnect(RSQLite::SQLite(), db)
  df <- DBI::dbGetQuery(con,
                 "SELECT * FROM view_population_data_total_short;")
  DBI::dbDisconnect(con)

  # システムのExcelテンプレートを読み込む
  template <-
    system.file("template/populaiton_report_template_0001.xlsx",
                package = "dalopop")

  # 出力ファイル名作成用日付文字列
  now <- Sys.time()
  date_str <- sprintf("%04d%02d%02d",
                      lubridate::year(now),
                      lubridate::month(now),
                      lubridate::day(now))

  # 地域名ベクトルから一つづつ処理
  for(i in cities){
    ans <- df %>%
        dplyr::filter(area_name == i) %>%
        # SQLiteからエクセルへの場合の日付の処理
        dplyr::mutate(observation_date = as.Date(observation_date)) %>%
        # テンプレートの都合上新しいものから古いものへ
        dplyr::arrange(dplyr::desc(observation_date))

    # 入力地域名での検索でデータがないもの（綴り間違い等）は
    # ファイルの出力をしない
    if(nrow(ans) >= 1) {
      # 出力ファイル名文字列
      outfile <- sprintf("%s/dalopop_report_%s_%s.xlsx",
                         dir, i, date_str)

      # ファイルの出力処理
      export_a_report_inner(ans, template, outfile)
      message(sprintf("export %s",outfile))

    }else{
      message(sprintf("No Data for %s. So Skipping",i))
    }

  }
}

#########################################################
# data.frameとテンプレートからエクセルファイルを出力
# 内部コマンド
#########################################################
export_a_report_inner <- function(df, template, exportfile){

  wb <- XLConnect::loadWorkbook(template, create = FALSE)

  # データをシート"source"に書き込み
  # df は R のデータフレーム
  XLConnect::writeWorksheet(wb,
                            data = df,
                            sheet = "source",
                            header = TRUE,
                            rownames = FALSE,
                            startRow = 1,
                            startCol = 1)

  # 発行日付書き込み
  XLConnect::writeWorksheet(wb,
                            data = as.Date(Sys.Date()),
                            sheet = "t_data",
                            header = FALSE,
                            rownames = FALSE,
                            startRow = 59,
                            startCol = 2)

  # エクセルを開いた時に再読込される設定
  XLConnect::setForceFormulaRecalculation(wb,sheet = "*",TRUE)

  # 保存（上書き）
  XLConnect::saveWorkbook(wb, file = exportfile)
}

