# Server
# HW3
# 1. As a researcher, you frequently compare mortality rates from particular causes across 
# different States. You need a visualization that will let you see (for 2010 only) the crude 
# mortality rate, across all States, from one cause. For example, Neoplasms, which are effectively
# cancers. Create a visualization that allows you to rank States by crude mortality for each cause
# of death.
#

library('shiny')
library('plyr')
library('ggplot2')

# load data
download.file("https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv", "cleaned-cdc-mortality-1999-2010.csv", method="curl")
m <- read.csv("cleaned-cdc-mortality-1999-2010.csv", na.strings = "NA")

shinyServer(function(input, output){
  
  q1 <- function(){
    # 2010 only
    c <- input$c
    f <- m[m$Year == 2010 & m$ICD.Chapter==c, 
                     c('State','Crude.Rate')
                     ]
    # sort
    f <- f[with(f, order(-Crude.Rate)),] 
    # make the bar chart
    bar <- gvisBarChart(f,
                     "State","Crude.Rate",
                     options=list(width = 500,height=1000,fontSize=13,legend="none")) # kept getting errors trying to change color :/
}
  
  output$sorted_crude <- renderGvis(q1())
  })