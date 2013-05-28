library(reshape2)

if (file.exists('data/HNP.RData')) {
  load('data/HNP.RData')
} else {
  local({
    Country <- read.csv('data/HNP_Country.csv', fileEncoding='latin1')
    Country <<- data.frame(CountryCode=Country$CountryCode, Long.Name=Country$Long.Name)
    Series <<- read.csv('data/HNP_Series.csv', fileEncoding='latin1')
    Data <<- read.csv('data/HNP_Data.csv', fileEncoding='latin1')
    
    yearCols <<- sapply(1960:2011, function(x) as.character(x))
    for (year in yearCols) {
      Data[[year]] <<- Data[[paste0('X', year)]]
      Data[[paste0('X', year)]] <<- NULL
    }
  })
  save(file='data/HNP.RData', Country, Series, Data, yearCols)
}

indicatorChoices <- structure(
  as.character(Series$SeriesCode),
  names = as.character(Series$Indicator.Name)
)

lookupByIndicator <- function(indicator) {
  data <- Data[Data$Indicator_Code == indicator,]
  data <- melt(data,
               id.vars = 'Country_Name',
               measure.vars = yearCols,
               variable.name = 'Year',
               na.rm=TRUE)
  data$Year <- as.numeric(as.character(data$Year))
  data
}

filterByYear <- function(data, year) {
  data <- data[data$Year == year,]
  data$Year <- NULL
  data
}

filterByCountry <- function(data, country) {
  data <- data[data$Country_Name == country,]
  data$Country_Name <- NULL
  data
}

preserveStructure <- function(dataFrame) {
  structure(
    lapply(names(dataFrame), function(name) {I(dataFrame[[name]])}),
    names=names(dataFrame)
  )
}
