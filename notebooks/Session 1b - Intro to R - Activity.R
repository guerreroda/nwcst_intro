
# =============================================================================
# ACTIVITY SOLUTION
# =============================================================================

# 1. Read (import) both files
us_gdp <- read.xlsx("us_gdp.xlsx")
us_stocks <- read.xlsx("us_stocks.xlsx")

# 2. Clean the data (check date columns data types)
us_gdp_clean <- us_gdp %>%
  mutate(date = make_date(date))

us_stocks_clean <- us_stocks %>%
  mutate(date = make_date(date))

# 3. Join the data frames
us_merged <- us_gdp_clean %>%
  left_join(us_stocks_clean, by = "date")

# 4. Obtain the average and standard deviation of the NASDAQ
nasdaq_stats <- us_merged %>%
  summarise(
    avg_nasdaq = mean(nasdaq, na.rm = TRUE),
    sd_nasdaq = sd(nasdaq, na.rm = TRUE)
  )

nasdaq_stats

# 5. Make a scatter plot
ggplot(us_merged, aes(x = nasdaq, y = real_gdp)) +
  geom_point(color = "darkblue", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between NASDAQ and GDP",
    x = "NASDAQ Index",
    y = "Real GDP"
  ) +
  theme_minimal()

# 6. Write (export) the merged data frame as a .xlsx file
write.xlsx(activity_merged, "us_merged.xlsx")
