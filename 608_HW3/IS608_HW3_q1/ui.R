# UI

# HW3
# 1. As a researcher, you frequently compare mortality rates from particular causes across 
# different States. You need a visualization that will let you see (for 2010 only) the crude 
# mortality rate, across all States, from one cause. For example, Neoplasms, which are effectively
# cancers. Create a visualization that allows you to rank States by crude mortality for each cause
# of death.
#

library('shiny')
library('ggplot2')
library('googleVis')

download.file("https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv", "cleaned-cdc-mortality-1999-2010.csv", method="curl")
m <- read.csv("cleaned-cdc-mortality-1999-2010.csv", na.strings = "NA")

c <- as.character(unique(m$ICD.Chapter))

# Shiny main panel for vis

shinyUI(pageWithSidebar(headerPanel('2010 Mortality in the US (crude rate) by Cause'),
                        sidebarPanel(selectInput("c", "Select a cause of death: ", c, selected='Neoplasms')), 
                        mainPanel(
                          htmlOutput('sorted_crude')
                          )
                        )
)