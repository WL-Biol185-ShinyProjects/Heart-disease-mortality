library(shiny)
library(leaflet)
library(maps)
library(ggplot2)
library(dplyr)

counties <- rgdal::readOGR("Counties.JSON", "OGRGeoJSON")
states <- rgdal::readOGR("States.JSON", "OGRGeoJSON")

function(input,output,session) {
  
 output$MyMap <- renderLeaflet({
    leaflet(data = mapStates) %>% 
      addTiles() %>%
        addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)%>%
          addPolygons(data = counties, group = "Counties") %>%
            addLayersControl(
              overlayGroups = c("Counties"), options = layersControlOptions(collapsed = FALSE)
                            )
                               })
 output$MaleMap <- renderPlot({
   Male %>%
    group_by(LocationAbbr) %>%
      summarize(ave_value = mean(Data_Value, na.rm = TRUE)) %>%
        ggplot(aes(LocationAbbr, ave_value)) + geom_boxplot()
   
                                })
     
  
                                }


