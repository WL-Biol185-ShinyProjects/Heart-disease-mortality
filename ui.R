library(markdown)
library(leaflet)

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
states <- rgdal::readOGR("States.JSON", "OGRGeoJSON")

fluidPage(

titlePanel("US Heart Disease Mortality"),

navbarPage("",
  
          tabPanel("Map",
                    verbatimTextOutput("map"),
             leafletOutput("MyMap"),
             p()
           
                  ),
           
          tabPanel("Gender",
                    verbatimTextOutput("gender"),
            plotOutput("MaleMap"),
            p(),
            plotOutput("FemaleMap"),
            p()
                  ),
           
          tabPanel("Race/Ethnicity",
                   verbatimTextOutput("race/ethnicity")
                  )

           )
           )

