#####################################################################
# ダウンロードデータのURLのベクトルを返す関数群
# データの種類毎に分ける
#
#  現在の推計データ
#   令和2年（2020年）11月1日から現在
#  suikei_current_urls()
#
#  以前（国調前）の推計データ
#   平成27年（2015年）11月1日 から 令和2年（2020年）9月1日　
#  suikei_previous_urls()
#
#  国調2020データ
#   令和2年（2020年）10月1日
#  census_2020_urls()
#
#  修正データ
#   平成27年（2015年）11月1日 から 令和2年（2020年）9月1日
#  syusei_urls()
#
#  年齢別人口に関するデータのURL
#  suikei_5sai_urls()
###################################################################

#' Get Osaka Population Excel File URLs
#'
#' This function returns the URLs of the official Excel files published by Osaka Prefecture,
#' which contain population statistics for Osaka Prefecture and its municipalities.
#'
#' @return A character vector. Each element is a URL pointing to an official Excel file
#' providing population data for Osaka Prefecture and its municipalities.
#'
#' @export
#' \dontrun{
#' @examples
#' urls <- dalopop_get_data_urls()
#' urls
#' }
dalopop_get_data_urls <- function(){
  ans <- c(suikei_current_urls(),
           suikei_previous_urls(),
           census_2020_urls(),
           syusei_urls(),
           suikei_5sai_urls())

  return(ans)
}



#//////////////////////////////////////////////////////////////////
# データファイルURLのベクトルを作成するルーチン
#//////////////////////////////////////////////////////////////////

# 最新国調後の推計値データ
# 現在は令和2年（2020年）11月1日から現在
suikei_current_urls <- function(){

  # 2025現在の大阪府の人口データ（月次）配布サイト（新しい）
  target_page <-
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-xlslist.html"

  my_prefix <- "https://www.pref.osaka.lg.jp"

  my_filename_pattern <-
    "jk20[0-9]{2}[0-9]{2}[0-9]{2}.*\\.xlsx$"

  links <-
    dalo::dalo_fetch_links(url = target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           prefix = my_prefix)
  return(links)
}

# 最新国調以前の推計値データ（修正前）
# 平成27年（2015年）11月1日 から 令和2年（2020年）9月1日
# 修正の重複があるデータ
suikei_previous_urls <- function(){

  # 2025現在の大阪府の人口データ（月次）配布サイト（古い）
  target_page <-
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-h2.html"

  my_prefix <- "https://www.pref.osaka.lg.jp"

  my_filename_pattern_001 <-
    "jk20[0-9]{2}[0-9]{2}[0-9]{2}.*\\.xlsx$"

  my_filename_pattern_002 <-
    "jtsukikakuhou20[0-9]{4}.*\\.xlsx$"

  links_001 <-
    dalo::dalo_fetch_links(url = target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern_001,
                           prefix = my_prefix)

  links_002 <-
    dalo::dalo_fetch_links(url = target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern_002,
                           prefix = my_prefix)

  return(c(links_001,links_002))
}


# 国調2020.10.1
# 令和2年（2020年）10月1日
census_2020_urls <- function(){

  # 2020 国勢調査の大阪府版詳細ファイル
  target_page <-
    "https://www.pref.osaka.lg.jp/o040090/toukei/top_portal/kokucho.html"

  my_prefix <- "https://www.pref.osaka.lg.jp"

  my_filename_pattern <- "r2.*_syousai\\.xlsx$"

  links <-
    dalo::dalo_fetch_links(url = target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           #encoding = "shift_jis",
                           prefix = my_prefix)
  return(links)

}

# 国調後の修正済みデータ
# 平成27年（2015年）11月1日 から 令和2年（2020年）9月1日
syusei_urls <- function(){

  # 2024現在の大阪府の人口データ（月次）配布サイト（古い）
  target_page <-
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-h.html"

  my_prefix <- "https://www.pref.osaka.lg.jp"

  my_filename_pattern <-
    "hosei20[0-9]{2}[0-9]{2}_[0-9]{2}.*\\.xlsx$"

  links <-
    dalo::dalo_fetch_links(url = target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           prefix = my_prefix)
  return(links)

}

# 年齢別人口に関するデータのURL
suikei_5sai_urls <- function(){

  new_target_page <-
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-xlslist.html"

  old_target_page <-
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-h2.html"

  my_prefix <- "https://www.pref.osaka.lg.jp"

  my_filename_pattern = "5sai.*\\.xlsx$"

  # 新しいデータに関するページ
  links_001 <-
    dalo::dalo_fetch_links(url = new_target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           encoding = "UTF-8",
                           prefix = my_prefix)

  # 古いデータに関するページ
  links_002 <-
    dalo::dalo_fetch_links(url = old_target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           encoding = "UTF-8",
                           prefix = my_prefix)

  # 新しい、古いデータの統合
  return(c(links_001, links_002))
}

