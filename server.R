library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$lassoplot <- renderPlot(plotLassoWrap(input$lambda_lasso))
  output$ridgeplot <- renderPlot(plotRidgeWrap(input$lambda_ridge))
})
