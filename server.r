cfTrend <- function(Low, High, DataChoice){
  modelX <- cffilter(DataChoice, pl=Low, pu=High)
  as.zoo(modelX$trend)
} 

cfCycle<- function(Low, High, DataChoice){
  modelX <- cffilter(DataChoice, pl=Low, pu=High)
  as.zoo(modelX$cycle)
} 


shinyServer(
  function(input, output) {
    output$newPlot <- renderPlot({
    datasetInput <- switch(input$dat,
                           "pass" = AirPassengers,
                           "ldeaths" = ldeaths,
                           "lake" = LakeHuron,
                           "Nile" = Nile,
                           "hamTemp" = nottem)
    graphTitle <- switch(input$dat,
           "pass" = "Monthly totals of international airline passengers, 1949 to 1960",
           "ldeaths" = "Monthly Deaths from Lung Diseases in the UK",
           "lake" = "Level of Lake Huron 1875-1972",
           "Nile" = "Flow of the River Nile",
           "hamTemp" = "Average Monthly Temperatures at Nottingham, 1920-1939")
    
      plot(as.zoo(datasetInput), main=graphTitle, ylab="", xlab="")
      lines(cfTrend(input$LF,input$HF,datasetInput), col="red")
      grid()
    })
    output$cycPlot <- renderPlot({
      datasetInput <- switch(input$dat,
                             "pass" = AirPassengers,
                             "ldeaths" = ldeaths,
                             "lake" = LakeHuron,
                             "Nile" = Nile,
                             "hamTemp" = nottem)
      plot(cfCycle(input$LF, input$HF, datasetInput), col="red", ylab = input$dat, xlab="")
      grid()
    })
  }
)