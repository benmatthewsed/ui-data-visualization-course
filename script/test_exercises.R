# Introduction to Data Visualization with ggplot2

# Ben Matthews (University of Edinburgh) and Eilidh Jack (University of Glasgow)

# 2020-06-29


# First load the package we'll need ---------------------------------------

# We have to tell R this before we can use ggplot2

library(tidyverse)


# Load in our data --------------------------------------------------------

# In R <- is called the 'assignment operator'
# you can pronounce it 'gets'
# the thing on the right hand side of the <- is assigned to the name
# on the left hand side

# here we're reading in one data file called 'simd'
# and then a second one called 'simd_2020_shp

# This assumes you have the files saved in a folder called
# 'data' that is a sub-folder of R's current working
# directory

simd <- readRDS(file.path("data", "simd_series.rds"))
simd_2020_shp <- readRDS(file.path("data", "simd_2020_shp.rds"))

# alternatively you can read in the files directly with the commands below

# simd <- readRDS(gzcon(url("https://github.com/benmatthewsed/ui-data-visualization-course/blob/master/data/simd_series.rds?raw=true")))
# simd_2020_shp <- readRDS(gzcon(url("https://github.com/benmatthewsed/ui-data-visualization-course/blob/master/data/simd_2020_shp.rds?raw=true")))

# You can read about SIMD here - https://www2.gov.scot/Topics/Statistics/SIMD


# getting started ---------------------------------------------------------



# 1. our first plot

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point()


# 2.  plot with different variables

ggplot(
  data = simd,
  mapping = aes(x = access, y = crime)
) + 
  geom_point()

# 3. plot with even more different variables

ggplot(
  data = simd,
  mapping = aes(x = overall, y = simd)
) + 
  geom_point()


# 4. plot with two layers

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point() + 
  geom_line()


# 5. plot with two layers and a layer-specific aesthetic

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point() + 
  geom_line(aes(group = council_area))

# 6. plot with two layers and a layer-specific aesthetic

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point() + 
  geom_line(aes(colour = council_area))


# 7. moving the layer-specific aesthetic to global mapping

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime, colour = council_area)
) + 
  geom_point() + 
  geom_line()

# 6. DO NOT DO THIS

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point(aes(x = access, y = health)) + 
  geom_line(aes(group = council_area))

# QUESTION: what's so stupid about this plot?

# Take a minute to discuss in your group why
# this is such a bad idea


# 8. fixed values for geom parameters

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(colour = "blue")


# 9. fixed values for geom parameters; size

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(size = 2)

# 10. fixed values for geom parameters

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(size = 2,
             colour = "blue")


# 9. fixed values in call to aes()

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(aes(colour = "blue", size = 2))

# wait, this... sort of works?


# 10. layer-specific values

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    data = simd_2020_shp,
    aes(colour = "blue", size = 2)
    ) +
  geom_point(
    data = simd,
    colour = "blue"
  )

# 11. The neatest parameters: alpha

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    alpha = 0.3
  )


# to see more available options
# go to https://ggplot2.tidyverse.org/reference/
# type ggplot2::geom_ and hit tab
# scroll through the available geoms and try adding them to the plot



# Types of geom -----------------------------------------------------------



# Plot every row ----------------------------------------------------------

# we saw these already!

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    alpha = 0.3
  )


# how about text instead of points?

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_text()


# Plot a summary of data --------------------------------------------------




# one variable 

# note that we're only supplying an x variable here not a y variable!
# ggplot2 calculates the y variables for us

ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_histogram()


# try changing the bins argument


ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_histogram(
    bins = 10
  )

# ... and again


ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_histogram(
    bins = 100
  )

# how about a different geom?

ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_density()


# advanced- why can't you plot geom_density and geom_histogram
# together?
# NB look at the y-axis

# read this answer - https://stackoverflow.com/questions/37404002/geom-density-to-match-geom-histogram-binwitdh
# and try

ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_histogram(
    bins = 100
  ) +
  geom_density(aes(y=100 * ..count..))



# two variables - geom_smooth ---------------------------------------------

# This is probably the most common two-variable transformation

# "Smoothed conditional means" - i.e. regression line

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_smooth()

