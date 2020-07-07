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

# SIMD are *ranks*, so closer to 1 = higher rank = more deprived


# getting started ---------------------------------------------------------



# 1. our first plot

# run the code below

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point()


# 2.  plot with different variables

# run this line to see what variables are in the simd dataset

glimpse(simd)

# it has variables:
#  "council_area", "simd", "overall", "health", "employment"  
# "income", "education", "access", "crime", "region", "year"

# now plot access on the x axis and keep crime on the y axis

ggplot(
  data = simd,
  mapping = aes(x = , y = crime)
) + 
  geom_point()

# 3. plot with even more different variables

# now swap overall SIMD back in on the x axis and
# plot simd on the y axis (this variable shows the version of SIMD)

ggplot(
  data = simd,
  mapping = aes(x = , y = )
) + 
  geom_point()


# 4. plot with two layers

# going back to overall SIMD on the x axis and crime on the y axis
# add a call to geom_line() after geom_point to add an extra layer to the plot

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point() +


# 5. plot with two layers and a layer-specific aesthetic

# we can add aesthetics into specific layers
# add mapping = aes(group = council_area) into
# the call to geom_line to draw a line for each council_area
  
ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point() + 
  geom_line(
    
    )

# 6. plot with two layers and a layer-specific aesthetic
# change the mapping for geom_line to the colour aesthetic
# not the group aesthetic


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point() + 
  geom_line(
    
  )


# 7. moving the layer-specific aesthetic to global mapping

# moving aesthetic mappings from the call to the geom_layer
# to the global mapping can change how the plot looks,
# beacuse this way ALL layers inherit this mapping

# rearrange the code below into a valid ggplot call (look 
# at the ordering!) which specifies
# overall SIMD as the x variable, crime as the y variable
# and council_area as a mapping to colour in the call
# to ggplot

geom_point() + 
ggplot(
  data = simd,
  mapping = aes(
    
    )
) + 
  geom_line()
  x = overall, y = crime, colour = council_area

# 6. DO NOT DO THIS

# ggplot2 will let you do things that maybe aren't so helpful!
# run the code below and discuss in your group why it's a bad idea
  
ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point(aes(x = access, y = health)) + 
  geom_line(aes(group = council_area))

# QUESTION: what's so stupid about this plot?




# 8. fixed values for geom parameters

# set the colour for the points in the plot below
# to be "blue" (note the quotation marks) - NB you
# don't need a call to aes 

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(colour = )


# 9. fixed values for geom parameters; size

# change the mapping for size for geom_point to 2
# (note you don't need quote marks this time!)

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point()

# 10. fixed values for geom parameters

# now set both size = 2 and colour = "blue" for geom_point

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point()


# 9. fixed values in call to aes()

# ADVANCED: run the code below and discuss in your group why this
# doesn't throw an error

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(aes(colour = "blue", size = 2))



# 11. The neatest parameters: alpha

# my (Ben's) personal favourite parameter is alpha
# which affects transparency

# set alpha = 0.3 in the call to geom_point - do you need
# to pass this to aes or not?

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point()


# to see more available options
# go to https://ggplot2.tidyverse.org/reference/
# type ggplot2::geom_ and hit tab
# scroll through the available geoms and try adding them to the plot



# Types of geom -----------------------------------------------------------



# Plot every row ----------------------------------------------------------

# we saw these already!

# specify mapping x is overall simd and y is crime with simd as
# the data in the call to ggplot2

ggplot(

) +
  geom_point()


# how about text instead of points?

# repeat the call but with geom_text instead of geom_point


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_()


# Plot a summary of data --------------------------------------------------




# one variable 

# note that we're only supplying an x variable here not a y variable!
# ggplot2 calculates the y variables for us

# create a histogram of overall simd as an x variable


ggplot(
  data = simd,
  mapping = aes(x = )
) +
  geom_histogram()

# now complete the below to map x = crime

ggplot(
  data = simd,
) +
  geom_histogram()


# try changing the bins argument to bins = 10 with x = overall
# notice how this changes the plot


ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_histogram(
    bins = 
  )

# ... and again, to bins = 100


ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_histogram(
    bins = 
  )

# how about a different geom?

# swap out geom_histogram for geom_density


ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_()


# this is a bit plain - set the fill aesthetic for
# geom_density to "blue" - does this need to be inside a
# call to aes or not?

ggplot(
  data = simd,
  mapping = aes(x = overall)
) +
  geom_(
    
  )

