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
library(plotly)
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
                        multiple = TRUE),
            sliderInput("priceInput", "Price",0, 100,c(25,40), pre = "$")
          
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           
           plotlyOutput("scatplot_price"),
           plotlyOutput("scatplot_points"),
           plotlyOutput("points_price")
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
    
    wines_filter<-reactive(
        clean_data %>% filter(
            country %in% input$country,
            province %in% input$province,
            region_1 %in% input$region
        )
    )
    
    output$scatplot_price <-renderPlotly({
        p1<-ggplot(wines_filter(), aes(x = price)) +
            geom_density()
        p1
    })
    
    output$scatplot_points<-renderPlotly({
        p2<-ggplot(wines_filter(),aes(x = points))+
            geom_bar()
        ggplotly(p2)
    })
    
    output$points_price<-renderPlotly({
        p3<-ggplot(wines_filter(),aes(x=points, y=price))+
            geom_jitter(aes(text=title),alpha=0.3)
        ggplotly(p3)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
