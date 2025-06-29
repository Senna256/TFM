library(quantmod)
library(tidyquant)



# Definir símbols i dates
symbols <- c("^GSPC", "^IBEX", "^IXIC", "AMZN", "AAPL", "MSFT", "NVDA", "META", "BRK.B", 
             "GOOGL", "TSLA", "JPM", "LLY", "IBE", "ITX", "SAN", "CLNX", "BBVA", "AMS", 
             "TEF", "CABK", "FER", "AENA")

start_date <- "2010-01-01"
end_date <- "2025-03-31"

# Descarregar dades
data_list <- lapply(symbols, function(sym) {
  tryCatch({
    getSymbols(sym, src = "yahoo", from = start_date, to = end_date, auto.assign = FALSE)
  }, error = function(e) {
    message(paste("Error amb", sym, ":", e$message))
    return(NULL)
  })
})

# Convertir en un data frame
data_df <- do.call(merge, data_list)
data_df <- data.frame(Date = index(data_df), coredata(data_df)) 

# Guardar a CSV
write.csv(data_df, "preus_tancament_r.csv", row.names = TRUE)
print("✅ Dades guardades a preus_tancament_r.csv")
