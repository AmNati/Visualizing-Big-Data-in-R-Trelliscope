
# R packages for this project

pacman::p_load(hexbin, 
               fst,
               ggcorrplot,
               trelliscopejs, 
               plotly,
               tibble,
               ggplot2,
               data.table)


# Task 1: Too many points - point size, transparency, transformations


#In this section I look at the LA home prices dataset to explore ways of reducing overplotting.


## Exploring the dataset

data_file <- "data/LAhomes.csv"


Read in the dataset from `data_file`, assigning the result to `la_homes`. Explore it (using whichever functions you like).

la_homes <- read_csv(data_file)

# Explore it
glimpse(la_homes)

# Using la_homes, plot price vs. sqft with point layer
ggplot(la_homes, aes(sqft, price)) +
  geom_point()


## Changing point size

#Notice that points in the plot are heavily overplotted in the bottom left corner.

#Redraw the basic scatter plot, changing the point size to `0.5`.

# Draw same scatter plot, with size 0.5
ggplot(la_homes, aes(sqft, price)) +
  geom_point(size = 0.5)


#Redraw the basic scatter plot, changing the point shape to be "pixel points".


# Draw same scatter plot, with pixel shape
ggplot(la_homes, aes(sqft, price)) +
  geom_point(shape = ".")


## Using transparency

#Redraw the basic scatter plot, changing the transparency level of points to `0.25`. Set a white background by using ggplot2's black and white theme.


# Draw same scatter plot, with transparency 0.25 and black & white theme
ggplot(la_homes, aes(sqft, price)) +
  geom_point(alpha = 0.25) +
  theme_bw()

## Transform the axes

# Most of the plots are stuck in the bottom-left corner. Transform the x and y axes to spread points more evenly throughout.

# Redraw the basic scatter plot, applying a log10 transformation to the x and y scales.


