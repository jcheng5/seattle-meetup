library(BSDA)
library(ggplot2)

shinyServer(function(input, output) {

  output$hist <- renderPlot({
    
    binwidth <- diff(range(Stamp$thickness)) / (input$breaks-1)
    print(qplot(Stamp$thickness, binwidth=binwidth))
    
  })

})
