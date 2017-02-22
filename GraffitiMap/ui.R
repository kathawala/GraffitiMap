#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

dates <- readRDS("dates.Rds")

# Define UI for application that draws a histogram
shinyUI(bootstrapPage(
  
  # Application title
  tags$style(type = "text/css", 'html, body {width:100%;height:100%}
                                .mainPanel {padding: 10px 30px 10px 30px; width: 350px; line-height: 1}
                                #dates {float: right; clear: right}
                                #checkbox {float: right; clear: right}
                                .right {text-align: right'),
  
  leafletOutput("map", width = "100%", height = "100%"),
  
  absolutePanel(top = 10, right = 10, class="panel mainPanel",
                helpText("See reported cases of graffiti in San Francisco in the time period you specify", class="panel-header right"),
                
                tags$div(id="dates", class="right",
                          dateRangeInput("range", "Date Range",
                                        start=dates$start,
                                        end=dates$max,
                                        min=dates$min,
                                        max=dates$max,
                                        format="mm/dd/yy",
                                        separator=" - ")
                ),
                
                tags$div(id="checkbox", class="right",
                  checkboxInput("toggleOffensive", "Show Offenisve Graffiti", FALSE)
                )
  ),
  title="GraffitiMap"
))
