#Global
library(shiny)
library(shinyjs)
library(jpeg)
library(reshape2)
library(ggplot2)
library(tictoc)
library(data.table)
library(plotly)
# install.packages("plotly")

# library("devtools")
# install_github("ropensci/plotly")

Sys.setenv("plotly_username"="Judalpalau")
Sys.setenv("plotly_api_key"="e3hiU9HPliqxKbf0nQHH")

# 
# mtcars$am[which(mtcars$am == 0)] <- 'Automatic'
# mtcars$am[which(mtcars$am == 1)] <- 'Manual'
# mtcars$am <- as.factor(mtcars$am)
# 
# plot_ly(mtcars, x = ~wt, y = ~hp, z = ~qsec, color = ~am, colors = c('#BF382A', '#0C4B8E')) %>%
#   add_markers() %>%
#   layout(scene = list(xaxis = list(title = 'Weight'),
#                       yaxis = list(title = 'Gross horsepower'),
#                       zaxis = list(title = '1/4 mile time')))
# 
# # Create a shareable link to your chart
# # Set up API credentials: https://plot.ly/r/getting-started
# chart_link = api_create(p, filename="3dImage")
# chart_link
# 
# plot_ly(midwest, x = ~percollege, color = ~state, type = "box")
