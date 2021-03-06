geochartPrereqs <- tagList(
  tags$head(
    tags$script(src="https://www.google.com/jsapi"),
    tags$script(src="geochart.js")
  )
)

geochart <- function(id, options=list()) {
  tags$div(id=id, class="shiny-geochart-output", `data-options`=RJSONIO::toJSON(options))
}

googleLineChart <- function(id, options=list()) {
  tags$div(id=id, class="google-linechart-output", `data-options`=RJSONIO::toJSON(options))
}

shinyUI(pageWithSidebar(
  headerPanel("Health Stats Explorer"),
  sidebarPanel(
    geochartPrereqs,
    uiOutput('yearUI'),
    selectInput('indicator', 'Indicator', indicatorChoices),
    textOutput('indicatorDesc')
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('Map',
               geochart('map'),
               conditionalPanel(condition='input.map_selection',
                                checkboxInput('normalizeCountryPlot', 'Normalize', TRUE)),
               plotOutput('countryPlot', height='300px')
      ),
      tabPanel('Data', tableOutput('table')),
      tabPanel('Histogram', plotOutput('hist')),
      tabPanel('Trends',
               googleLineChart('trends', options=list(height=600, animation.duration=200)))
    )
    
  )
))