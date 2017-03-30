library(shiny)
library(leaflet)
library(maps)
library(ggplot2)
library(dplyr)
library(htmltools)
library(markdown)

counties <- rgdal::readOGR("Counties.JSON", "OGRGeoJSON")
states <- rgdal::readOGR("States.JSON", "OGRGeoJSON")
county.data <- read.table("data/Joined-County-Data.txt")
counties@data <- county.data

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
        ggplot(aes(LocationAbbr, Data_Value)) + geom_boxplot() + xlab("State Abbreviation") + ylab("Heart Disease Cases (per 100,000 people)") + ggtitle("Male Heart Disease by State")
   
   
                                }
   
                              )
 
 output$FemaleMap <- renderPlot({
   Female %>%
     group_by(LocationAbbr) %>%
         ggplot(aes(LocationAbbr, Data_Value)) + geom_boxplot() + xlab("State Abbreviation") + ylab("Heart Disease Cases (per 100,000 people)") + ggtitle("Female Heart Disease by State")
    
                                })

                                }

#Overall%>%
#group_by(LocationAbbr, Race.Ethnicity)%>%
#summarize(n = n(), ave_value = mean(Data_Value, na.rm = TRUE))
