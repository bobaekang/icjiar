#' Save list of tables at once
#'
#' \code{save_tables} exports the table input(s) to the designated directory
#' in \code{.csv}, \code{.feather}, or both formats.
#'
#' @param tables A list of data frames.
#' @param filenames A character vector of filenames.
#' @param dir A character value for a path to a directory where the tables will be stored.
#'   If missing, each table is exported to the working directory.
#' @param format A character value for the output format. \code{feather} or \code{csv}.
#'   If missing, each table is exported in both formats.
#' @examples
#' ## Export a single table
#' save_tables(tbl, "tbl")
#'
#' ## Export multiple tables
#' save_tables(list(tbl1, tbl2), c("tbl1", "tbl2"), dir="data", format="csv")
#' @export
save_tables <- function (tables, filenames, dir = NA, format = NA) {

  # sanity checks
  if (is.data.frame(tables)) {
    tables <- list(tables)
  } else if (!is.list(tables)) {
    stop("tables input must be a single data farme or a list of data frames.")
  }
  if (!is.character(filenames)) {
    stop ("filenames input must be a character vector.")
  }
  if (length(tables) != length(filenames)) {
    stop("tables and filenames must have the same length.")
  }

  # if dir is not NA, concatenate it before each filename
  if (!is.na(dir)) {
    if (!is.character(dir)) {
      stop("Invalid dir input. dir input must be NA or a character string.")
    } else if(!dir %in% list.dirs(recursive = FALSE)) {
      stop("Invalid dir input. dir input is not found in the current working directory.")
    }
    for (i in 1:length(filenames)) {
      filenames[i] <- paste(dir, filenames[i], sep = "/")
    }
  }

  # save tables according to the format input
  for (i in 1:length(filenames)) {
    table <- tables[[i]]
    filename_feather <- paste(filenames[i], "feather", sep = ".")
    filename_csv <- paste(filenames[i], "csv", sep = ".")

    if (is.na(format)) {
      message(paste("Saving", filename_feather), "...")
      feather::write_feather(table, filename_feather)
      message(paste("Saving", filename_csv), "...")
      data.table::fwrite(table, filename_csv)
    } else if (format == "feather") {
      feather::write_feather(tables[[i]], filename_feather)
    } else if (format == "csv") {
      data.table::fwrite(table, filename_csv)
    } else {
      stop("Invalid format input. format must be NA, \"feather\", or \"csv\".")
    }
  }
}
