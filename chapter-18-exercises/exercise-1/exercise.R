# load relevant libraries
library("httr")
library("jsonlite")
library("dplyr")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Warm Bodies"


# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
base_uri <- "https://api.nytimes.com/svc/movies/v2/"
movie_review_request <- content(GET(paste(base_uri, "reviews/search.json", sep = ""), 
                      query = list(query = movie_name, "api-key" = nyt_key)),
                "text")

#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!


# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
movie_data <- fromJSON(movie_review_request)

# What kind of data structure did this produce? A data frame? A list?
# It's a list

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
movie_data$results

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- movie_data$results

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
most_recent <- as.list(reviews %>%
  filter(publication_date == max(as.Date(publication_date, format = "%Y-%m-%d"))))
movie_headline <- most_recent$headline
movie_summary <- most_recent$summary_short
link <- most_recent$link$url



# Create a list of the three pieces of information from above. 
# Print out the list.
review_info <- list(headline = movie_headline, 
                    summary = movie_summary, 
                    review_link = link)