# okay, but what about the points?
# we can just add geom_point as another layer!
# and they will both inherit x and y from the call to 
# `aes()`

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_smooth() + 
  geom_point()

# changing the method

# we got a message that
# `geom_smooth()` using method = 'loess' and formula 'y ~ x'

# using the method argument we can change this
# to a bunch of other regression lines!

# linear regression - straight line

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() + 
  geom_smooth(
    method = "lm"
  )

# a different type of wiggly line: Generalized Additive Model

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() + 
  geom_smooth(
    method = "gam"
  )

# ADVANCED: look at the different smooth options
# at https://ggplot2.tidyverse.org/reference/geom_smooth.html
# try out a few different ones!



# one continuous one discrete variable

ggplot(
  data = simd,
  mapping = aes(x = region, y = overall)
) +
  geom_point() + 
  geom_boxplot()




# other settings

# to me this is basically magic already, but because the smooth
# is just another geom you can add aesthetic value just as we
# did before

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
    mapping = aes(colour = region)
  )

# try again with year


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
    mapping = aes(colour = simd)
  )


# something weird going on there in the East?

# If you want to remove the confidence
# intervals you can with the se parameter
# (but do you want to do this...? Discuss in your group!)

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
    mapping = aes(colour = region),
    se = FALSE
  )


# NB this regression model is calculated inside the ggplot2
# call so you can't (easily) access it
# if you want a complicated smooth, better to fit the model
# outside ggplot2 and then plot the 'smoothed conditional mean'
# based on your own model

# read this - https://socviz.co/modeling.html#modeling
# for more on how

# how about we map colour to a less sensible variable


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
    mapping = aes(colour = council_area)
  )


# uh oh

# why is this less sensible than mapping to region?

# advanced
# geoms that try to calculate a summary of the data won't work well
# if you give them single data point

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
    mapping = aes(colour = interaction(council_area, simd))
  )



# other two-variable summaries --------------------------------------------


# geom_density_2d

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_density_2d()

# again we can add more aesthetics

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_density_2d(
    mapping = aes(colour = region)
  )

# ... maybe not! This is perhaps too much information...


# Plot something else altogether -----------------------------------------------

# we can add a reference line to the previous plot

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = 3500
  )

# and a horizontal line

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = 3500
  ) +
  geom_hline(
    yintercept = 3500
  )

# how about a diagonal line
# slope = 1 and intercept = 0 is a good idea

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = 3500
  ) +
  geom_hline(
    yintercept = 3500
  ) +
  geom_abline(
    slope = 1,
    intercept = 0
  )


# To add a variaable from our dataframe as text we can
# just pass this to the aes(label = ) setting in geom_text

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = 3500
  ) +
  geom_hline(
    yintercept = 3500
  ) +
  geom_text(
    aes(label = overall)
  )

# this is a lot of information though...

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = 3500
  ) +
  geom_hline(
    yintercept = 3500
  ) +
  geom_text(
    aes(label = council_area)
  )


# we can also add a new dataframe of labels
# and supply this to the data argument of geom_text


# this was a bit mind-bending the first time I did it
# the labels need to have values to the x and y variables
# in our dataset for ggplot2 to plot them - because
# to ggplot2 these labels are treated just like the data
# points that we're mapping to geom_point!

simd_labels <- 
tribble(
  ~overall, ~crime, ~label,
  2250, 2250, "High overall / High crime",
  2250, 5000, "High overall / Low crime",
  5000, 2250, "Low overall / High crime",
  5000, 5000, "Low overall / Low crime"
)

# now plot this directly
# using geom_label(mapping = aes(label =))

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = 3500
  ) +
  geom_hline(
    yintercept = 3500
  ) +
  geom_text(
    data = simd_labels,
    mapping = aes(label = label)
  )


# Facets ------------------------------------------------------------------

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  facet_wrap(
    facets = vars(simd), 
    ncol = 1
  )


# add another variable; region

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    mapping = aes(colour = council_area)
  ) +
  facet_wrap(
    facets = vars(simd, region)
  )

# NB for facets we use `vars()` not `aes()`

# if we're faceting by two variables
# we can use facet_grid and specify the rows and columns directly
# generally facet_wrap is preferred to facet_grid
# https://ggplot2-book.org/getting-started.html#qplot-facetting



ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    mapping = aes(colour = council_area)
  ) +
  facet_grid(
    rows = vars(simd), 
    cols = vars(region)
  )


