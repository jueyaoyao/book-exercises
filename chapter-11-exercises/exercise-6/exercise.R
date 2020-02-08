# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
average_dest_delay <- as.data.frame(
  flights %>%
    group_by(dest) %>%
    summarise(avg_delay = mean(arr_delay, na.rm = TRUE))
)
airports_delay <- left_join(average_dest_delay, airports, by = c("dest" = "faa"))
pull(
  airports_delay %>% 
    filter(avg_delay == max(avg_delay, na.rm = TRUE)),
  dest
)

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
average_airline_delay <- as.data.frame(
  flights %>%
    group_by(carrier) %>%
    summarise(avg_delay = mean(arr_delay, na.rm = TRUE))
)
airlines_delay <- left_join(average_airline_delay, airlines, by = "carrier")
pull(
  airlines_delay %>% 
    filter(avg_delay == max(avg_delay, na.rm = TRUE)),
  name
)
