# check()時の警告回避用データ
.onLoad <- function(libname, pkgname) {
  if (getRversion() >= "2.15.1") {
    utils::globalVariables(c("observation_date",
                             "area_name",
                             "X1","X2"
                             ))
  }
}
