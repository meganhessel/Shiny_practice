# ---- load pkgs --- 
library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)



# --- user interface --- 
ui <- fluidPage(
  
  # App title --- 
  tags$h1("My App Title"), # tags$ ("") gives tons of html options
  
  # Sub-title --- 
  h2(strong("Exploring Antarctic Penguin Data")), # strong = bold in html
  
  
  
  # WIDGET1: 
  # body mass SLIDER input --- 
  sliderInput(inputId = "body_mass_input", # Need to be unique 
              label = "Select a range of body masses", # Text above slider
              min = 2700, max = 6300, # Can do min(body_mass) and max(body_mass)
              value = c(3000, 4000) # Slider has a range of body masses that default with 3000 and 4000 
              ),
  # Change slider color 
  shinyWidgets::chooseSliderSkin(skin = 'Flat', color = "orange"),
  
  # body mass plot output (placeholder) ---
  plotOutput(outputId = "body_mass_scatterplot_output"
             ),
  
  
  
  # WIDGET2: 
  # species check box input --- 
  checkboxGroupInput(inputId = "species_check_input", 
                     label = "Select Species", 
                     choices = unique(penguins$species)
                     #selected = unique(penguins$species)
                     ),
  
  # Species checkbox output (placeholder)
  DT::dataTableOutput(outputId = "species_check_output")
  
  
)

# --- server --- 
server <- function(input, output) {
  
  # ----- Body Mass Slider Plot ---- 
  # (a) Filter body masses --- 
  # Creating a reactive df for renderPlot below 
  body_mass_df <- reactive({ # Reactive df
    # Filtering code
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2])) # Vectors Update-able thru UI
  }) 
  
  # (b) RenderPlot --- 
  # What output Id are we referring to?
  output$body_mass_scatterplot_output <- renderPlot({
    # Code to generate plot 
    ggplot(na.omit(body_mass_df()), # Update with reactive dataframe above (need the parathesis)
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "white"))
  })
  
  # ----- Species Checkbox Datatable ---- 
  # (a) Filter species --- 
  # Creating a reactive df for renderPlot below 
  species_check <- reactive({ # Reactive df
    # Filtering code
    penguins %>% 
      filter(species %in% c(input$species_check_input)) 
  }) 
  
  # (b) RenderPlot --- 
  # What output Id are we referring to?
  output$species_check_output <- renderDataTable({
    # Code to generate data table
    DT::datatable(species_check())
  })
  
  
}



# --- combine UI and server into app --- 
shinyApp(ui = ui, server = server)

