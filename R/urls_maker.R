#####################################################################
# ダウンロードデータのURLのベクトルを返す関数群
# データの種類毎に分ける
#
# 令和2年（2020年）11月1日から現在
#  pop_new_urls()
#
# 令和2年（2020年）10月1日
#  pop_2020_urls()
#  1ファイル
#
# 平成27年（2015年）11月1日 から 令和2年（2020年）9月1日
#  pop_old_urls()
#  6ファイル
#
# 年齢別人口に関するデータのURL
# pop_5age_urls()
#
###################################################################

#' Get population excel files urls
#'
#' @return vector of file ulrs
#' @export
dalopop_get_data_urls <- function(){
  ans <- c(pop_new_urls(),
           pop_old_urls(),
           pop_2020_urls(),
           pop_5age_urls())

  return(ans)
}



#//////////////////////////////////////////////////////////////////
# popデータファイルURLのベクトルを作成するルーチン
#//////////////////////////////////////////////////////////////////

# 令和2年（2020年）11月1日から現在
#  pop_new_urls()
pop_new_urls <- function(){

  # 2024現在の大阪府の人口データ（月次）配布サイト（新しい）
  target_page <-
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-xlslist.html"

  my_prefix <- "https://www.pref.osaka.lg.jp"

  my_filename_pattern = "jk20[0-9]{2}[0-9]{2}[0-9]{2}.*\\.xlsx$"

  links <-
    dalo::dalo_fetch_links(url = target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           prefix = my_prefix)
  return(links)
}

# 令和2年（2020年）10月1日
#  pop_2020_urls()
pop_2020_urls <- function(){

  # 2020 国勢調査の大阪府版詳細ファイル
  target_page <-
    #"https://www.pref.osaka.lg.jp/toukei/top_portal/kokucho.html"
    #"https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-h.html"
    "https://www.pref.osaka.lg.jp/o040090/toukei/top_portal/kokucho.html"

  my_prefix <- "https://www.pref.osaka.lg.jp"
  ## https://www.pref.osaka.lg.jp/attach/42622/00426107/R2kokutyo_osakahu_kakuhou_syousai.xlsx
  my_filename_pattern = "r2.*_syousai\\.xlsx$"

  links <-
    dalo::dalo_fetch_links(url = target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           #encoding = "shift_jis",
                           prefix = my_prefix)
  return(links)

}

# 平成27年（2015年）11月1日 から 令和2年（2020年）9月1日
#  pop_old_urls()
pop_old_urls <- function(){

  # 2024現在の大阪府の人口データ（月次）配布サイト（古い）
  target_page <-
    #"https://www.pref.osaka.lg.jp/toukei/jinkou/jinkou-h.html"
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-h.html"
  my_prefix <- "https://www.pref.osaka.lg.jp"

  # https://www.pref.osaka.lg.jp/attach/3387/00040392/hosei202001_09.xlsx
  my_filename_pattern = "hosei20[0-9]{2}[0-9]{2}_[0-9]{2}.*\\.xlsx$"

  links <-
    dalo::dalo_fetch_links(url = target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           #encoding = "shift_jis",
                           prefix = my_prefix)
  return(links)

}

# 年齢別人口に関するデータのURL
# pop_5age_urls()
pop_5age_urls <- function(){

  new_target_page <-
    #"https://www.pref.osaka.lg.jp/toukei/jinkou/jinkou-xlslist.html"
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-xlslist.html"

  old_target_page <-
    #"https://www.pref.osaka.lg.jp/toukei/jinkou/jinkou-h.html"
    "https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-h2.html"

  my_prefix <- "https://www.pref.osaka.lg.jp"

  # https://www.pref.osaka.lg.jp/attach/3387/00040392/hosei202001_09.xlsx
  my_filename_pattern = "5sai.*\\.xlsx$"

  # 新しいデータに関するページ
  newdata_link <-
    dalo::dalo_fetch_links(url = new_target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           encoding = "UTF-8",
                           prefix = my_prefix)

  # 古いデータに関するページ
  olddata_link <-
    dalo::dalo_fetch_links(url = old_target_page,
                           selector = "tbody td",
                           filename_pattern = my_filename_pattern,
                           encoding = "UTF-8",
                           prefix = my_prefix)

  # 新しい、古いデータの統合
  ans_link <- c(newdata_link,olddata_link)

  return(ans_link)
}

