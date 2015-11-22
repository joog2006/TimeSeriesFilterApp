library(shiny)
library(datasets)
library(mFilter)
library(zoo)

shinyUI(
  pageWithSidebar(
    headerPanel("Time Series Band-Pass Filtering"),
    mainPanel(
      h3('Original Data and Trend'),
      plotOutput('newPlot'),
      h3('Cycle Component from Filter'),
      plotOutput('cycPlot')
    ),
    sidebarPanel(
      h3('Select Time Series Dataset'),
      radioButtons("dat", "",
                   c(" Passenger Miles" = "pass",
                     " Lung Deaths UK" = "ldeaths",
                     " Lake Huron Levels" = "lake",
                     " Nile River" = "Nile",
                      "Temperature in Nottingham" = "hamTemp")),
      h3('Select Parameters for a Christiano-Fitzgerald Filter'),
      sliderInput('LF', 'Low Frequency Bound',value = 2, min = 2, max = 12, step = 1),
      sliderInput('HF', 'Upper Frequency Bound',value = 13, min = 13 , max = 112, step = 1),
      h5('This tool applies the band pass filter developed in Christiano and Fitzgerald (2003) to the selected time series. The filter will extract the cycle between the selected upper and lower bounds of the frequency range. The resulting trend and original series are plotted in the top chart while the cycle is plotted below.')
    )

  )
)