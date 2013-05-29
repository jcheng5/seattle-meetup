shinyUI(basicPage(

  h4('Thickness of 1872 Hidalgo stamps issued in Mexico'),
  
  plotOutput('hist'),
  
  sliderInput('breaks',
              label = 'Number of bins (approx)',
              min = 4, max = 75, value = 4)
))
