library(shiny)

shinyUI(fluidPage(tabsetPanel(
  tabPanel('LASSO Regression', 
    sidebarLayout(
      sidebarPanel(
        br(),
        sliderInput('lambda_lasso', HTML('<h3>Tuning Parameter &lambda;:</h3>'),
                    min = 0.05, max = 2, value = 0.5, step = 0.05),
        br(),
        withMathJax(helpText("The LASSO minimizes: $$\\|\\mathbf{y - X\\beta}\\|^2_2 + \\lambda\\|\\beta\\|_1$$"))
      ),
      mainPanel(
        plotOutput('lassoplot')
      )
    )
  ),
  tabPanel('Ridge Regression',
    sidebarLayout(
      sidebarPanel(
        br(),
        sliderInput('lambda_ridge', HTML('<h3>Tuning Parameter &lambda;:</h3>'),
                    min = 0.05, max = 100, value = 5, step = 0.05),
        br(),
        withMathJax(helpText("Ridge regression minimizes: $$\\|\\mathbf{y - X\\beta}\\|^2_2 + \\lambda\\|\\beta\\|_2^2$$"))
      ),
      mainPanel(
        plotOutput('ridgeplot')
      )
    )
  ),
  tabPanel('Smoothing Spline', {
    
  })
)))
