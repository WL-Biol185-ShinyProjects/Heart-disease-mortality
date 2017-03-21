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
        addPolygons(data = states, group = "States") %>%
          addPolygons(data = counties, group = "Counties") %>%
            addLayersControl(
              overlayGroups = c("Counties", "States"), options = layersControlOptions(collapsed = FALSE)
                            )
                               })
 
 
 output$MaleMap <- renderPlot({
   Male %>%
    group_by(LocationAbbr) %>%
      summarize(ave_value = mean(Data_Value, na.rm = TRUE)) %>%
        ggplot(aes(LocationAbbr, ave_value)) + geom_boxplot()
   
                                })
 

 output$FemaleMap <- renderPlot({
   Female %>%
     group_by(LocationAbbr) %>%
       summarize(ave_value = mean(Data_Value, na.rm = TRUE)) %>%
         ggplot(aes(LocationAbbr, ave_value)) + geom_boxplot()
    
                                })
     
  
                                }


