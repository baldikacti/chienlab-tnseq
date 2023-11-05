arg <- commandArgs(trailingOnly = TRUE)
# Extract locus_tag
locus_tag <- read.delim(arg[1], header = FALSE, sep = "\t")$V4
tab_ls <- list.files(path = arg[2], pattern = ".tab", full.names = TRUE)
tab_nm <- gsub(".tab", "", basename(tab_ls))
# Read all .tab files and change column names to filenames
tab_df <- mapply(\(x, y) {
  df <- read.delim(x, header = TRUE, sep = "\t")
  colnames(df)[2] <- y
  return(df)
}, tab_ls, tab_nm, SIMPLIFY = FALSE)
# converts the list into dataframe
tab_df <- lapply(tab_df, \(x) subset(x, select = -c(locus_tag)))
tab_df <- do.call(cbind, tab_df)
tab_df <- data.frame(locus_tag = locus_tag, tab_df)
write.table(tab_df, arg[3], quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)