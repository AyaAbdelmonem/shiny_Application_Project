
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)
library(miniUI)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
   data("airquality")
  
  
  airquality$Month_new <- ifelse(airquality$Month - 7 > 0 , airquality$Month - 7 , 0)
  
  airquality$Day_new <- ifelse(airquality$Day - 15 > 0 , airquality$Day - 15 , 0)
  
  model1 <- lm(Temp ~ Month_new , data =  airquality)
  
  model2 <- lm(Temp ~ Day_new , data =  airquality)
  
  
  
  model1pred <- reactive({
    
    
    
    
    MonthInput <- input$sliderMonth 
    
    predict(model1,
            
            newdata = data.frame(Month = MonthInput ,
                                 
                                 Month_new = ifelse( MonthInput - 7 > 0,
                                                 
                                                 MonthInput - 7 , 0 )))
    
    
  })
  
  
  
  model2pred <- reactive({
    
    DayInput <- input$sliderDay 
    
    predict(model2,
            
            newdata = data.frame(Day = DayInput ,
                                 
                                 Day_new = ifelse( DayInput - 15 > 0,
                                                 
                                                 DayInput - 15 , 0 )))
    
  })
  
  
  
  output$plot1 <- renderPlot({
    
    MonthInput <- input$sliderMonth
    
    plot( airquality$Month, 
          airquality$Temp ,
          
          xlab = "Months", 
          ylab = "Temprature" ,
          bty ="n" ,
          pch = 16 )
    
    
    
    
    
    if(input$showModel1)
    {
      model1lines <- predict(model1 ,
                             newdata = data.frame( Month = 5:9 ,
                                                   Month_new = ifelse(5:9 - 7 > 0 , 5:9 , 0)))
      
      lines(5:9 , model1lines , col = "blue" , lwd = 2) 
      
    }
    
  
    points(MonthInput, model1pred(), col= "green" , pch = 16 , cex = 2)
   
    
    
  })
  
  
  
  output$plot2 <- renderPlot({
    
    DayInput <- input$sliderDay
    
    
    plot(x=airquality$Day, 
         y=airquality$Temp ,
         xlab = "Days", 
         ylab = "Temprature" ,
         bty ="n" , 
         pch = 16 )
    
    
    
  
    
    
    if(input$showModel2)
    {
      model2lines <- predict(model2 ,
                             newdata = data.frame( Day = 1:30 ,
                                                   Day_new = ifelse(1:30 - 15 > 0 , 1:30 , 0)))
      
      lines(1:30 , model2lines , col = "red" , lwd = 2)
      
    }
    
  
    points(DayInput, model2pred(), col= "green" , pch = 16 , cex = 2)
    
    
  })
  
  
  output$pred1 <- renderText({
    
    model1pred()
    
  })
  
  
  output$pred2 <- renderText({
    
    model2pred()
    
  })
  
  
})
