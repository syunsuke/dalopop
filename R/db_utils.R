##############################################
# Execute SQL from File
# sqlite3 command is needed
##############################################
exec_sqlfile_by_SQLiteCLI <- function(db,sqlfile){
  system(sprintf("sqlite3 %s < %s", shQuote(db), shQuote(sqlfile)))
}

