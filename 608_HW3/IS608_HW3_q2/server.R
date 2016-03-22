# Server

# HW3
# 2. Often you are asked whether particular States are improving their mortality rates (per cause) faster than,
# or slower than, the national average. Create a visualization that lets your clients see this for themselves 
# for one cause of death at the time. Keep in mind that the national average should be weighted by the national population.

# Create a motion chart - examples from:
# https://developers.google.com/chart/interactive/docs/gallery/motionchart
# https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html

library('shiny')
library('ggplot2')
library('googleVis')
library('plyr')

# load data
download.file("https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv", "cleaned-cdc-mortality-1999-2010.csv", method="curl")
m <- read.csv("cleaned-cdc-mortality-1999-2010.csv", na.strings = "NA")

shinyServer(function(input, output){
  
  # plot over time
  diff_time <- function(){

    c <- input$c
    f <- m[m$ICD.Chapter==c, 
                     c('State','Crude.Rate', 'Year','Population', 'Deaths')
                     ]
    
    # Calculate the weighted average for each year 
    f$mean <- daply(f,.(Year),function(x) weighted.mean(x$Crude.Rate, x$Population))
    f$Difference <- f$Crude.Rate - f$mean
    
    # Get settings from wrench icon as seen here: 
    # https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html
    # The exact paste to string didn't work -- was unable to set some functions as defaults
    settings <-'
    {"showChartButtons":true,
    "showTrails":true,
    "xAxisOption":"_NOTHING",
    "iconKeySettings":[{"key":{"dim0":"New York"}},{"key":{"dim0":"California"}},{"key":{"dim0":"Massachusetts"}}],
    "xLambda":1,
    "yLambda":1,
    "playDuration":900,
    "time":"2005",
    "yZoomedDataMax":80,
    "yZoomedDataMin":-100,
    "sizeOption":"_UNISIZE",
    "xZoomedDataMax":60,
    "xZoomedDataMin":0,
    "colorOption":"4",
    "yAxisOption":"6",
    "dimensions":{"iconDimensions":["dim0"]},
    "nonSelectedAlpha":0.4,
    "iconType":"VBAR",
    "duration":{"timeUnit":"Y","multiplier":1},
    "uniColorForNonSelected":true}'
    
    gvisMotionChart(f, 
                    idvar='State', 
                    timevar='Year',
                    xvar='Deaths', 
                    yvar='Difference',
                    sizevar='Population',
                    options= list(chartArea='{width:800,height:600}', 
                                  state=settings)
    )
    
  }
  
  output$diff_time <- renderGvis(diff_time())
  })

### Unresolved problems with plot :( :( :(
# error: replacement has 12 rows, data has 217 -- pregnancy etc.  
# error: replacement has 7 rows, data has 8 -- diseases of ear etc.
