test_that("db_init creates a dbfile and tables", {
  tmpfile <- tempfile(fileext = ".sqlite")

  dalopop_init_sqlite(tmpfile)

  # db file が作られたか？
  expect_true(file.exists(tmpfile))

  # DBに接続できるか
  con <- DBI::dbConnect(RSQLite::SQLite(), tmpfile)
  on.exit(DBI::dbDisconnect(con), add = TRUE)

  # 接続が有効か
  expect_true(DBI::dbIsValid(con))

  # population テーブルが存在するか
  tables <- DBI::dbListTables(con)
  expect_tables <-
    c("census",
      "suikei",
      "syusei",
      "suikei_5sai_total_v001",
      "suikei_5sai_total_v002",
      "suikei_5sai_male_v001",
      "suikei_5sai_male_v002",
      "suikei_5sai_female_v001",
      "suikei_5sai_female_v002"
      )
  expect_true(all(expect_tables %in% tables))

  # 主キー制約のテスト（重複を入れたらエラーになるか）
  DBI::dbExecute(con, "INSERT INTO census (observation_date, area_name, total_population) VALUES('2025-01-01','大阪市',100)")
  expect_error(
    DBI::dbExecute(con, "INSERT INTO census (observation_date, area_name, total_population) VALUES('2025-01-01','大阪市',200)"),
    regexp = "UNIQUE|PRIMARY|constraint",
    ignore.case = TRUE
  )


})
