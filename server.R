#carrega
library(RPostgreSQL)
library(leaflet)
library(shiny)
library(shinydashboard)

server <- function(input, output, session) {
  
  #acessa o banco de dados
  con <- dbConnect(PostgreSQL(),dbname="biotecmar",user="biotecmar",host="buriti.lncc.br", password="biotecmar@123")
  
  #resgata os dados de latitude e longitude
  out=dbGetQuery(con, "Select latitude, longitude from sample")
  
  
  output$map <- renderLeaflet({
    leaflet(data = out) %>%
      addTiles() %>%  
      addMarkers(~longitude, ~latitude, popup="")
  })
  
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}


