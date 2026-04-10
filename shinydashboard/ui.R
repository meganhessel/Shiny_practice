# ----- dashboardHeader
header <- dashboardHeader(
  
  # Title 
  title = "Fish Creek Watershed Lake Monitorting", 
  titleWidth = 400
  
)

# ----- dashboardSidebar
sidebar <- dashboardSidebar(
  
  # Sidebar menu 
  sidebarMenu(
    menuItem(text = "Welcome", 
             tabName = "welcome", # unique identifier 
             icon = icon("star") # front awesome lib 
             ),
    menuItem(text = "Dashboard", 
             tabName = "dashboard", # unique identifier 
             icon = icon("gauge")
             )
  ) # END sidebarMenu 
  
) # END dashboardSidebar



# ----- Dashboard Body # ----- 
body <- dashboardBody(
  
  # tabItems - Need one for every menu item
  tabItems( 
    
    # tabItem for the **Welcome** menuItem ---- 
    tabItem(
      tabName = "welcome", 
      
      # Left-hand column 
      column(width = 6, 
             
             # Background box 
             box(width = NULL,
                 title = tagList(icon("water"), 
                                 strong("Monitoring Fish Creek Watershed"), # Bold the title
                                 includeMarkdown("text/intro.md"), # Text from this markdowm
                                 
                                 # Add static image
                                 tags$image(src = "FishCreekWatershedSiteMap_2020.jpg",  
                                            alt = "Map",
                                            style = "max-width: 100%" # controls width 100% of box its in 
                                            ), 
                                 # Add data source hyperlink under image 
                                 tags$p(tags$em("Map Source: ", 
                                                # Hyperlinking with tags$a 
                                                tags$a(href = "http://www.fishcreekwatershed.org/", # link 
                                                       "FCWO")), # Text 
                                        style = "text-align: center;" # Center text 
                                                )
                 )
                 
               ) # END background box
             
             ), # END left-hand column 
      
      # Right-hand column 
      column(width = 6,
             
             # Data source box 
             box(width = NULL, 
                 title = tagList(icon("table"), 
                                 strong("Data Source"), 
                                 includeMarkdown("text/citation.md")
                 )
                 ), # END data source box
            
              # Disclaimer box 
             box(width = NULL,
                 title = tagList(icon("triangle-exclamation"), 
                                 strong("Disclaimer"), 
                                 includeMarkdown("text/disclaimer.md")
                 )
                 ) # END Disclaimer box
             
             ) # END right hand column
      
      
    ), # END welcome tabItem
    
    
    
    # tabItem for the **Dashboard** menuItem ---- 
    tabItem(
      tabName = "dashboard", 
      
      #input box 
      box(width = 4, 
          title = tags$strong("Adjust lake parameter ranges:"), 
          
          # SliderInputs 
          sliderInput(inputId = "elevation_slider_input", 
                      label = "Elevation (meters above SL):", 
                      min = min(lake_data$Elevation), max = max(lake_data$Elevation), # Slider range
                      value = c(min(lake_data$Elevation), max(lake_data$Elevation)) # Default start 
                      ), # END elevation sliderInput
          sliderInput(inputId = "avg_depth_input", 
                      label = "Average Depth:", 
                      min = min(lake_data$AvgDepth), max = max(lake_data$AvgDepth), 
                      value = c(min(lake_data$AvgDepth), max(lake_data$AvgDepth))
                      ), # END avg depth sliderInput 
          sliderInput(inputId = "avg_temp_input", 
                      label = "Average Temp (°C):", 
                      min = min(lake_data$AvgTemp), max = max(lake_data$AvgTemp), 
                      value = c(min(lake_data$AvgTemp), max(lake_data$AvgTemp))
                      ) # END avg depth sliderInput 
          
      ), #END input box
      
      # leadlet box 
      box(width = 8,
          leafletOutput(outputId = "lake_map_output") %>% 
            withSpinner(type = 1, color = "blue") # Loading bar 
      ) # END leaflet box
      
    ) # END dashboard tabItem
    
  ) # END tab items 
  
) # END dashboardBody 

# ----- Combind all into dashbaordPage 
dashboardPage(header, sidebar, body) # END dashboardPage
