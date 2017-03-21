library(shiny)
library(leaflet)
library(maps)
library(ggplot2)
library(dplyr)

function(input,output,session) {
  
 output$MyMap <- renderLeaflet({
    leaflet(data = mapStates) %>% 
      addTiles() %>%
        addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)%>%
          addPolygons(data = rgdal::readOGR("Counties.JSON", "OGRGeoJSON"), group = "Counties") %>%
            addLayersControl(
              overlayGroups = c("Counties"), options = layersControlOptions(collapsed = FALSE)
                            )
                               })
     
  
  
                               }


