lapply(logs, function(x) '[[' (x, "timestamp"))
results <- sapply(logs, `[[`, "success")
vapply(logs, length, integer(1))
vapply(logs, `[[`, "success", FUN.VALUE=logical(1))