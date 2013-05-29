### Shiny examples for Seattle useR Meetup, May 2013

See accompanying slides, downloadable from the [meetup page](http://www.meetup.com/Seattle-useR/events/116710342/).

For more information about Shiny, visit the [Shiny homepage](http://rstudio.com/shiny).

#### Installation

At the time of this writing (May 29, 2013) these applications require a more recent version of Shiny than is available on CRAN. To install, run these commands from R:

```
if (!require('devtools'))
  install.packages('devtools')
install.packages('httpuv', repos=c(RStudio='http://rstudio.org/_packages',
                                   CRAN='http://cran.rstudio.com'))
devtools::install_github('shiny', 'rstudio')
```

Many of the examples also require ggplot2:

```
install.packages('ggplot2')
```

This repository contains submodules (`dashboard` and `g3plot`); after cloning, run this command to clone the submodules:

```
git submodule update --init
```

Or alternatively, just visit those projects at their original project pages: https://github.com/alexbbrownIntel/g3plot and https://github.com/wch/shiny-jsdemo

#### Running Examples

From an R console, change the working directory using `setwd()` to one of the following subdirectories:

* diamonds
* diamonds3
* g3plot
* health
* slides
* stamps (BSDA and ggplot2 packages required)

Then execute the command `shiny::runApp()` to begin the application. If you already have a Shiny application running in a different R process, you will get an error that the server could not be started. You can fix this by explicitly providing a port number: `shiny::runApp(port=8102)` for example.

For the diamonds2 example, just source the `explore.R` file contained in that directory, then run `explore(df)` where `df` is a data frame.
