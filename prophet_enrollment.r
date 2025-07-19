library(prophet)
library(dplyr)
library(readr)
library(ggplot2)

# data
df <- read.csv("D:/EMRTS/3.Medicaid Enrollment and Expenditure Forecasting  Project/MA_medicaid_enrollment.csv") # Adjust the path as necessary
df$ds <- as.Date(paste0(df$ds, "-01"))

# model
model <- prophet(df)

# Create future dates
future <- make_future_dataframe(model, periods = 10 * 12, freq = "month")
# Make forecast
forecast <- predict(model, future)

# plot the forecast
p <- plot(model, forecast)

p + 
  ggtitle("Forecast of Time Series (Yearly)") +
  xlab("Year") +
  ylab("Value") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 14),
    legend.position = "bottom"
  ) +
  scale_x_datetime(date_labels = "%Y") +
  scale_color_manual(values = c("yhat" = "#1f77b4", "yhat_lower" = "#aec7e8", "yhat_upper" = "#aec7e8")) +
  labs(color = "Legend")

ggsave("D:/EMRTS/3.Medicaid Enrollment and Expenditure Forecasting  Project/results/enrollment_forecast_plot_Prophet.png", plot = p, width = 12, height = 6, dpi = 300)

# save results
write.csv(forecast, "D:/EMRTS/3.Medicaid Enrollment and Expenditure Forecasting  Project/results/enrollment_forecast_Prophet_MA.csv", row.names = FALSE)
