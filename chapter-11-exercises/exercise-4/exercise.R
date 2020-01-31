# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
install.packages("dplyr")
library("nycflights13")
library("dplyr")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
dim(flights)
colnames(flights)
??flights

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights <- mutate(flights, gain_in_air = -arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, -gain_in_air)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- flights %>%
  mutate(gain_in_air = -arr_delay - dep_delay) %>%
  arrange(-gain_in_air)

# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$gain_in_air, xlim = c(-500,200))

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
summarise(flights, mean_air_gain = mean(gain_in_air, na.rm = TRUE))
# On average flights lost time

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
seatac_dest <- filter(
  select(flights, origin, dest, gain_in_air),
  dest == "SEA")

# On average, did flights to SeaTac gain or loose time?
summarise(seatac_dest, mean_air_gain = mean(gain_in_air, na.rm = TRUE))
# On average flights lost time

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
flights %>%
  filter(origin == "JFK" & dest == "SEA") %>%
  summarise(mean_air_time = mean(air_time, na.rm = TRUE),
            min_air_time = min(air_time, na.rm = TRUE),
            max_air_time = max(air_time, na.rm = TRUE))
