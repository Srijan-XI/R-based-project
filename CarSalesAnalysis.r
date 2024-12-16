# Load necessary libraries
library(ggplot2)
library(dplyr)

# Generate Synthetic Car Sales Data
set.seed(123) # For reproducibility
car_sales <- data.frame(
  SaleID = 1:1000,
  CarBrand = sample(c("Toyota", "Honda", "Ford", "BMW", "Mercedes"), 1000, replace = TRUE),
  SaleDate = sample(seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day"), 1000, replace = TRUE),
  SalePrice = round(runif(1000, 20000, 80000), 2), # Prices between $20,000 and $80,000
  UnitsSold = sample(1:5, 1000, replace = TRUE)
)

# Display the first few rows of the dataset
head(car_sales)

# Summary statistics
summary(car_sales)

# Total sales per brand
brand_sales <- car_sales %>%
  group_by(CarBrand) %>%
  summarise(TotalSales = sum(SalePrice * UnitsSold),
            UnitsSold = sum(UnitsSold)) %>%
  arrange(desc(TotalSales))

print(brand_sales)

# Plot: Total Sales by Brand
ggplot(data = brand_sales, aes(x = reorder(CarBrand, TotalSales), y = TotalSales, fill = CarBrand)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Total Sales by Car Brand", x = "Car Brand", y = "Total Sales ($)") +
  theme_minimal()

# Monthly Sales Trend
car_sales$Month <- format(car_sales$SaleDate, "%Y-%m") # Extract month
monthly_sales <- car_sales %>%
  group_by(Month) %>%
  summarise(TotalSales = sum(SalePrice * UnitsSold))

# Plot: Monthly Sales Trend
ggplot(data = monthly_sales, aes(x = as.Date(paste0(Month, "-01")), y = TotalSales)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red") +
  labs(title = "Monthly Car Sales Trend", x = "Month", y = "Total Sales ($)") +
  theme_minimal()

# Scatter Plot: Sale Price vs Units Sold
ggplot(data = car_sales, aes(x = SalePrice, y = UnitsSold, color = CarBrand)) +
  geom_point(alpha = 0.6) +
  labs(title = "Scatter Plot: Sale Price vs Units Sold", x = "Sale Price ($)", y = "Units Sold") +
  theme_minimal()

# Save the dataset to a CSV file
write.csv(car_sales, "car_sales_data.csv", row.names = FALSE)