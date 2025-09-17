#' Initialize SQLite database
#'
#' @param dbname Character. Path or file name of the SQLite database to initialize.
#'   If only a name is provided, the file will be created in the working directory.
#'   Defaults to "population_osaka.sqlite".
#'
#' @returns No return value, called for side effects.
#' @export
#'
#' @examples
#' \dontrun{
#' dalopop_init_sqlite()
#' }
dalopop_init_sqlite <- function(dbname = "population_osaka.sqlite"){

  # データベース作成
  con <- DBI::dbConnect(RSQLite::SQLite(), dbname)

# テーブルの作成

## census
DBI::dbExecute(con, "DROP TABLE IF EXISTS census")
DBI::dbExecute(con, "
  CREATE TABLE census(
  `area_name` TEXT,
  `total_population` INTEGER,
  `male_population` INTEGER,
  `female_population` INTEGER,
  `total_households` INTEGER,
  `households` INTEGER,
  `households_member` INTEGER,
  `household_size` REAL,
  `population_density` REAL,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")

## suikei
DBI::dbExecute(con, "DROP TABLE IF EXISTS suikei")
DBI::dbExecute(con, "
  CREATE TABLE suikei(
  `area_name` TEXT,
  `total_households` INTEGER,
  `total_population` INTEGER,
  `male_population` INTEGER,
  `female_population` INTEGER,
  `annual_population_change` INTEGER,
  `annual_natural_change` INTEGER,
  `births_per_year` INTEGER,
  `deaths_per_year` INTEGER,
  `annual_net_migration` INTEGER,
  `monthly_population_change` INTEGER,
  `monthly_natural_change` INTEGER,
  `births_monthly` INTEGER,
  `deaths_montyly` INTEGER,
  `monthly_net_migration` INTEGER,
  `total_household_size` REAL,
  `population_density` REAL,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")

## syusei
DBI::dbExecute(con, "DROP TABLE IF EXISTS syusei")
DBI::dbExecute(con, "
  CREATE TABLE syusei(
  `area_name` TEXT,
  `total_households` INTEGER,
  `total_population` INTEGER,
  `male_population` INTEGER,
  `female_population` INTEGER,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")

###################################
# suikei_5sai_v001 85歳まで
###################################
## suikei_5sai_total_v001
DBI::dbExecute(con, "DROP TABLE IF EXISTS suikei_5sai_total_v001")
DBI::dbExecute(con, "
  CREATE TABLE suikei_5sai_total_v001(
  `area_name` TEXT,
  `age_total` INTEGER,
  `age_00_04` INTEGER,
  `age_05_09` INTEGER,
  `age_10_14` INTEGER,
  `age_15_19` INTEGER,
  `age_20_24` INTEGER,
  `age_25_29` INTEGER,
  `age_30_34` INTEGER,
  `age_35_39` INTEGER,
  `age_40_44` INTEGER,
  `age_45_49` INTEGER,
  `age_50_54` INTEGER,
  `age_55_59` INTEGER,
  `age_60_64` INTEGER,
  `age_65_69` INTEGER,
  `age_70_74` INTEGER,
  `age_75_79` INTEGER,
  `age_80_84` INTEGER,
  `age_85plus` INTEGER,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")

## suikei_5sai_male_v001
DBI::dbExecute(con, "DROP TABLE IF EXISTS suikei_5sai_male_v001")
DBI::dbExecute(con, "
  CREATE TABLE suikei_5sai_male_v001(
  `area_name` TEXT,
  `age_total` INTEGER,
  `age_00_04` INTEGER,
  `age_05_09` INTEGER,
  `age_10_14` INTEGER,
  `age_15_19` INTEGER,
  `age_20_24` INTEGER,
  `age_25_29` INTEGER,
  `age_30_34` INTEGER,
  `age_35_39` INTEGER,
  `age_40_44` INTEGER,
  `age_45_49` INTEGER,
  `age_50_54` INTEGER,
  `age_55_59` INTEGER,
  `age_60_64` INTEGER,
  `age_65_69` INTEGER,
  `age_70_74` INTEGER,
  `age_75_79` INTEGER,
  `age_80_84` INTEGER,
  `age_85plus` INTEGER,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")

## suikei_5sai_female_v001
DBI::dbExecute(con, "DROP TABLE IF EXISTS suikei_5sai_female_v001")
DBI::dbExecute(con, "
  CREATE TABLE suikei_5sai_female_v001(
  `area_name` TEXT,
  `age_total` INTEGER,
  `age_00_04` INTEGER,
  `age_05_09` INTEGER,
  `age_10_14` INTEGER,
  `age_15_19` INTEGER,
  `age_20_24` INTEGER,
  `age_25_29` INTEGER,
  `age_30_34` INTEGER,
  `age_35_39` INTEGER,
  `age_40_44` INTEGER,
  `age_45_49` INTEGER,
  `age_50_54` INTEGER,
  `age_55_59` INTEGER,
  `age_60_64` INTEGER,
  `age_65_69` INTEGER,
  `age_70_74` INTEGER,
  `age_75_79` INTEGER,
  `age_80_84` INTEGER,
  `age_85plus` INTEGER,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")


###################################
# suikei_5sai_v002 95歳まで
###################################

## suikei_5sai_total_v002
DBI::dbExecute(con, "DROP TABLE IF EXISTS suikei_5sai_total_v002")
DBI::dbExecute(con, "
  CREATE TABLE suikei_5sai_total_v002 (
  `area_name` TEXT,
  `age_total` INTEGER,
  `age_00_04` INTEGER,
  `age_05_09` INTEGER,
  `age_10_14` INTEGER,
  `age_15_19` INTEGER,
  `age_20_24` INTEGER,
  `age_25_29` INTEGER,
  `age_30_34` INTEGER,
  `age_35_39` INTEGER,
  `age_40_44` INTEGER,
  `age_45_49` INTEGER,
  `age_50_54` INTEGER,
  `age_55_59` INTEGER,
  `age_60_64` INTEGER,
  `age_65_69` INTEGER,
  `age_70_74` INTEGER,
  `age_75_79` INTEGER,
  `age_80_84` INTEGER,
  `age_85_89` INTEGER,
  `age_90_94` INTEGER,
  `age_95plus` INTEGER,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")

## suikei_5sai_male_v002
DBI::dbExecute(con, "DROP TABLE IF EXISTS suikei_5sai_male_v002")
DBI::dbExecute(con, "
  CREATE TABLE suikei_5sai_male_v002 (
  `area_name` TEXT,
  `age_total` INTEGER,
  `age_00_04` INTEGER,
  `age_05_09` INTEGER,
  `age_10_14` INTEGER,
  `age_15_19` INTEGER,
  `age_20_24` INTEGER,
  `age_25_29` INTEGER,
  `age_30_34` INTEGER,
  `age_35_39` INTEGER,
  `age_40_44` INTEGER,
  `age_45_49` INTEGER,
  `age_50_54` INTEGER,
  `age_55_59` INTEGER,
  `age_60_64` INTEGER,
  `age_65_69` INTEGER,
  `age_70_74` INTEGER,
  `age_75_79` INTEGER,
  `age_80_84` INTEGER,
  `age_85_89` INTEGER,
  `age_90_94` INTEGER,
  `age_95plus` INTEGER,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")

## suikei_5sai_female_v002
DBI::dbExecute(con, "DROP TABLE IF EXISTS suikei_5sai_female_v002")
DBI::dbExecute(con, "
  CREATE TABLE suikei_5sai_female_v002 (
  `area_name` TEXT,
  `age_total` INTEGER,
  `age_00_04` INTEGER,
  `age_05_09` INTEGER,
  `age_10_14` INTEGER,
  `age_15_19` INTEGER,
  `age_20_24` INTEGER,
  `age_25_29` INTEGER,
  `age_30_34` INTEGER,
  `age_35_39` INTEGER,
  `age_40_44` INTEGER,
  `age_45_49` INTEGER,
  `age_50_54` INTEGER,
  `age_55_59` INTEGER,
  `age_60_64` INTEGER,
  `age_65_69` INTEGER,
  `age_70_74` INTEGER,
  `age_75_79` INTEGER,
  `age_80_84` INTEGER,
  `age_85_89` INTEGER,
  `age_90_94` INTEGER,
  `age_95plus` INTEGER,
  `observation_date` TEXT,
  PRIMARY KEY (area_name, observation_date)
  )
  ")

DBI::dbDisconnect(con)

f <-system.file("sql/view_base_data.sql",package = "dalopop")
exec_sqlfile_by_SQLiteCLI(dbname,f)

f <-system.file("sql/view_monthly_change_data.sql",package = "dalopop")
exec_sqlfile_by_SQLiteCLI(dbname,f)

f <-system.file("sql/view_three_age_groups_rate.sql",package = "dalopop")
exec_sqlfile_by_SQLiteCLI(dbname,f)

f <-system.file("sql/view_age_5year_groups_rate.sql",package = "dalopop")
exec_sqlfile_by_SQLiteCLI(dbname,f)

f <-system.file("sql/view_age_5year_short_groups_rate.sql",package = "dalopop")
exec_sqlfile_by_SQLiteCLI(dbname,f)

f <-system.file("sql/view_population_data.sql",package = "dalopop")
exec_sqlfile_by_SQLiteCLI(dbname,f)

f <-system.file("sql/view_population_short_data.sql",package = "dalopop")
exec_sqlfile_by_SQLiteCLI(dbname,f)
}

