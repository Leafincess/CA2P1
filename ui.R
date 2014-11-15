library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
    # Application title
    titlePanel("European Option Price Calculator"),
    sidebarLayout(
      sidebarPanel(
        selectInput("option", label = h4("Option Type"), 
                    choices = list("European Call" = "call", "European Put" = "put"),
                    selected = 1),
        numericInput("S0", 
                     label = h5("Current Stock Price (in $)"), 
                     value = 100),
        numericInput("K", 
                     label = h5("Strike Price"), 
                     value = 100),
        numericInput("tau", 
                     label = h5("Time to Maturity"), 
                     value = 1),
        numericInput("r",
                     label = h5("Risk Free Rate ( %)"),
                     value = 5),
        numericInput("sigma",
                     label = h5("Volatility ( %)"),
                     value = 20),
        submitButton("Submit")
      ),
      mainPanel(
        h3(textOutput("text")),
        h3(textOutput("text1")),
        h4(textOutput("textDelta")),
        h4(textOutput("textGamma")),
        h4(textOutput("textTheta")),
        h4(textOutput("textVega")),
        h4(textOutput("textRho"))
      )
    )
    # Sidebar with a slider input for the number of bins
  )
)
