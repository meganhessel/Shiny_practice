
install.packages(pkgs = c("here", "tidyverse", "shiny", "shinydashboard", "shinyWidgets", "shinycssloaders", "markdown", "DT", "leaflet", "bslib", "fresh", "sass", "reactlog", "shinytest2", "diffviewer", "palmerpenguins", "lterdatasampler", "gapminder"))


library(shiny)
runExample()

runExample("01_hello", display.mode = "showcase")

# Input: Slider for the number of bins ----
sliderInput(inputId = "bins",
            label = "Number of bins:",
            min = 1,
            max = 50,
            value = 30)
