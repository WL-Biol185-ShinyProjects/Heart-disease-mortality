library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
<<<<<<< HEAD
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 100,
=======
      sliderInput("bins", 
                  actionButton(),
                  "Number of bins:",
                  min = 1,
                  max = 50,
>>>>>>> 7abc71cf1942072758f5eb48c4fe7461c11979cb
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
<<<<<<< HEAD
)
=======
)
>>>>>>> 7abc71cf1942072758f5eb48c4fe7461c11979cb