# discuss in your group - why did we change fill here and not colour?
# try again setting colour = "blue" and see how
# the plot changes


# advanced- why can't you plot geom_density and geom_histogram
# together?
# NB look at the y-axis

# read this answer - https://stackoverflow.com/questions/37404002/geom-density-to-match-geom-histogram-binwitdh
# and run the code below

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
# It draws a 
# "Smoothed conditional mean" - i.e. regression line

# run the code below

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_smooth()

# okay, but what about the points?
# we can just add geom_point as another layer!
# and they will both inherit x and y from the call to 
# `aes()`
# add a call to geom_point() after the call to geom_smooth


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_smooth()

# changing the method

# we got a message that
# `geom_smooth()` using method = 'loess' and formula 'y ~ x'

# using the method argument we can change this
# to a bunch of other regression lines!

# linear regression - straight line
# add the call method = "lm" to geom_smooth (no need to call aes), 
# and rearrange the below into valid ggplot2 code

geom_point() + 
ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_smooth(
    
  )

# we can also fit 
# a different type of wiggly line: Generalized Additive Model
# draw a plot with overall SIMD as the x axis, crime as the y axis
# with layers for geom_point and geom_smooth. In the call
# to geom_smooth set method = "gam" not method = "lm"




# ADVANCED: look at the different smooth options
# at https://ggplot2.tidyverse.org/reference/geom_smooth.html
# try out a few different ones!





# other settings

# to me this is basically magic already, but because the smooth
# is just another geom you can add aesthetic value just as we
# did before

# try adding colour = region to geom_smooth (remember aes)

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
 
  )

# something weird going on there in the East?
# Take a minute to discuss these lines with your
# group - what's this figure telling us?


# now add geom_smooth with colour = simd


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(

  )



# If you want to remove the confidence
# intervals you can with the se parameter

# run the code below and then discuss in your group whether
# this is a good idea in this case?

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
# add to the call below so that the main call to ggplot
# has x mapped to overall simd, y to crime and
# geom_smooth has colour mapped to council_area

ggplot(
  data = simd,
  
) +
  geom_point() +
  geom_smooth(
    
  )


# uh oh

# why is this less sensible than mapping to region?


# advanced
# geoms that try to calculate a summary of the data won't work well
# if you give them single data point

# run the code below

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
    mapping = aes(colour = interaction(council_area, simd))
  )

# why aren't there any lines on the plot?


# one continuous one discrete variable -----------------------------------





# set region as the x variable and overall as the y variable
# and add geom_boxplot

ggplot(
  data = simd,
  mapping = aes(x = , y = )
) +
  geom_()




# other two-continuous variable summaries --------------------------------------------

# rearrange the below to make a call to ggplot to produce the scatter plot we had
# before using data = simd and mapping x as overall simd and y as
# crime simd. then add calls to geom_point and 
# geom_density_2d

  data = simd,
  geom_point() +
ggplot(
  
) +
  mapping = aes(x = overall, y = crime)
  geom_density_2d()

  
# again we can add more aesthetics - 
# copy and paste your call above 
# add mapping = aes(colour = region) to the call to geom_density_2d
  


# ... maybe not! This is perhaps too much information...


# Plot something else altogether -----------------------------------------------

# we can add a reference line to the previous plot
# make the scatter plot we had before using
# x as overall SIMD and y as crime
# and set the xintercept to be 3500
  
ggplot(
  data = simd,
  
) +
  geom_point() +
  geom_vline(
    xintercept = 
  )

# and now a horizontal line at y = 3500

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_vline(
    xintercept = 3500
  ) +
  geom_hline(
    yintercept = 
  )

# how about a diagonal line using the parameters
# slope = 1 and intercept = 0 to geom_abline



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
  

# adding text
  
# To add a variable from our dataframe as text we can
# just pass this to the aes(label = ) setting in geom_text
# set the label value to be overall simd in the call below
  
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
    aes(label = )
  )

# this is a lot of information though...

# now change the label to council_area

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
    aes(label = )
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

# rearrange the below into a valid call
# to add the labels from the simd_labels
# dataframe to our plot

  geom_hline(
    yintercept = 3500
  ) +
  geom_point() +
ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_vline(
    xintercept = 3500
  ) +
  geom_text(
    data = simd_labels,
    mapping = aes(label = label)
  )


# Facets ------------------------------------------------------------------

