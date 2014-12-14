library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("NPL calculation"),
  sidebarPanel(
    h4('Introduce sentence'),
    textInput("input", "Input sentence:",value = ""),
    submitButton("Predict")
    
  ),
  
  mainPanel(
    h4("n gram predicted:"),
    verbatimTextOutput("output")
    br(),
    h4('Instructions'),
    helpText("This application is to calculate the BMI. Body mass index (BMI) is a measure of body fat based on height and weight that applies to adult men and women."),
    helpText("You need to enter your weight and height in either of the two metric systems provided to obtain your BMI.")    
    
  )
))
