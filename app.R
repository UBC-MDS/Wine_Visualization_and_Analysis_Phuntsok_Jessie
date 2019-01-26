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
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Table", tableOutput("table")),
                        plotlyOutput("scatplot_price"),
                          plotlyOutput("scatplot_points"),
                            plotlyOutput("points_price"),
                  
                  tabPanel("plot", plotOutput("plot")))
                  
                  
                 
      
      
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
   # wines_filter$variety<-factor(wines_filter$variety, levels = rev(levels(wines_filter$variety)))
    p1<-ggplot(wines_filter(), aes(x = price ,y= fct_reorder( variety,price),colour = variety) )+
      geom_point(aes(text=title))+ggtitle("price VS variety")+labs(y="variety")
    ggplotly(p1)
  })
  
  output$scatplot_points<-renderPlotly({
    p2<-ggplot(wines_filter(), aes(x = points ,y= fct_reorder( variety,points),colour=variety)) +
      geom_point(aes(text=title))+ggtitle("points VS variety")+labs(y="variety")
    ggplotly(p2)
    #p2<-ggplot(wines_filter(),aes(x = points))+
      #geom_bar()
    #ggplotly(p2)
  })
  
  output$points_price<-renderPlotly({
    p3<-ggplot(wines_filter(),aes(x=points, y=price, colour=variety))+
      geom_jitter(aes(text=variety),alpha=1)
    ggplotly(p3)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)