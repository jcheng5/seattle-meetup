shinyServer(function(input, output, session) {
  output$map <- function() {
    df <- data.frame(
      Country = c('Germany', 'United States', 'Brazil', 'Canada', 'France', 'RU'),
      Popularity = c(200, 300, 400, 500, 600, 700)
    )
    df$Popularity <- runif(nrow(df)) * input$factor
    df
  }
})