# Load necessary libraries
library(quantmod)  # For stock market data
library(tidyverse) # For data manipulation and visualization

# Step 1: Fetch stock data
# Example: Analyze Apple's stock (AAPL) from Yahoo Finance
getSymbols("AAPL", src = "yahoo", from = "2020-01-01", to = "2023-12-31")

# Step 2: View the structure of the data
head(AAPL)
str(AAPL)

# Step 3: Convert to a data frame for easier manipulation
aapl_data <- data.frame(Date = index(AAPL), coredata(AAPL))
colnames(aapl_data) <- c("Date", "Open", "High", "Low", "Close", "Volume", "Adjusted")

# Step 4: Calculate moving averages
aapl_data <- aapl_data %>%
  arrange(Date) %>%
  mutate(
    SMA_50 = rollapply(Adjusted, width = 50, FUN = mean, align = "right", fill = NA),
    SMA_200 = rollapply(Adjusted, width = 200, FUN = mean, align = "right", fill = NA)
  )

# Step 5: Plot adjusted closing price with moving averages
ggplot(aapl_data, aes(x = Date)) +
  geom_line(aes(y = Adjusted, color = "Adjusted Close"), size = 1) +
  geom_line(aes(y = SMA_50, color = "50-Day SMA"), size = 0.8) +
  geom_line(aes(y = SMA_200, color = "200-Day SMA"), size = 0.8) +
  labs(
    title = "Apple (AAPL) Stock Price and Moving Averages",
    x = "Date",
    y = "Price (USD)"
  ) +
  scale_color_manual(values = c("Adjusted Close" = "blue", "50-Day SMA" = "orange", "200-Day SMA" = "red")) +
  theme_minimal()

# Step 6: Calculate daily returns
aapl_data <- aapl_data %>%
  mutate(Daily_Return = (Adjusted / lag(Adjusted) - 1) * 100)

# Step 7: Plot daily returns
ggplot(aapl_data, aes(x = Date, y = Daily_Return)) +
  geom_line(color = "green", size = 0.7) +
  labs(
    title = "Daily Returns of Apple Stock",
    x = "Date",
    y = "Daily Return (%)"
  ) +
  theme_minimal()

# Step 8: Calculate volatility (standard deviation of daily returns)
volatility <- sd(aapl_data$Daily_Return, na.rm = TRUE)
cat("Annualized Volatility:", round(volatility * sqrt(252), 2), "%\n")  # Assuming 252 trading days in a year

# Step 9: Save the results
ggsave("aapl_stock_moving_averages.png", width = 8, height = 5)
ggsave("aapl_daily_returns.png", width = 8, height = 5)
write.csv(aapl_data, "aapl_stock_analysis.csv", row.names = FALSE)
