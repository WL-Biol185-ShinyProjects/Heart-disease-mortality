library(markdown)
library(leaflet)

fluidPage(

titlePanel("US Heart Disease Mortality"),

navbarPage("",
  
          tabPanel("Map",
                    verbatimTextOutput("map"),
             leafletOutput("MyMap"),
             p()
           
           ),
           tabPanel("Gender",
                    verbatimTextOutput("gender")
           ),
           tabPanel("Race/Ethnicity",
                    verbatimTextOutput("race/ethnicity")
           )
           
           
           )

)

