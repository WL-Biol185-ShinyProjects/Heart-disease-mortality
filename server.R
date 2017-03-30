library(shiny)
library(leaflet)
library(maps)
library(ggplot2)
library(dplyr)
library(htmltools)
library(markdown)

counties <- rgdal::readOGR("Counties.JSON", "OGRGeoJSON")
  placeTypes <- as.character(counties@data$LSAD)
  placeTypes[placeTypes == "CA"] <- ""
  placeTypes[placeTypes == "Borough"] <- ""
  placeTypes[placeTypes == "Cty&Bor"] <- ""
  placeTypes[placeTypes == "Muny"] <- ""
  placeTypes[placeTypes == "city"] <- "City"
  placeTypes[placeTypes == "Muno"] <- "Municipio"
  counties@data$placeType <- placeTypes
  counties@data$fullName <- paste(counties@data$NAME, counties@data$placeType)
  counties@data$fullName <- gsub(" $", "", counties@data$fullName)
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
