#carrega
library(RPostgreSQL)
library(leaflet)
library(shiny)
library(shinydashboard)

#Pagina web
#Pagina web
shinyUI <- fluidPage(

  br(),

  img(height = 62,
      width = 111,
      src ="http://marinebiodiversity.lncc.br/bamba/wp-content/uploads/2015/06/Screenshot-2015-06-02-16.26.50.png"),
  
  
  hr(),
  br(),
  tabBox(
    id = "tabset1", height = "100%", width = "100%",
    tabPanel(title=strong("Geographic Explorer"), status = "primary", solidHeader = TRUE,
             collapsible = TRUE,
             width = "100%",
             height = "100%",
             leafletOutput("map")),
    
    tabPanel(strong("Tab2"), "Tab content 2"),
    
    tabPanel(strong("Statistic"), "Tab content 3"),
    
    tabPanel(strong("Analysis"), "Tab content 4")
  )
)
