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


fluidPage(
          theme = shinytheme("cerulean"),
          titlePanel("US Heart Disease Mortality"),
          navbarPage("",
                    tabPanel("Home",
                    verbatimTextOutput("Home"),
                    img(src = "HumanHeart.png", 
                        height = 250, 
                        width = 250, 
                        align = "center"
                       ),
                    br(),
                    br(),
                    p("Welcome to our page on Heart Disease in the United States! Here you can explore 
                      many different variables and how they all relate to heart disease mortality. Now,
                      you may be asking yourself what exactly is heart disease? The Mayo Clinic classifies 
                      blood vessel diseases, arrhythmias, congenital heart defects, diseases that 
                      affect heart muscle, and diseases that affect the heart valves all under the 
                      broader classification of heart disease. Sometimes, if left untreated these diseases
                      can lead to blocked vessels or arteries which results in heart attack or stroke and eventually death. The 
                      data set used on this website is from 2013 and contains rates of heart disease mortality per 
                      100,000 individuals in every US State and also at the county level. The data is also 
                      broken up by race/ethnicity as well as gender. Below is a link to access and download
                      the free source data set."),
                    a(href = "https://catalog.data.gov/dataset/heart-disease-mortality-data-among-us-adults-35-by-state-territory-and-county", "US Heart Disease Mortality Data")
                     ),
                    tabPanel("Map",
                              verbatimTextOutput("map"),
                              radioButtons("MapType", 
                                            label = h3("Map Type"),
                                            choices = c("States", 
                                                        "Counties"
                                                       ), 
                                            selected = "States"
                                           ),
                              hr(),
                              fluidRow(column(3, 
                                              verbatimTextOutput("value")
                                              )
                                       ),
                              leafletOutput("MyMap"),
                              br(),
                              p("Welcome to our Map page! Here you can toggle between States or Counties to see a visual
                                representation on Heart Disease Mortality rates for individuals 35 years or older in the
                                United States. You can zoom in on the map by scrolling with your cursor on top of the map.
                                A text box will appear when hover your cursor over a US county or state. The text box will
                                display the number of deaths due to heart disease for every 100,000 people."
                               )
                             ),
                    tabPanel("Gender",
                             verbatimTextOutput("gender"),
                             plotOutput("MaleMap"),
                             selectInput("StateMale", 
                                         label = h5("State"), 
                                         choices = unique(Male$LocationAbbr), 
                                         selected = 1, 
                                         multiple = TRUE
                                        ),
                             br(),
                             p("Welcome to our Gender page! Here you can compare rates of Heart Disease Mortality bewteen men 
                               and women using a boxplot. In the drop down box you can select multiple states to compare the data. The male data
                               will appear in the color blue, while the female data appears in the color pink."),
                             br(),
                             strong("Infromation on how to read a boxplot:"),
                             p("Line inside of box = Median, this is the point where 50% of the data is above the line and 50% is below"),
                             p("Top of box = this marks the upper quartile, this means that 75% of the data is below this point"),
                             p("Bottom of box = this marks the lower quartile, this means that 25% of the data is below this point"),
                             p("Everything else represents data points that are outside of the 25%-75% range"),
                             br(),
                             p("For more information on how to interpret boxplots go to the following page"),
                             a(href = "http://www.wellbeingatschool.org.nz/information-sheet/understanding-and-interpreting-box-plots", "Box Plot Help"),
                             plotOutput("FemaleMap"),
                             selectInput("StateFemale", 
                                         label = h5("State"), 
                                         choices = unique(Female$LocationAbbr), 
                                         selected = 1, multiple = TRUE
                                        ),
                             p()
                           ),
                    tabPanel("Race/Ethnicity",
                             verbatimTextOutput("race/ethnicity"),
                             plotOutput("RaceMap"),
                             p(),
                             selectInput("Race", 
                                         label = h5("Race"), 
                                         choices = unique(Overall$Race.Ethnicity), 
                                         selected = 1, 
                                         multiple = TRUE),
                             p("Welcome to out Race/Ethnicity page! Here you can compare rates of Heart Disease Mortality bewteen
                               different Races/Ethnicities. In the drop down box you can select multiple different Races or 
                               Ethnicities and graphically compare the data.")
                            )

                    )
           )

