# =============================================================
# Cyclistic Case Study: Analysis of Member vs. Casual Riders
# Author: Sam Haufiku
# Date: 2026-02-03
# =============================================================

# Load libraries
library(tidyverse)
library(lubridate)
library(scales) # Added for better chart labels

# 1. Load Data (Using relative path for GitHub portability)
all_trips <- read_csv("Divvy_Trips_2020_Q1.csv")

# 2. Clean and Transform
all_trips_v2 <- all_trips %>%
  # Create metrics and day labels
  mutate(ride_length = as.numeric(difftime(ended_at, started_at, units = "secs")),
         day_of_week = wday(started_at, label = TRUE, abbr = TRUE)) %>%
  # Filter: Remove HQ/Test stations and extreme outliers
  filter(start_station_name != "HQ QR" | is.na(start_station_name)) %>%
  filter(ride_length >= 60 & ride_length <= 86400) # 1 min to 24 hours

# 3. Descriptive Analysis
summary_stats <- all_trips_v2 %>% 
  summarise(
    mean_min = round(mean(ride_length) / 60, 2),
    max_hours = round(max(ride_length) / 3600, 2)
  )

print(summary_stats)

# 4. Comparing Members vs. Casual Riders
user_comparison <- all_trips_v2 %>%
  group_by(member_casual) %>%
  summarise(
    number_of_rides = n(),
    avg_duration_mins = mean(ride_length) / 60
  )

print(user_comparison)

# 5. Visualizations

# Chart 1: Ride Volume
all_trips_v2 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(number_of_rides = n(), .groups = 'drop') %>% 
  ggplot(aes(x = day_of_week, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = comma) + # Makes numbers like 10,000 readable
  labs(title = "Total Number of Rides by Day of Week",
       subtitle = "Members maintain high volume during weekdays (commuting)",
       x = "Day of Week",
       y = "Number of Rides",
       fill = "User Type",
       caption = "Data Source: Divvy Trip Data") +
  theme_minimal()

# Chart 2: Duration
all_trips_v2 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(average_duration = mean(ride_length) / 60, .groups = 'drop') %>% 
  ggplot(aes(x = day_of_week, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Average Ride Duration by Day of Week",
       subtitle = "Casual riders consistently ride 2-3x longer than members",
       x = "Day of Week",
       y = "Average Duration (Minutes)",
       fill = "User Type") +
  theme_minimal()