# Draw same scatter plot, with log-log scales
ggplot(la_homes, aes(sqft, price)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()


Redraw the scatter plot using all three tricks at once.

#Set the point size to `0.5`.
#Set the point transparency to `0.25`.
#Using log10 transformations for the x and y scales.
#Use the black and white theme.


# Draw same scatter plot, with all 3 tricks
ggplot(la_homes, aes(sqft, price)) +
  geom_point(size = 0.5, alpha = 0.25) +
  scale_x_log10() +
  scale_y_log10() +
  theme_bw()


## Hex plots

#Draw a hex plot of `price` versus `sqft`.


# Using la_homes, plot price vs. sqft with hex layer
ggplot(la_homes, aes(sqft, price)) +
  geom_hex()


#Redraw the hex plot, applying log10 transformations to the x and y scales.


# Draw same hex plot, with log-log scales
ggplot(la_homes, aes(sqft, price)) +
  geom_hex() +
  scale_x_log10() +
  scale_y_log10()



# Observe that log price increases roughly linearly with log area.
# the majority of the houses are found in the region of lightest blues on the hex plot.


# Task 2: Aligned values - jittering


#Here we'll take another look at overplotting in the LA homes dataset.

## Learning objectives

- Understands that one cause of overplotting in scatter plots is low-precision, integer, or categorical variables taking exactly the same values.
- Can apply jittering, transparency, and scale transformations to solve the problem.

## Loading the packages

# You'll need `readr`, `dplyr` and `ggplot2`. Just run this code.

# bed contains the number of bedrooms in the home.

# Take a look at the distinct values in bed using distinct()`.


# Look at the distinct values of the bath column
la_homes %>% 
  distinct(bed)

#Notice that the number of bedrooms is always an integer and sometimes zero.

## Scatter plots of price vs. bedrooms

#Using la_homes, draw a scatter plot of `price` versus `bed`.


# Using la_homes, plot price vs. bed with a point layer
ggplot(la_homes, aes(bed, price)) +
  geom_point()




# Draw the same plot again, this time jittering the points along the x-axis.

# Use a maximum jitter distance of `0.4` in the x direction.
# Don't jitter in the y direction.


# Draw the previous plot but jitter points with width 0.4
ggplot(la_homes, aes(bed, price)) +
  geom_jitter(width = 0.4, height = 0)


# Most of the points are near the bottom of the plot.

# Draw the same jittered plot again, this time using a log10 transformation on the y-scale.


# Draw the previous plot but use a log y-axis
ggplot(la_homes, aes(bed, price)) +
  geom_jitter(width = 0.4, height = 0) +
  scale_y_log10()


## Scatter plots of bathrooms vs. bedrooms

# bath contains the number of bathrooms in the home.

# Take a look at the distinct values in `bath` using `distinct()`.


# Look at the distinct values of the bath column
la_homes %>% distinct(bath)


#Notice that the dataset includes half and quarter bathrooms (whatever they are).
# Draw a scatter plot of bath versus bed.
# Using la_homes, plot bath vs. bed with a point layer
ggplot(la_homes, aes(bed, bath)) +
  geom_point()


# Draw the same plot again, this time jittering the points.
# Use a maximum jitter distance of `0.4` in the x direction.
# Use a maximum jitter distance of `0.05` in the y direction.
# Using la_homes, plot bath vs. bed with a jittered point layer
ggplot(la_homes, aes(bed, bath)) +
  geom_jitter(width = 0.4, height = 0.05)


## Filtering and transformation
# There are three homes with 10 or more bedrooms. These constitute outliers, and for the purpose of drawing nicer plots, we're going to remove them.
# Filter `la_homes` for rows where `bed` is less than to `10`, assigning to `la_homes10`.
# Count the number of rows you removed to check you've done it correctly.
# Filter for bed less than 10
la_homes10 <- la_homes %>% filter(bed < 10)

# Calculate the number of outliers  removed
nrow(la_homes) - nrow(la_homes10)


# Draw the same jittered scatter plot again, this time using the filtered dataset (`la_homes10`). 
# As before, use a jitter width of `0.4` and a jitter height of `0.05`.


# Draw the previous plot, but with the la_homes10 dataset
ggplot(la_homes10, aes(bed, bath)) +
  geom_jitter(width = 0.4, height = 0.05)


# Most of the points are towards the bottom left of the plot.
# Draw the same jittered scatter plot again, this time applying square-root transformations to the x and y scales.
# Draw the previous plot but with sqrt-sqrt scales
ggplot(la_homes10, aes(bed, bath)) +
  geom_jitter(width = 0.4, height = 0.05) +
  scale_x_sqrt() +
  scale_y_sqrt()


# Refine the plot one more time, by making the points transparent.
# Draw the previous plot again, setting the transparency level to 0.25 (and using a black and white theme).
# Draw the previous plot but with transparency 0.25
ggplot(la_homes10, aes(bed, bath)) +
  geom_jitter(width = 0.4, height = 0.05, alpha = 0.25) +
  scale_x_sqrt() +
  scale_y_sqrt()



# Task 3: Too many variables - correlation heatmaps
# Here we'll look at a dataset on Scotch whisky preferences.

## Learning objectives
# draw a correlation heatmap.
# use hierarchical clustering to order cells in a correlation heatmap.
# adjust the color scale in a correlation heatmap.
# interpret a correlation heatmap.Loading the packages



## Get the dataset
#The dataset is a modified version of `bayesm::Scotch`. 
# Import from scotch.fst
scotch <- read_fst("data/scotch.fst")

# Explore the dataset, however you wish
glimpse(scotch)


## Draw a basic correlation heatmap
# Calculate the correlation matrix for `scotch`, assigning to `correl`.
# Calculate the correlation matrix
correl <- cor(scotch)


# Draw a correlation heatmap of it (no customization)
ggcorrplot(correl)


## Drop redundant cells
# Draw the previous plot again, this time only showing the upper triangular portion of the correlation matrix.
# Draw a correlation heatmap of the upper triangular portion
ggcorrplot(correl, type = "upper")


## Use hierarchical clustering
# Draw the previous plot again, this time using hierarchical clustering to reorder cells.
# Draw a correlation heatmap of the upper triangular portion
ggcorrplot(correl, type = "upper", hc.order = TRUE)


# Override the color scale
# Set the diagonal values in the correlation matrix to `NA`, then calculate the range of the correlation matrix.
# Set the diagonals of correl to NA
diag(correl) <- NA

# Calculate the range of correl (removing NAs)
range(correl, na.rm = TRUE)


# We have both positive and negative correlations, so this is a slightly trickier situation than in the slides. We want a symmetric color scale centered on zero.

# Define the limits of the color scale.
# Calculate the `max`imum `abs`olute correlation (removing NAs). Assign to `max_abs_correl`.
# Add some padding to `max_abs_correl` (any small number). Assign to `max_abs_correl_padded`.
# Define the scale limits as the vector (`-max_abs_correl_padded`, `max_abs_correl_padded`).
# Calculate the largest absolute correlation (removing NAs)
max_abs_correl <- max(abs(correl), na.rm = TRUE)

# Add some padding
max_abs_correl_padded <- max_abs_correl + 0.02

# Define limits from -max_abs_correl_padded to max_abs_correl_padded
scale_limits <- c(-max_abs_correl_padded, max_abs_correl_padded)

#Draw the previous plot again, this time overriding the fill color scale.

# Add `scale_fill_gradient2()`.
# Pass the scale limits.
# Set the `high` argument to `"red"`.
# Set the `mid` argument to `"white"`.
# Set the `low` argument to `"blue"`.

# Draw a correlation heatmap of the upper triangular portion
# Override the fill scale to use a 2-way gradient
ggcorrplot(correl, type = "upper", hc.order = TRUE) +
  scale_fill_gradient2(
    limits = scale_limits,
    high = "red",
    mid = "white",
    low = "blue"
  )


## Interpreting correlation heatmaps
#Drinkers of Glenfiddich are most likely to also drink Glenlivet
# Drinkers of Knockando are most likely to also drink Macallan


# Task 4: Too many facets - trelliscope plots

Here, you'll explore the 30 stocks in the Dow Jones Industrial Average (DJIA).

## Learning objectives

- Can convert a ggplot into a trelliscope plot.
- Can use common arguments to control the appearance of a trelliscope plot.
- Can use the interactive filter and sort tools to interpret a trelliscope plot.

## Load the packages

You'll need `fst`, `tibble`, `ggplot2`, and `trelliscopejs`. Just run this code.


## Get the dataset

Depending on how you are accessing this file, you may need to run this to download the data file. Remove the `eval = FALSE` option to make it run.


Import the DJIA data from `dow_stock_prices.fst`, assigning to `dow_stock_prices`. Explore it however you wish.
# Import the dataset from dow_stock_prices.fst
dow_stock_prices <- read_fst("data/dow_stock_prices.fst")

# Explore the dataset, however you wish
glimpse(dow_stock_prices)

# Get the range of the dates in dow_stock_prices
range(dow_stock_prices$date)


## From ggplot2 to trelliscopejs
# Using `dow_stock_prices`, draw a line plot of `relative` versus `date`, faceted by `symbol`.


# Using dow_stock_prices, plot relative vs. date
# as a line plot
# faceted by symbol
ggplot(dow_stock_prices, aes(date, relative)) +
  geom_line() +
  facet_wrap(vars(symbol))


# Redraw the previous plot, this time as a trelliscope plot (no customization). 

# Set the `path` argument to `"trelliscope/basic"`.
# Same plot as before, using trelliscope
ggplot(dow_stock_prices, aes(date, relative)) +
  geom_line() +
  facet_trelliscope(
    vars(symbol), 
    path = "trelliscope/basic"
  )


## Improving the plot
# We can improve on the previous plot by customizing it.
# Redraw the previous plot, with the following changes.
# Set the `path` argument to `"trelliscope/improved"`.
# Set the plot title to `Dow Jones Industrial Average`.
# Set the plot description to `Share prices 2017-01-01 to 2020-01-01`.
# Arrange the panels in `5` rows of `2` columns per page. 
# Increase the width of each panel to `1200` pixels.


# Draw the same plot again, customizing the display
# Set path, name, desc, nrow, ncol, width
ggplot(dow_stock_prices, aes(date, relative)) +
  geom_line() +
  facet_trelliscope(
    vars(symbol),
    path = "trelliscope/improved",
    name = "Dow Jones Industrial Average",
    desc = "Share prices 2017-01-01 to 2020-01-01",
    nrow = 5, 
    ncol = 2,
    width = 1200
  )


## Labels
# Add the `company` to the labels shown on each panel.

## Filtering
# Information Technology sector contains the most companies
#Exxon Mobil `Energy` sector company began 2020 with a lower share price than 2017



## Free scales

# The relative share prices were plotted to make it easier to compare performance between companies. If you want to plot the non-normalized `adjusted` prices, you need to give each panel its own y-axis.

# Redraw the previous plot, with these changes.
# Set the `path` argument to `"trelliscope/yscale"`.
# On the y-axis, plot `adjusted` rather than `relative`.
# Give each panel a free y-axis scale (while keeping the x-axis scales the same).


# This time plot adjusted vs. date
# Use a free y-scale
ggplot(dow_stock_prices, aes(date, adjusted)) +
  geom_line() +
  facet_trelliscope(
    vars(symbol),
    path = "trelliscope/yscale",
    name = "Dow Jones Industrial Average",
    desc = "Share prices 2017-01-01 to 2020-01-01",
    nrow = 5, 
    ncol = 2,
    width = 1200,
    scales = c("same", "free")
  )


## Interactive plotting with plotly

# By using plotly to create each panel, each panel becomes interactive. Hover over the line to see the values of individual points.
# Redraw the previous plot, using plotly to create the panels.
# Set the `path` argument to `"trelliscope/plotly"`.

# Redraw the last plot using plotly for panels
ggplot(dow_stock_prices, aes(date, adjusted)) +
  geom_line() +
  facet_trelliscope(
    vars(symbol),
    path = "trelliscope/plotly",
    name = "Dow Jones Industrial Average",
    desc = "Share prices 2017-01-01 to 2020-01-01",
    nrow = 5, 
    ncol = 2,
    width = 1200,
    scales = c("same", "free"),
    as_plotly = TRUE
  )


# Verizon had a dip in its share price in December 2018. 
