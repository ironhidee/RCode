# logs is available in your workspace

# Add default value for property argument
extract_info <- function(x, property="success") {
  info <- c()
  for (log in x) {
    info <- c(info, log[[property]])
  }
  return(info)
}

# Calling extract_info() on logs
extract_info(logs)

# Calling extract_info() on logs  by setting property to "timestamp"
extract_info(logs, "timestamp")