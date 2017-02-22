#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)
library(htmltools)

graf <- readRDS("SF_Graffiti.Rds")

# initial values for these before the app can populate the UI
minTime <- min(graf$Opened)
maxTime <- max(graf$Opened)

filter_points_from_ui <- function(data, minTime, maxTime, showOffensive) {
  dt.by_date <- filter(data, Opened >= minTime & Opened <= maxTime) %>%
    mutate(Status = ifelse((Closed > maxTime | is.na(Closed)), "Open", "Closed")) %>%
    filter(Status=="Open")
  
  if(!showOffensive){
    dt.by_date <- dt.by_date %>%
      filter((grepl("Not_Offensive", Request.Type) | grepl("Not Offensive", Request.Type)))
  }
  
  return (dt.by_date)
}

shinyServer(function(input, output, session) {
  
  output$map <- renderLeaflet({
    # This only includes the map features which can't be
    # dynamically altered by the UI
    leaflet() %>%
      setView(lng = -122.4237, lat = 37.7734, zoom = 12) %>%
      addTiles()
  })
  
  showOffensive <- reactive({
    input$toggleOffensive
  })
  
  filteredData <- reactive({
    if ( !is.null(input$range[1]) & !is.null(input$range[2]) ) {
      minTime <- input$range[1]
      maxTime <- input$range[2]
    }
    offensiveCond <- showOffensive()
    graf_points <- filter_points_from_ui(graf, as.POSIXct(minTime), 
                                         as.POSIXct(maxTime), offensiveCond)
    graf_points
  })
  
  # Observers change map features which are dynamically
  # altered by the UI

  observe({
    graf_points <- filteredData()
    
    # This if-else is because of a bug in leaflet, where if the data frame "graf_points" is empty,
    # there will be a crash when we try to addCircleMarkers, and every other attempt to clearMarkers
    # will fail. Awkward.
    if (nrow(graf_points)==0) {
      leafletProxy("map") %>%
        clearMarkers
    } else {
    leafletProxy("map", data=graf_points) %>%
      clearMarkers %>%
      addCircleMarkers(lng = ~graf_points$Long,
                       lat = ~graf_points$Lat,
                       radius = 6,
                       color = "blue",
                       popup = ~htmlEscape(graf_points$Location),
                       stroke = FALSE,
                       fillOpacity = 0.5)
    }
  })
})
