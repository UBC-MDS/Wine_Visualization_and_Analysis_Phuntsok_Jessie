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
library(DT)

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
                     multiple = TRUE,
                     selected='Canada'
      ),
      selectizeInput("province",
                     label = "Select your desired province",
                     choices = NULL,
                     multiple = TRUE),
      selectizeInput("region",
                     label = "Select your desired region",
                     choices = NULL,
                     multiple = TRUE),
      sliderInput("priceInput", "Price",0, 100,c(25,40), pre = "$"),
      sliderInput("points", "points",0, 100, c(80,100), pre = "")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  
                  tabPanel("plot",fluidRow(plotlyOutput("scatplot_price"),
                                           plotlyOutput("scatplot_points"),
                                           plotlyOutput("points_price")) ),
                  tabPanel("Table", dataTableOutput("table")))
                  
                  
      
      
      
      
      
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
                           distinct(province), selected='British Columbia')
  }) 
  
  # change region based on province 
  observeEvent(input$province,{
    updateSelectizeInput(session,'region',
                         choices = clean_data %>% 
                           filter(province %in% input$province) %>% 
                           distinct(region_1), selected='Okanagan Valley')
  }) 
  
  # Dataset table 
  
  wine_df <- reactive(
    {
      clean_data %>% filter(
        country %in% input$country,
        province %in% input$province,
        region_1 %in% input$region,
        price <= input$priceInput[2] & price >= input$priceInput[1]
      ) %>% select(country,province,region_1,price,points)
    }
  )
  
  
  
  
  
  # Generate all outputs 
  wines_filter<-reactive(
    if(is.null(input$province)&
       is.null(input$region)){
      clean_data %>% filter(country%in% input$country,
                            price%in%input$priceInput
                            )
    }else if (is.null(input$region)){
      clean_data %>% filter(country%in% input$country,
                            province %in% input$province,
                            price%in%input$priceInput
                            )
    }else{
    clean_data %>% filter(
      country %in% input$country,
      province %in% input$province,
      region_1 %in% input$region,
      price %in% input$priceInput
      )}
  )
  
  
  output$scatplot_price <-renderPlotly({
    p1<-ggplot(wines_filter(), aes(x = price ,y=  variety,colour=variety)) +
      geom_point(aes(text=title))+ggtitle("price VS variety")
    # facet_wrap(~ variety, scales="free") 
    ggplotly(p1)
  })
  
  output$scatplot_points<-renderPlotly({
    p2<-ggplot(wines_filter(), aes(x = points ,y= fct_reorder( variety,points),colour=points)) +
      geom_point(aes(text=title))+ggtitle("points VS variety")+labs(y="variety")
    
  })
  
  output$points_price<-renderPlotly({
    p3<-ggplot(wines_filter(),aes(x=points,y=price,colour=variety),alpha=0.3)+
      geom_point()
    ggplotly(p3)
    
  })
    
  
  output$points_price<-renderPlotly({
      ggplot(wines_filter(),aes(x=price,y=points,colour=variety))+
      geom_violin(alpha = 0.3, draw_quantiles = c(0.25,0.5,0.75)) +
      geom_jitter(width = 0.2, height = 0, alpha = 0.3) +
      labs(x= "Price", y = "Points", colour = "Variety",
           title = "Price Points distribution by variety")
    
  
  })
  
  
  #Dataset 
  output$table<-DT::renderDataTable(
    {
      DT::datatable(wine_df(),options = list(lengthMenu = c(30,50,100),pageLength = 10))
    }
  )
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)