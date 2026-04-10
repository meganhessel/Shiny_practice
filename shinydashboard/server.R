server <- function(input, output){
  
  # Filter lake data ---- 
  filter_lake_df <- reactive({
    
    lake_data %>% # Access input values 
      filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2]) %>% 
      filter(AvgDepth >= input$avg_depth_input[1] & AvgDepth <= input$avg_depth_input[2]) %>% 
      filter(AvgTemp >= input$avg_temp_input[1] & AvgTemp <= input$avg_temp_input[2])
  })
  
  
  # Build leaflet map ----
  output$lake_map_output <- renderLeaflet({
    
    leaflet() %>% 
      
      # Add tiles 
      addProviderTiles(providers$Esri.WorldImagery) %>% # basemap
      
      # Set view over AK
      setView(lng = -152.048442, lat = 70.249234, zoom = 6) %>% 
      
      # Add mini App 
      addMiniMap(toggleDisplay = TRUE, 
                 minimized = FALSE) %>% # not minimized by default 
      
      # Add Markers
      addMarkers(data = filter_lake_df(), 
                 lng = filter_lake_df()$Longitude, 
                 lat = filter_lake_df()$Latitude, 
                 popup = paste0(
                   "Site Name: ", filter_lake_df()$Site, "<br>", 
                   "Elevation: ", filter_lake_df()$Elevation, " meteres (above SL)", "<br>", 
                   "Average Depth: ", filter_lake_df()$AvgDepth, " meters ", "<br>", 
                   "Average Lake Bed Temp: ", filter_lake_df()$AvgTemp, " °C"
                 )) 
    
  }) 
  
}