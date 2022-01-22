library(shiny)
library(glue)
library(dplyr)
library(scales)
library(shinythemes)

stats <- c("Attack Bonus", "Block", "Dodge", "Submission Bonus", 
           "SDI", "Adrenaline", "Bleed Bonus", "DDI", 
           "Escape Submission", "Initiative", "Health Points", 
           "Stamina", "Pin Opp", "Pin Bonus")

triangles <- function(n, value = "SDI") {
  
  multi = case_when(
    value == "Health Points" ~ 20,
    value == "Stamina" ~ 5,
    TRUE ~ 1
  )
  
  val = (n*(n + 1)) * multi
  
  return(glue('Level {n} gives {comma(val)} {value}.'))
  
}


ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel("Stat Value Calculator"),
  sidebarLayout(
    sidebarPanel(
      selectInput("stat", "Stat:", choices = unique(stats)),
      numericInput(
        'stat_value', 'Stat Level', 
        value = 1, min = 1, max = 1000000, 
        step = 1, width = '120%'),
      br(),
      actionButton("goButton", "Go!")
    ),
    fluidRow(column(6, h4(""), textOutput("summary")))
  )
)

server <- function(input, output, session) {
  output$summary <- renderText({
    
    input$goButton
    
    
    triangles(isolate(input$stat_value), input$stat)
    
  })
}

shinyApp(ui, server)	