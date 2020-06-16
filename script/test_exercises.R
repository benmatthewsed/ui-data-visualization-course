library(tidyverse)

# In R <- is called the 'assignment operator'
# you can pronounce it 'gets'
# the thing on the right hand side of the <- is assigned to the name
# on the left hand side

simd <- readRDS(file.path("data", "simd_series.rds"))
simd_2020_shp <- readRDS(file.path("data", "simd_2020_shp.rds"))

# 1. basic plot

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point()


# 2. basic plot with different variables

ggplot(
  data = simd,
  mapping = aes(x = access, y = crime)
) + 
  geom_point()

# 3. basic plot with even more different variables

ggplot(
  data = simd,
  mapping = aes(x = overall, y = simd)
) + 
  geom_point()


# 4. basic plot with two layers

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point() + 
  geom_line()


# 5. basic plot with two layers and a layer-specific aesthetic

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) + 
  geom_point() + 
  geom_line(aes(group = council_area))

# 6. basic plot with two layers and a layer-specific aesthetic

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

# what's so stupid about this plot?

# 8. fixed values for geom parameters

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point(colour = "blue")


# 9. fixed values for geom parameters

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




# type ggplot2::geom_ and hit tab
# scroll through the available geoms and try adding them to the plot



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

# maybe better as

# for facets we use `vars()` not `aes()`

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


# advanced exercises

# look up the facet labeller() function
# add variable labels to your facets
# using an additional data frame of labels

# even more advanced reading

# `vars()` is a quoting function
# If you want to understand more about *how* this works, 
# read section IV 'metaprogramming' in Advanced R https://adv-r.hadley.nz/metaprogramming.html
# This probably won't help you use ggplot2 better, but
# it will help you understand how it works its magic, and
# why you have to be very particular with `aes()`


# Smooths, transforms and densitiies --------------------------------------

# one variable (univariate densities)

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


# two variables - geom_smooth

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

# If you want (but do you want...?) to remove the confidence
# intervals you can with the se parameter

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
    mapping = aes(colour = region),
    se = FALSE
  )


# this regression model is calculated inside the ggplot2
# call so you can't (easily) access it
# if you want a complicated smooth, better to fit the model
# outside ggplot2 and then plot the 'smoothed conditional mean'
# based on your own model

# with a less sensible aes()

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_smooth(
    mapping = aes(colour = council_area)
  )


# uh oh

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

# ... maybe not...
# maybe if we add a facet?


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) +
  geom_point() +
  geom_density_2d(
    mapping = aes(colour = region)
  ) +
  facet_wrap(
    facets = vars(region)
  )




# gg-gotchas --------------------------------------------------------------

# 1. Two joined lines (multiple groups)
#
simd %>% 
  mutate(year = as.numeric(str_sub(simd, 6, 9))) %>% 
ggplot(
  mapping = aes(x = year, y = overall)
) +
  geom_line()

# why doesn't this work?

# how can we fix it?


# 2. Groups == only one observation (categorical x-variable + y-variables)

simd %>% 
  mutate(year = as.numeric(str_sub(simd, 6, 9))) %>% 
  ggplot(
    mapping = aes(x = simd, y = factor(overall))
  ) +
  geom_line()


# 3. Stat count y aesthetic
# 


# 4. + on newline

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime)
) 
+ geom_point()

# 
# 5. Call inside/outside `aes()`
# 
# 6. Geom density with small n
# 

edi <- filter(simd, council_area == "City of Edinburgh")

ggplot(
  data = edi,
  mapping = aes(x = overall)
) +
 geom_density()

# 7. Variable types - colour scales and continuous, factor variables

ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime, colour = year)
) +
  geom_point()


ggplot(
  data = simd,
  mapping = aes(x = overall, y = crime, colour = factor(year))
) +
  geom_point()



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
