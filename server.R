library(shiny)
library(leaflet)
library(maps)
library(ggplot2)
library(dplyr)
library(htmltools)
library(markdown)
library(shinythemes)

counties <- rgdal::readOGR("Counties.JSON", "OGRGeoJSON")
states <- rgdal::readOGR("States.JSON", "OGRGeoJSON")
county.data <- read.table("data/Joined-County-Data.txt")
counties@data <- county.data
pal <- colorNumeric(
       palette = "YlOrRd",
       domain = counties@data$Data_Value)
labels <- sprintf(
                  "<strong>%s</strong><br/>%g people / 100,000 people",
                  counties@data$fullName, 
                  counties@data$Data_Value
                  ) %>% 
          lapply(htmltools::HTML)
state.data <- read.table("data/Joined-State-Data.txt")
states@data <- state.data
pal1 <- colorNumeric(
        palette = "YlOrRd",
        domain = states@data$Data_Value)
labels1 <- sprintf(
                  "<strong>%s</strong><br/>%g people / 100,000 people",
                  states@data$NAME, 
                  states@data$Data_Value
                  ) %>% 
          lapply(htmltools::HTML)
Male <- read.table("data/Male-Raw-Heart-Disease-Data-Set.txt")
Female <- read.table("data/Female-Raw-Heart-Disease-Data-Set.txt")
Overall <-read.table("data/Overall-Geneder-Raw-Heart-Disease-Data-Set.txt")

  
function(input,output,session) {
 
 output$MyMap <- renderLeaflet({
    if(input$MapType == "Counties") 
          {leaflet(data = counties) %>%
             addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
             addPolygons(fillColor = ~pal(Data_Value), 
                         fillOpacity = 0.8, 
                         color = "#BDBDC3", 
                         weight = 1,
                         highlight = highlightOptions(
                                     weight = 5,
                                     color = "#666",
                                     dashArray = "",
                                     fillOpacity = 0.7,
                                     bringToFront = TRUE),
                         label = labels,
                         labelOptions = labelOptions(
                                        style = list("font-weight" = "normal", 
                                                     padding = "3px 8px"),
                                        textsize = "15px",
                                        direction = "auto")) %>%
            addLegend(pal = pal, 
                      values = ~Data_Value, 
                      opacity = 0.7, 
                      title = NULL,
                      position = "bottomright") %>%
            setView(lat = 38.0110306, lng = -110.4080342, zoom = 3)
        }
    else{leaflet(data = states) %>%
             addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
             addPolygons(fillColor = ~pal1(Data_Value), 
                         fillOpacity = 0.8, 
                         color = "#BDBDC3", 
                         weight = 1,
                         highlight = highlightOptions(
                                     weight = 5,
                                     color = "#666",
                                     dashArray = "",
                                     fillOpacity = 0.7,
                                     bringToFront = TRUE),
                         label = labels1,
                         labelOptions = labelOptions(
                                        style = list("font-weight" = "normal", 
                                                     padding = "3px 8px"),
                                        textsize = "15px",
                                        direction = "auto")) %>%
               addLegend(pal = pal1, 
                         values = ~Data_Value, 
                         opacity = 0.7, 
                         title = NULL,
                         position = "bottomright") %>%
            setView(lat = 38.0110306, lng = -110.4080342, zoom = 3)
        }        
                               })
 
 
 output$MaleMap <- renderPlot({
   Male %>%
      filter(LocationAbbr %in% input$StateMale) %>%
        ggplot(aes(LocationAbbr, Data_Value, color = Gender)) + geom_boxplot() + xlab("State Abbreviation") + ylab("Heart Disease Cases (per 100,000 people)") + ggtitle("Male and Female Heart Disease by State")
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
          ggplot(aes(LocationAbbr, ave_value, fill = Race.Ethnicity)) + geom_bar(stat = "identity", position = "dodge") + xlab("State Abbreviation") + ylab("Heart Disease Cases (per 100,000 people)") + ggtitle("Racial Disparities in Heart Disease by State")
                             })

                                }


