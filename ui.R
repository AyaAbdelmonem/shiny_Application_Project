
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("predict Temprature based on Month/day "),
  
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    sidebarPanel(
      sliderInput("sliderMonth",
                  "What Month do you need to get the temprature ?", 5,9, value = 7),
      sliderInput("sliderDay",
                  "What is the day  you need to get the temprature ?", 1,30, value = 15),
      
      checkboxInput("showModel1","show/hide predict by month", value = TRUE),
      checkboxInput("showModel2","show/hide predict by day", value = TRUE),
      
      submitButton("submit")
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Summary"),
      h4("We are using airquality dataset  to predict the temprature based on month or day value , I'm using two separated models for both month and day supported with plots .  "),
      plotOutput("plot1"),
      plotOutput("plot2"),
      h3("Predicted Temprature based on month :" ),
      textOutput("pred1"),
      h3("predicted Temprature based on day :"),
      textOutput("pred2")
      
    )
    
  )
))