# adjust the call below to facet our plot by simd
# NB for facets we use `vars()` not `aes()`  

  
ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  facet_wrap(
    facets = vars( )
  )


# now adjust the call to add another variable; region

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  facet_wrap(
    facets = vars( , )
  )



# if we're faceting by two variables
# we can use facet_grid and specify the rows and columns directly
# although generally facet_wrap is preferred to facet_grid
# https://ggplot2-book.org/getting-started.html#qplot-facetting

# set the rows in facet grid equal to simd and the columns to region
# adding calls to vars() as needed

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    mapping = aes(colour = council_area)
  ) +
  facet_grid(
    rows = vars( ), 
    cols = 
  )


# adjusting facet output

# pass the argument scales = "free_y" to facet_wrap

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
       = 
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

# Run the code below - why doesn't this work?

ggplot(
  data = simd,
  mapping = aes(x = year, y = overall)
) +
  geom_line()



# we need to add a grouping variable to make this work
# add group = council_area to the mapping


ggplot(
    data = simd,
    mapping = aes(x = year, y = overall,  = )
  ) +
  geom_line()


# 2. Groups == only one observation (categorical x-variable + y-variables)

# we have to fiddle with the data to get this specific error,
# so we'll make a new dataframe


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
# add group = council_area to the plot mapping

ggplot(
  data = simd_ed,
  mapping = aes(x = simd,
                y = overall,
                 = )
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


# 3. Stat count y aesthetic

# again we need a new dataset to create this error

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
# to geom_bar. add this to the code below

ggplot(
  data = simd_2020,
  mapping = aes(x = council_area,
                y = overall)
) +
  geom_bar()



# 4. + on newline

# ADVANCED:

# first, click on line 906 and press ctrl + enter
# to run the code. You should get a plot with no points.

# now highlight lines 906-910 and press ctrl + enter

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) 
+ geom_point()

# now you should also get an error message

# Discuss in your group: why does this happen?


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

# discuss in your groups: why do these plots give
# different results?

# can you explain why setting aes(colour = "region")
# draws a plot?

# run the code for thw two plots below
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




# colour palettes ---------------------------------------------------------

# we've seen ggplot2's default colour scales already

# rearrange the code below to draw a plot with a discrete colour scale
# where the call to map colour to region is within the call
# to geom_point

mapping = aes(colour = region)
data = simd,
ggplot() +
  mapping = aes(x = overall, y = crime)
  geom_point()

# In general I use viridis palettes

# here region is discrete so I need scale_colour_viridis_d
# add a call to cale_colour_viridis_d() to your rearranged plot
# above




# how about a continuous measure? in the below map
# colour to year and add a call to scale_colour_viridis_c()

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    mapping = aes()
  ) +

# Now try one of the other viridis palettes by setting
# option = "plasma" in the call to scale_colour_viridis_c()
  
  
# what happens if you use *_viridis_c with a discrete measure?
# change the code for your plot above to map colour to simd
# and keep the call to scale_colour_viridis_c()


# add make the colour of simd in the below greyscale with
# a call to scale_colour_grey

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    mapping = aes(colour = simd)
  )

# ADVANCED
# reproduce the plot with x = overall and y = crime
# and colour = region
# create a custom colour scale for the plot using
# scale_colour_manual

# If you're not familiar with the c() function
# take a look here - https://stackoverflow.com/a/11488864/10791377


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    mapping = aes(colour = region)
  ) +
  scale_colour_manual(values = c())

# ADVANCED
# make your own greyscale continous plot using scale_colour_gradient
# mapping colour to access

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(
    mapping = aes()
  ) +
  scale_colour_gradient(
  )

# one of the tricky things is knowing whether a geom wants
# colour or fill (or both) - we saw this with one of our maps

# we can remove the borders on the map by adding colour = overall
# add this to the plot below

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall)
  )

# now change the colour mapping to viridis

ggplot(
  data = simd_2020_shp,
  mapping = aes(geometry = geometry)
) +
  geom_sf(
    mapping = aes(fill = overall,
                  colour = overall)
  )


# oh no! we also need to change fill to viridis
# rearrange the below and then 
# add scale_colour_viridis_c and scale_fill_viridis_c to the below

mapping = aes(geometry = geometry)
ggplot() +
  data = simd_2020_shp,
  geom_sf(
    mapping = aes(fill = overall,
                  colour = overall)
  )


# annotations and titles --------------------------------------------------


