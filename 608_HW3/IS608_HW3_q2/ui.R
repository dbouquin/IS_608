# UI

# HW3
# 2. Often you are asked whether particular States are improving their mortality rates (per cause) faster than,
# or slower than, the national average. Create a visualization that lets your clients see this for themselves 
# for one cause of death at the time. Keep in mind that the national average should be weighted by the national population.

library('shiny')
library('ggplot2')
library('googleVis')

download.file("https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv", "cleaned-cdc-mortality-1999-2010.csv", method="curl")
m <- read.csv("cleaned-cdc-mortality-1999-2010.csv", na.strings = "NA")

c <- as.character(unique(m$ICD.Chapter))

# use shiny to create a basic page layout.  Sidebar that isolates our main conceptual filter (cause of death) 
# and a main panel for our visualizations.

shinyUI(pageWithSidebar(headerPanel('Mortality in the US (crude rate) by Cause Over Time'),
                        sidebarPanel(selectInput("c", "Select a cause of death: ", c, selected='Neoplasms')),
                        mainPanel(
                          htmlOutput('diff_time')
                          )
                        )
)