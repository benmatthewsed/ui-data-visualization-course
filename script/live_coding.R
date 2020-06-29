# UI data visualization with ggplot2

# Ben Matthews and Eilidh Jack

# 2020-06-29



# First live coding: ------------------------------------------------------


## Introduce Rstudio environment

## Draw a plot with SIMD data - overall vs access

## Add another layer to the plot - geom_line

## Change line colour to red




# Principles of ggplot2 ---------------------------------------------------



## mtcars, geom_point, x = disp, y = drat

### disp is displacement (engine size?), drat is rear axle ratio
### (high drat = 'better pull, worse fuel economy and speed)


## as above, geom_line


## add colour mapping cyl to point

## error - colour = red inside aes

## colour - "red" ouside aes



# Three types of geom -----------------------------------------------------



## geom_density, x = disp

## geom_smooth, x = disp, y = drat

## as above with point layer before smooth

## and then with geom_density_2d over smooth layer

## reference vline at x = 200

## geom_text aes(label = drat)

## with a label from a separate dataframe

label_df <- 
  data.frame(
    x = 300,
    y = 4,
    text = "A great label"
  )



# Facets ------------------------------------------------------------------



## x = disp, y = drat, colour = cyl, facets = vars(cyl)

## as above with vars(am, cyl)

## as above with scales = "free_y"



# Dual coding -------------------------------------------------------------



## x = disp, y = drat, point with aes(colour = am)

## add aes(shape = factor(am))
