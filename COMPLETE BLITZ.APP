# Basic Packages
    
library(shiny)
library(leaflet)

df <- data.frame("id" = c("1", "2", "3", "4"),
                 "lng" = c(-46.63, -46.65, -46.57, -46.60),
                 "lat" = c(-23.55, -23.51, -23.54,-23.54),
                 "Text" = c("BLITZ1", "BLITZ2", "BLITZ3","BLITZ4" ))


ui <- fluidPage(
  leafletOutput("map"),
  textOutput("locationid1"),
  textOutput("locationid2"),
  textOutput("locationid3"),
  textOutput("locationid4")
)

server <- function(input, output, session) {

  output$map <- renderLeaflet({
    df %>% leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%
      setView(-46.63, -23.55, zoom = 12) %>%
      addMarkers(layerId = ~id, popup = ~paste("<b>", Text, "</b></br>", actionButton("selectlocation", "Select this Location", onclick = 'Shiny.onInputChange(\"button_click\",  Math.random())')))
  })


  id1 <- reactive({
     validate(
       need(!is.null(input$map_marker_click), "Please select a location from the map above")
     )
    input$map_marker_click$id
  })

  id2 <- eventReactive(input$button_click, {
    input$map_marker_click$id
  })
  
  id3 <- eventReactive(input$button_click, {
    input$map_marker_click$id
  })
  
  id4 <- eventReactive(input$button_click, {
    input$map_marker_click$id
  })


  output$locationid1 <- renderText({paste("Location Selected using marker click:", id1())})
  output$locationid2 <- renderText({paste("Location Selected using popup select button click:", id2())})
  output$locationid3 <- renderText({paste("Location Selected using popup select button click:", id3())})
  output$locationid4 <- renderText({paste("Location Selected using popup select button click:", id4())})
}

shinyApp(ui, server)
