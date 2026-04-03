# -- user interface --- 
ui <- navbarPage(
  
  # title --- 
  title = "LTER Animal Data Explorer",
  
  
  
  # (Page 1) Intro tab panel 
  tabPanel(title = "About this app", 
           
           # Intro text fluidRow  - can add left and right margins 
           fluidRow(
             column(1), # Margins
             column(10, # Total columns = 12... how many columns do you want the text to take up
                    includeMarkdown("text/about.Rmd")), 
             column(1) # Margins
           ), # END Intro text fluidRow  
           
           hr(), # grey horizontal row 
           
           includeMarkdown("text/footer.Rmd") # Adds footer at the end 
           
  ), # END (Page 1) intro TabPanel
  
  
  # (Page 2) Data tabPanel 
  tabPanel(title = "Explore the Data", 
           
           # TabsetPanel to contain tabs for data viz -- 
           tabsetPanel(
             
             # Trout tab Panel --- 
             tabPanel(
               title = "Trout", 
               # Trout sidebarlayout 
               sidebarLayout(
                 
                 # Trout sidebar panel
                 sidebarPanel(
                   # channel type picker Input 
                   pickerInput(inputId = "channel_type_input", 
                               label = "Select channel type(s)", 
                               choices = unique(clean_trout$channel_type), 
                               selected = c("cascade", "pool"), 
                               multiple = TRUE, # can select multiple options
                               options = pickerOptions(actionsBox = TRUE) # 'Select all' & 'deselect all'
                               ), # END Channel type picker input 
                   
                   # Selection checkboxGroupButtons --- 
                   checkboxGroupButtons(inputId = "section_input", 
                                        label = "Select a Sampling Section", 
                                        choices = c("clear cut forest", "old growth forest"), 
                                        selected = c("clear cut forest", "old growth forest"), 
                                        justified = TRUE, 
                                        checkIcon = list(yes = icon("check", lib = "font-awesome"), 
                                                         no = icon("xmark", lib = "font-awesome"))
                   ) # End of side bar Panel
                 ), # End trout side bar Layout
                 
                 
                 # Trout main panel 
                 mainPanel(
                   plotOutput(outputId = "trout_scatterplot_output") # Place holder 
                 ) # END trout main Panel
                 
                 
               ) # END trout sidebar Panel
             ), # End trout tabPanel
             
             
             # Penguin tab Panel --- 
             tabPanel(
               title = "Penguin", 
               
               # Penguin sidebar layout
               sidebarLayout(
                 
                 sidebarPanel(
                   # channel type picker Input 
                   pickerInput(inputId = "island_input", 
                               label = "Select Island", 
                               choices = unique(penguins$island), 
                               selected = unique(penguins$island), 
                               multiple = TRUE, # can select multiple options
                               options = pickerOptions(actionsBox = TRUE) # 'Select all' & 'deselect all'
                               ), # END Channel type picker input 
                   
                   # Slider Input 
                   sliderInput(inputId = "bin_input", 
                               label = "Bin Width", 
                               min = 1, max = 100, 
                               value = 10) # END of slider input
                   
                 ), # END penguin side bar panel
                 
                 # Penguin main panel 
                 mainPanel(
                   plotOutput(outputId = "island_output") # Place holder
                 ) #END main panel
                 
               ) # END penguin sidebar layout 
             ) #END penguin side bar tab
           ) # End Penguin tabPanel
           
  ) # END (Page 2) data tan panel
  
) # END NAVbar page