# why doesn't this need a call to `aes()`


# 14. ADVANCED why doesn't this work?


# we saw reference lines previously
# add a vertical intercept to the plot below with an
# x intercept of 3000


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point()


# ADVANCED

# why doesn't this work?

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


# adding titles -----------------------------------------------------------

# using the labs() function and the  a title, subtitle and caption
# options add the following extra information to the plot below:
# title = "Great title"
# subtitle = "Better subtitle"
# caption = "Best caption"

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_text(
    mapping = aes(label = council_area),
    alpha = 0.3
  )

# Now change the labels for the x axis to read "Median Overall SIMD Rank"
# and for the y axis to read "Median Crime SIMD Rank"



# themes -----------------------------------------------------------------


# rearrange the code below to a valid ggplot call
# and then add a call to theme_minimal() to change the theme

aes(x = overall, y = crime)
simd,
data = 
  ggplot(
    mapping = 
      geom_point() +
  ) +
  
  
  # how about another one: change the theme for the plot above
  # to theme_bw()
  
  
  
  # and a third: now change the theme call to theme_dark()
  
  # adjusting the legend position
  # write a call to produce a scatterplot mapping
# x to overall SIMD, y to crime SIMD and colour to access SIMD
# change the theme to theme_dark
# adjust the call below to set the legend position to "bottom"


theme(
  legend.position = 
)

# on second thoughts, maybe the legend is better at the top :-)
# adjust the call so the legend is at the top of the plot

# adjust the below to produce a valid ggplot2 call mapping
# x to overall SIMD, y to crime SIMD and colour to access SIMD,
# with a dark them, the legend at t he top of the plot and
# and the x axis rotated to a 45 degree angle

ggplot(
  data = ,
  mapping = aes(x = overall, y = )
) +
  geom_point(aes(colour = access)) +
  theme_dark() +
  theme(
    legend.position = " ",
    axis.text.x = element_text(angle = , hjust = 1)
  )


# scales ------------------------------------------------------------------

# write code to produce a plot with overall SIMD mapped to x,
# y mapped to crime and colour mapped to access
# then add a call to scale_y_log10() to transform the y
# axis to a log scale


# change the format of the y axes to have commas
# separating thousands by adding the line below
# to scale_y_log10()

    labels = scales::label_comma()
  
# hmmm okay it doesn't actually look that different

# now change the labels breaks for the y axis by
# also adding the call below to scale_y_log10

    breaks = c(2000, 3000, 4000, 5000, 6000)



# saving your plots -------------------------------------------------------

# save your ggplot above by assigning it to the plot_to_save using
# the <- assignment operator


plot_to_save <- 


# save the plot using ggsave()
# where you save it will depend on the structure of your working
# directory. If you're not familiar with the term 'working directory'
# read this chapter for R4DS 
# https://r4ds.had.co.nz/workflow-projects.html#where-does-your-analysis-live

# use file.path() in the below to save your plot as a png file
# for extra points, 
# add extra arguments as necessary to save your plot
# in a sub-directory called "figures" (you might
# have to create this yourself)
# For how to create a sub-directory in R
# see here - http://theautomatic.net/2018/07/11/manipulate-files-r/
# ... or for tidyverse file manipulation see here - https://fs.r-lib.org/



ggsave(
  filename = file.path(" .png"),
  plot = plot_to_save
)

# save the same plot but with a new filename and set
# type = "cairo-png"
# does this look different? (The answer may be no!)


ggsave(
  filename = file.path(" .png"),
  plot = plot_to_save,
  type = 
)


# can't we make the plot bigger?
# by default height and width are the output size in inches
# set the output height to be 8 inches and width to be 6 inches
# again, save this plot with a different name


ggsave(
 
  plot = ,
  type = "cairo-png",
  height = , 
  width = 
)




# bad plot challenge -----------------------------------------------------------

# If you've made it to the end of the exercises, well done!
# You can use the rest of the time to visualize your own dataset

# OR you can take part in our 'bad plot challenge'*:

# Using the SIMD dataset we've been working on, and using the skills
# we've covered in the course, make the *worst* data visualization you can.
# Think about: inappropriate geoms, hard-to-make comparisons, confusing
# colour scales, perplexing scale transformations,
# ugly themes, misleading labelling and uninformative titles.
# Dig into the ggplot reference manual for extra settings to make your
# plots even worse data visualizations

# * I stole this idea from someone on the internet, but I forget who :S
