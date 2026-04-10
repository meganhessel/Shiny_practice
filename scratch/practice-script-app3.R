# load pkgs ---- 
library(arrow)
library(leaflet)
library(tidyverse)

# read in data ----
lake_data <- read_parquet(here::here("shinydashboard", "data", "lake_data_processed.parquet"))

# Practice filtering 
filter_lake_df <- lake_data %>% 
  filter(Elevation >= 8 & Elevation <= 20) %>% 
  filter(AvgDepth >= 2 & AvgDepth <= 3) %>% 
  filter(AvgTemp >= 4 & AvgTemp <= 6)

# Pratice building leaflet
leaflet() %>% 
  
  # Add tiles 
  addProviderTiles(providers$Esri.WorldImagery) %>% # basemap
  
  # Set view over AK
  setView(lng = -152.048442, lat = 70.249234, zoom = 6) %>% 
  
  # Add mini App 
  addMiniMap(toggleDisplay = TRUE, 
             minimized = FALSE) %>% # not minimized by default 

  # Add Markers
  addMarkers(data = filter_lake_df, 
             lng = filter_lake_df$Longitude, 
             lat = filter_lake_df$Latitude, 
             popup = paste0(
              "Site Name: ", filter_lake_df$Site, "<br>", 
              "Elevation: ", filter_lake_df$Elevation, " meteres (above SL)", "<br>", 
              "Average Depth: ", filter_lake_df$AvgDepth, " meters ", "<br>", 
              "Average Lake Bed Temp: ", filter_lake_df$AvgTemp, " °C"
             )) 
