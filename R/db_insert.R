insert_anyfile <- function(file, dbname){
  fileformat <- guess_DB_format(file)

  switch (fileformat,
    "DB_5sai_v001" = insert_5sai_v001(file, dbname),
    "DB_5sai_v002" = insert_5sai_v002(file, dbname),
    "DB_census_2020" = insert_census(file, dbname),
    "DB_syusei"      = insert_syusei(file, dbname),
    "DB_suikei_v001" = insert_suikei_v001(file, dbname),
    "DB_suikei_v002" = insert_suikei_v002(file, dbname),
    message(sprintf("%s is unknown format. so it's skipped."
                  ,basename(file)))
  )
}

insert_5sai_v001 <- function(file, dbname){
  dfs <- DB_read_5sai_v001(file)
  insert_and_ignore(dfs[[1]], "suikei_5sai_total_v001", dbname)
  insert_and_ignore(dfs[[2]], "suikei_5sai_male_v001", dbname)
  insert_and_ignore(dfs[[3]], "suikei_5sai_female_v001", dbname)
}

insert_5sai_v002 <- function(file, dbname){
  dfs <- DB_read_5sai_v002(file)
  insert_and_ignore(dfs[[1]], "suikei_5sai_total_v002", dbname)
  insert_and_ignore(dfs[[2]], "suikei_5sai_male_v002", dbname)
  insert_and_ignore(dfs[[3]], "suikei_5sai_female_v002", dbname)
}

insert_suikei_v001 <- function(file, dbname){
  df <- DB_read_suikei_v001(file)
  insert_and_ignore(df, "suikei", dbname)
}

insert_suikei_v002 <- function(file, dbname){
  df <- DB_read_suikei_v002(file)
  insert_and_ignore(df, "suikei", dbname)
}

insert_census <- function(file, dbname){
  df <- DB_read_census_2020(file)
  insert_and_ignore(df, "census", dbname)
}

insert_syusei <- function(file, dbname){
  df <- DB_read_syusei(file)
  insert_and_ignore(df, "syusei", dbname)
}

###################################################
# DBへはキーの重複の場合、
# エラーにせず、更新せず、
# そのまま終了（次の処理へ）
# 注意 dbWriteTable()の場合、エラーか上書きの２択で
#      大量ファイル処理の場合困る
###################################################

# 修正データをデータベースへ書き込み
insert_and_ignore <- function(df, table, dbname){

  # dfを書き込む前に必要な加工を行う
  # SQLite用に日付をテキスト化
  df$observation_date <-
    as.character(df$observation_date)

  # DBへは、ファイル毎に一時テーブルを作成し、
  # これを本テーブルへ引き渡すことで、
  # INSERT OR IGNORE（エラーさせない）を行う

  # DB接続
  con <- DBI::dbConnect(RSQLite::SQLite(), dbname)

  tmp_table <- sprintf("tmp_%s", table)

  sql001<-sprintf("DROP TABLE IF EXISTS %s;" ,tmp_table)
  DBI::dbExecute(con, sql001)

  sql002<-sprintf("
  CREATE TABLE %s AS
  SELECT * FROM %s
  LIMIT 0;
  ", tmp_table, table)
  DBI::dbExecute(con, sql002)

  ## トランザクション
  DBI::dbBegin(con)
  ok <- FALSE
  on.exit({
    if (!ok) DBI::dbRollback(con)
  }, add = TRUE)

  # 一時テーブルへ書き込み
  DBI::dbWriteTable(con, tmp_table, df, append = TRUE)

  # 本テーブルへ移し替え
  sql003 <- sprintf("
  INSERT OR IGNORE INTO %s
  SELECT * FROM %s;
  ", table, tmp_table)
  DBI::dbExecute(con, sql003)

  # 読み込み件数確認
  added <- DBI::dbGetQuery(con, "SELECT changes() AS inserted_rows;")$inserted_rows
  message(sprintf("%d records is inserted at %s",added,table))

  ## 掃除
  sql004 <- sprintf("DROP TABLE IF EXISTS %s;", tmp_table)
  DBI::dbExecute(con, sql004)

  DBI::dbCommit(con); ok <- TRUE

  # 切断
  DBI::dbDisconnect(con)
}
