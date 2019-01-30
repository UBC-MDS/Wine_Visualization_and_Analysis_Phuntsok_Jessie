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
library(shinythemes)

#Loading data 
clean_data<-read.csv("data/clean_data.csv")

country<- as.factor(unique(clean_data$country))


# Define UI for application 
ui <- fluidPage(
  
  # application theme 
  theme = shinytheme("sandstone"),
  
  # Application title
  
  titlePanel("Hello Wine App",
             windowTitle = "Wine app"),
  
  
  # Sidebar with a slider input  
  sidebarLayout(
    sidebarPanel(
      # Input country, default selecting is "Canada" 
      selectizeInput("country",
                     label = "Select your desired country",
                     choices = country,
                     multiple = TRUE,
                     selected='Canada'
      ),
      
      # Input province 
      selectizeInput("province",
                     label = "Select your desired province",
                     choices = NULL,
                     multiple = TRUE),
      # Input regrion 
      selectizeInput("region",
                     label = "Select your desired region",
                     choices = NULL,
                     multiple = TRUE),
      # Input price and points
      sliderInput("priceInput", "Price",0, 100,c(25,40), pre = "$"),
      sliderInput("points", "points",0, 100, c(80,100), pre = "")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Summary",
                           br(),
                           "Hello Wine! Here is the best place for you to explore wordly wine.", br(),
                           "Please select your desired wine's country, province or region and adjusted your desired prices and ratings range.",
                           br(),
                           "You will see each variety's price and ratings.",
                           br(),
                           "Moreover, you can see in different areas, price and ratings' distribution. Enjoy!",
                           br(),br(),
                           span("Github Repository:",
                                tags$a(href="https://github.com/UBC-MDS/Wine_Visualization_and_Analysis_Phuntsok_Jessie","Wine_repo")),
                           br(),
                           span("Developers:",
                                tags$a(href="https://github.com/jielinyu","Jessie Yu"),
                                "and",
                                tags$a(href="https://github.com/phuntsoktseten","Phuntsoktseten"))
                           

                           
                           
                           
                           ),
                  tabPanel("plot",fluidRow(plotlyOutput("points_price"),

                                           splitLayout(cellWidths = c("50%", "50%"), plotlyOutput("scatplot_price"), plotlyOutput("scatplot_points"))
                                          
                                      
                                           ) ),

                                          
                  tabPanel("Table", dataTableOutput("table")))
      
      
      
      
      
      
      
    )
  )
)

# Define server logic 
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
                            price <= input$priceInput[2] & price >= input$priceInput[1]
      )
    }else if (is.null(input$region)){
      clean_data %>% filter(country%in% input$country,
                            province %in% input$province,
                            price <= input$priceInput[2] & price >= input$priceInput[1]
      )
    }else{
      clean_data %>% filter(
        country %in% input$country,
        province %in% input$province,
        region_1 %in% input$region,
        price <= input$priceInput[2] & price >= input$priceInput[1]
      )}
  )
  

  # First violin plot 
  output$points_price<-renderPlotly({
    p3<-ggplot(wines_filter(),aes(x=price,y=points,colour=variety))+
      geom_violin(alpha = 0.5, draw_quantiles = c(0.25,0.5,0.75)) +
      labs(x= "Price", y = "Points", colour = "Variety",
           title = "Price Points distribution by variety")+theme_bw()
    ggplotly(p3)
    
  })
  
  # second price histogram
  output$scatplot_price <-renderPlotly({
    p1<-ggplot(wines_filter(), aes(x = price,fill=)) +
      geom_histogram(colour="black", fill="brown2")+ggtitle("price distribution")+
      theme_bw()+
      geom_density(alpha=.2, fill="#FF6666")
    ggplotly(p1)
  })
  
  # third points histogram
  output$scatplot_points<-renderPlotly({
    p2<-ggplot(wines_filter(), aes(x = points)) +
      geom_histogram(colour="black",fill="orange2")+ggtitle("points distribution")+
      theme_bw()
    
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