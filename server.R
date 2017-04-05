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
Male <- read.table("data/Male-Raw-Heart-Disease-Data-Set.txt")
Female <- read.table("data/Female-Raw-Heart-Disease-Data-Set.txt")
Overall <-read.table("data/Overall-Geneder-Raw-Heart-Disease-Data-Set.txt")

function(input,output,session) {
  
 output$MyMap <- renderLeaflet({
    leaflet(data = states) %>% 
      addTiles() %>%
        addPolygons(data = states, group = "States") %>%
          addPolygons(data = counties, group = "Counties") %>%
            addLayersControl(
              overlayGroups = c("Counties", "States"), options = layersControlOptions(collapsed = FALSE)
                            )
                               })
 
 
 output$MaleMap <- renderPlot({
   Male %>%
      filter(LocationAbbr %in% input$StateMale) %>%
        ggplot(aes(LocationAbbr, Data_Value)) + geom_boxplot(color = "blue2") + xlab("State Abbreviation") + ylab("Heart Disease Cases (per 100,000 people)") + ggtitle("Male and Female Heart Disease by State")
                                })
 
 output$FemaleMap <- renderPlot({
   Female %>%
     filter(LocationAbbr %in% input$StateFemale) %>%         
       ggplot(aes(LocationAbbr, Data_Value)) + geom_boxplot(colour = "hotpink2") + xlab("State Abbreviation") + ylab("Heart Disease Cases (per 100,000 people)") + ggtitle("Female Heart Disease by State")
    
                                })
 
 output$RaceMap <- renderPlot({
   Overall%>%
    group_by(LocationAbbr, Race.Ethnicity)%>%
      summarize(n = n(), ave_value = mean(Data_Value, na.rm = TRUE))%>%
        filter(Race.Ethnicity %in% input$Race)%>%
          ggplot(aes(LocationAbbr, ave_value, color = Race.Ethnicity)) + geom_bar(stat = "identity") + xlab("State Abbreviation") + ylab("Heart Disease Cases (per 100,000 people)") + ggtitle("Racial Disparities in Heart Disease by State")
                             })

                                }


