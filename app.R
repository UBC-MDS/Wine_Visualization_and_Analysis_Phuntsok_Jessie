#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
clean_data<-read.csv("data/clean_data.csv")

country<- as.factor(unique(clean_data$country))
#province<-unique(clean_data$province)
#region<-unique(clean_data$region_1)
#price<-as.numeric(clean_data$price)
#points<-as.numeric(clean_data$points)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Hello Wine App",
               windowTitle = "Wine app"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectizeInput("country",
                        label = "Select your desired country",
                        choices = country,
                        multiple = TRUE
                        ),
            selectizeInput("province",
                        label = "Select your desired province",
                        choices = NULL,
                        multiple = TRUE),
            selectizeInput("region",
                        label = "Select your desired region",
                        choices = NULL,
                        multiple = TRUE)
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           
           #plotlyOutput("price_hist")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output,session) {

    # change province choices based on country
    observeEvent(input$country,{
        updateSelectizeInput(session,'province',
                             choices = clean_data %>% 
                                 filter(country %in% input$country) %>% 
                                 distinct(province))
    }) 
    
    # change region based on province 
    observeEvent(input$province,{
        updateSelectizeInput(session,'region',
                             choices = clean_data %>% 
                                 filter(province %in% input$province) %>% 
                                 distinct(region_1))
    }) 
}

# Run the application 
shinyApp(ui = ui, server = server)