# adjusting facet output

# sometimes you want this but beware uneven scales

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    mapping = aes(colour = council_area)
  ) +
  facet_wrap(
    facets = vars(simd, region),
    scales = "free_y"
  )

# DISCUSS:
# why do we have to supply the scales arguments in quotation marks?


# advanced exercises

# look up the facet labeller() function
# add variable labels to your facets
# using an additional data frame of labels
# (see examples here https://ggplot2.tidyverse.org/reference/labeller.html)


# even more advanced reading

# `vars()` is a quoting function like `aes()`
# If you want to understand more about *how* this works, 
# read section IV 'metaprogramming' in Advanced R https://adv-r.hadley.nz/metaprogramming.html
# This probably won't help you use ggplot2 better, but
# it will help you understand how it works its magic, and
# why you have to be very particular with `aes()`



# gg-gotchas --------------------------------------------------------------

# 1. Two joined lines (multiple groups)


ggplot(
  data = simd,
  mapping = aes(x = year, y = overall)
) +
  geom_line()

# why doesn't this work?

# we need to add a grouping variable to make this work
# what grouping variable should we add?

ggplot(
    data = simd,
    mapping = aes(x = year, y = overall, group = council_area)
  ) +
  geom_line()


# 2. Groups == only one observation (categorical x-variable + y-variables)

# we have to fiddle with the data to get this specific error


simd_ed <- 
filter(simd,
       council_area == "City of Edinburgh")

# now we get an error if we try to use SIMD sweep as the x variable

ggplot(
    data = simd_ed,
    mapping = aes(x = simd,
                  y = overall)
  ) +
  geom_line()

# we can remove this by setting the group explicitly again

ggplot(
  data = simd_ed,
  mapping = aes(x = simd,
                y = overall,
                group = council_area)
) +
  geom_line()


# we get the same plot if we group by region instead of council
# area

ggplot(
  data = simd_ed,
  mapping = aes(x = simd,
                y = overall,
                group = region)
) +
  geom_line()

# why is this?
# ... because they're 100% correlated - Edinburgh is always
# in the East region (in our dataset at least)


# 3. Stat count y aesthetic

simd_2020 <- 
  filter(simd,
         year == 2020)

# if we want to plot the median overall SIMD for 2020
# with a bar we get an error

ggplot(
  data = simd_2020,
  mapping = aes(x = council_area,
                y = overall)
) +
  geom_bar()

# we can override this by passing stat = "identity"
# to geom_bar

ggplot(
  data = simd_2020,
  mapping = aes(x = council_area,
                y = overall)
) +
  geom_bar(stat = "identity")



# 4. + on newline

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) 
+ geom_point()


# 5. Call inside/outside `aes()`

# run the following four sets of code and
# discuss the differences in outputs with your group


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
 geom_point(
   aes(colour = region)
 )

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    aes(colour = "region")
  )

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    colour = "region"
  )

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    colour = region
  )

# how about this example?

# why do these two give different results?

# and why does the first example 'work'?

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    aes(size = 2)
  )

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    size = 2
  )

# Session Two -------------------------------------------------------------

# 2020-07-06

# what's in my spatial data frame -----------------------------------------


library(sf)

glimpse(simd_2020_shp)



# maps and coordinates ----------------------------------------------------


st_crs(simd_2020_shp)

# basic plot

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf()


# we can get rid of the solid grey
# note that the NA here isn't inside aes() - like setting
# the fill to be "red"

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    fill = NA
  )

# we can make cholropleth maps by mapping fill to variables

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(colour = overall)
  )


# oh yeah mapping to fill

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  )

# and now with crime domain

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = crime)
  )



# here's the fun bit - we can add layers like any other ggplot
# because we have latitude and longitude in the dataset
# we can map these to x and y and use other geoms like geom_point

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  geom_point(
    mapping = aes(x = long, y = lat, colour = crime)
  )

# note - now we get labelled axes from geom_point

# we can add in size as well

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  geom_point(
    mapping = aes(x = long, y = lat, colour = crime)
  )

# we can apply all the other ggplot2 features as well

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  facet_wrap(
    facets = vars(region)
  )



