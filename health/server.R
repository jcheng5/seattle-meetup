library(ggplot2)

shinyServer(function(input, output, session) {
  indicatorData <- reactive({
    lookupByIndicator(input$indicator)
  })
  
  data <- reactive({
    filterByYear(indicatorData(), input$year)
  })
  
  rangeForAllYears <- reactive({
    range(indicatorData()$value)
  })
  
  output$yearUI <- renderUI({
    yearRange <- range(indicatorData()$Year)
    sliderInput('year', 'Year', format="0000", animate=TRUE,
                min=yearRange[1], max=yearRange[2], value=yearRange[1])
  })
  
  output$indicatorDesc <- renderText({
    as.character(Series[Series$SeriesCode == input$indicator,]$Long.definition)
  })
  
  output$map <- reactive({
    if (is.null(input$year))
      return(NULL)
    df <- data()
    if (nrow(df) == 0)
      return(NULL)
    list(data = df,
         options = list(
           colorAxis = list(
             minValue = min(indicatorData()$value),
             maxValue = max(indicatorData()$value)
           )
         )
    )
  })
  
  output$table <- renderTable({
    data()
  }, include.rownames = FALSE, include.colnames = FALSE)
  
  output$hist <- renderPlot({
    #hist(data()$value, breaks=20, xlim=rangeForAllYears())
    print(qplot(data()$value, binwidth=diff(rangeForAllYears())/20, xlim=rangeForAllYears(), ylim=c(0,10)))
  })
  
  output$trends <- reactive({
    data <- indicatorData()
    hrange <- range(data$Year)
    vrange <- range(data$value)
    data <- data[data$Year <= input$year,]

    casted <- dcast(data, Year ~ Country_Name)

    list(data = casted,
         options = list(
           hAxis = list(viewWindowMode = 'explicit', viewWindow = list(
             min = hrange[1], max = hrange[2]
           ), format="####"),
           vAxis = list(viewWindowMode = 'explicit', viewWindow = list(
             min = vrange[1], max = vrange[2]
           ))
         )
    )
  })
})