dataset <- list('Upload a file'=c(1))

shinyUI(pageWithSidebar(
 
  headerPanel("Data Explorer"),
  
  sidebarPanel(

    fileInput('file', 'Data file'),
    radioButtons('format', 'Format', c('CSV', 'TSV')),
 
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset)),
    selectInput('color', 'Color', c('None', names(dataset))),
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth'),
    
    selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
    selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
  ),
 
  mainPanel(
    plotOutput('plot')
  )
))