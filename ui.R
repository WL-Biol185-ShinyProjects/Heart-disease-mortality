library(markdown)

navbarPage("Tabs",
           tabPanel("Map",
                    verbatimTextOutput("map")
           ),
           tabPanel("Gender",
                    verbatimTextOutput("gender")
           ),
           tabPanel("Race/Ethnicity",
                    verbatimTextOutput("race/ethnicity")
           )
           )

