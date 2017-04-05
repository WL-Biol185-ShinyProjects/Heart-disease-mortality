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
state.data <- read.table("data/Joined-States-Data.txt")
states@data <- state.data
Male <- read.table("data/Male-Raw-Heart-Disease-Data-Set.txt")
Female <- read.table("data/Female-Raw-Heart-Disease-Data-Set.txt")
Overall <-read.table("data/Overall-Geneder-Raw-Heart-Disease-Data-Set.txt")


fluidPage(

titlePanel("US Heart Disease Mortality"),

navbarPage("",
          
          tabPanel("Home",
                    verbatimTextOutput("Home"),
          img(src = "HumanHeart.png", height = 250, width = 250, align = "center"),
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
             leafletOutput("MyMap"),
             p()
                  ),
            
          tabPanel("Gender",
                    verbatimTextOutput("gender"),
            plotOutput("MaleMap"),
            p(),
            selectInput("State", label = h5("State"), 
                        choices = unique(Male$LocationAbbr), 
                        selected = 1),
            plotOutput("FemaleMap"),
            p()
                  ),
           
          tabPanel("Race/Ethnicity",
                   verbatimTextOutput("race/ethnicity"),
              plotOutput("RaceMap"),
              p(),
              selectInput("Race", label = h5("Race"), 
                          choices = unique(Overall$Race.Ethnicity), 
                          selected = 1)
                  )

           )
           )

