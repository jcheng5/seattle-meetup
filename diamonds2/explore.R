explore <- function(dataset, ...) {
  require(shiny)
  require(ggplot2)

  app <- list(
    ui = pageWithSidebar(
     
      headerPanel("Data Explorer"),
      
      sidebarPanel(
     
        if (nrow(dataset) > 5000) {
          sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                      value=min(1000, nrow(dataset)), step=500, round=0)
        } else {
          list()
        },
        
        selectInput('x', 'X', names(dataset)),
        selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
        selectInput('color', 'Color', c('None', names(dataset))),
        
        checkboxInput('jitter', 'Jitter'),
        checkboxInput('smooth', 'Smooth'),
        
        selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
        selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
      ),
     
      mainPanel(
        plotOutput('plot')
      )
    ),
    server = function(input, output) {
     
      data <- reactive({
        if (is.null(input$sampleSize))
          dataset
        else
          dataset[sample(nrow(dataset), input$sampleSize),]
      })
     
      output$plot <- renderPlot({
        
        p <- ggplot(data(), aes_string(x=input$x, y=input$y)) + geom_point()
        
        if (input$color != 'None')
          p <- p + aes_string(color=input$color)
        
        facets <- paste(input$facet_row, '~', input$facet_col)
        if (facets != '. ~ .')
          p <- p + facet_grid(facets)
        
        if (input$jitter)
          p <- p + geom_jitter()
        if (input$smooth)
          p <- p + geom_smooth()
        
        print(p)
        
      }, height=700)
      
    }
  )
  runApp(app, ...)
}