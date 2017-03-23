library(markdown)
library(leaflet)

counties <- rgdal::readOGR("Counties.JSON", "OGRGeoJSON")
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

