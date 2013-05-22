geochartPrereqs <- tagList(
  tags$head(
    tags$script(src="https://www.google.com/jsapi"),
    tags$script(src="geochart.js")
  )
)

geochart <- function(id, options=list()) {
  tags$div(id=id, class="shiny-geochart-output", `data-options`=RJSONIO::toJSON(options))
}

shinyUI(pageWithSidebar(
  headerPanel("Map demo"),
  sidebarPanel(
    geochartPrereqs,
    sliderInput('factor', 'Factor', min=1, max=100, value=1)
  ),
  mainPanel(
    geochart('map')
  )
))