# bad maps ----------------------------------------------------------------

# ... what?

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  geom_smooth(
    mapping = aes(x = long, y = lat)
  )


# now with lm

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  geom_smooth(
    mapping = aes(x = long, y = lat),
    method = "lm"
  )

# ... what?

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  geom_point(
    mapping = aes(x = long, y = lat)
  ) +
  geom_smooth(
    mapping = aes(x = long, y = lat)
  )

# why stop at long and lat?

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  geom_point(
    mapping = aes(x = crime, y = health)
  )

# the gridlines are gone because... they're graticules (or rather, they're only
# in the sensible range of graticules for Earth)

# it's hard to remember which one is lat and which is long


ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  geom_point(
    mapping = aes(x = lat, y = long)
  )





# setting coordinate limits -----------------------------------------------

# ... mostly

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  facet_wrap(
    facets = vars(region),
    scales = "free"
  )

# what is coord_sf()

# we can set the coordinate system for the plot

# first we can set limits to zoom in to bits of the plot


ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  geom_point(
    mapping = aes(x = long, y = lat)
  ) +
  coord_sf(
    xlim = c(-8, -5),
    ylim = c(55, 58)
  )

# if we're feeling adventurous we can set a new crs

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  ) +
  coord_sf(
    crs = 27700 # this is the ordnance survey CRS for the UK
  )


# because this map is just another ggplot, we can apply these
# to any plot we want but using the other coord_ functions
# IMO there are two main reasons for wanting to do this
# coord_flip() reverses the axes which can help you visualize sometimes


ggplot(
  data = simd,
  mapping = aes(x = region, y = crime)
) +
  geom_point() 

# and we can flip the axes with

ggplot(
  data = simd,
  mapping = aes(x = region, y = crime)
) +
  geom_point() +
  coord_flip()


# second you sometimes want to have a 1:1 mapping in the plot

ggplot(
  data = simd,
  mapping = aes(x = overall, y = access)
) +
  geom_point()



ggplot(
  data = simd,
  mapping = aes(x = overall, y = access)
) +
  geom_point() +
  coord_fixed()



ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  )



# annotations and titles --------------------------------------------------

# adding reference lines

# geom_vline for vertical lines
# geom_hline for horizontal lines
# geom_abline for diagonal lines

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = 3000
  )

# why doesn't this need a call to `aes()`


# 14. ADVANCED why doesn't this work?

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = mean(overall)
  )

# ... and why *does* this work?

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = mean(simd$overall)
  ) +
  geom_hline(
    yintercept = mean(simd$overall)
  ) +
  coord_fixed() +
  geom_abline(
    slope = 1, intercept = 0
  )

# annotations on the plot

labels <- 
  tribble(
    ~overall, ~crime, ~label,
    2000, 2500, "High overall-High crime",
    2000, 5000, "High overall-Low crime",
    5000, 2500, "Low overall-High crime",
    5000, 5000, "Low overall-Low crime"
  )




# 12. adding text!

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_text(
    mapping = aes(label = council_area),
    alpha = 0.3
  )


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = mean(simd$overall)
  ) +
  geom_hline(
    yintercept = mean(simd$overall)
  ) +
  coord_fixed() +
  geom_text(
    data = labels, # we're passing a new dataframe to ggplot
    mapping = aes(label = label)
  )



# adding titles -----------------------------------------------------------


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_text(
    mapping = aes(label = council_area),
    alpha = 0.3
  ) +
  labs(
    title = "Great title",
    subtitle = "Better subtitle",
    caption = "Best caption"
  )



# publication-ready plots -------------------------------------------------

# just stick a call to theme_ at the end

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  theme_minimal()

# how about another one

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  theme_bw()

# and a third

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  theme_dark()

# Or you can make your own theme

# adjusting the legend position

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(aes(colour = access)) +
  theme_dark() +
  theme(
    legend.position = "bottom"
  )

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(aes(colour = access)) +
  theme_dark() +
  theme(
    legend.position = "top"
  )

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(aes(colour = access)) +
  theme_dark() +
  theme(
    legend.position = "top",
    axis.text.x = element_text(angle = 45, hjust = 1)
  )


# to change how the guide looks see https://ggplot2.tidyverse.org/reference/guide_legend.html
