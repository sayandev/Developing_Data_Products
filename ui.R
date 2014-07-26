library(shiny)

# Define UI for dataset viewer application#pageWithSidebar
shinyUI(
  fluidPage(
    # Application title
    headerPanel("Today's weather forecast"),
  
    sidebarPanel(
      textInput('city', "Enter the name of your City and the preferably two digit Country code. Hint: For City 'New York', enter County code 'US' " , 
                "New York,US"),
      submitButton('Enter')
    ),
    mainPanel(
        h4("The weather forecast for your city:"),
        verbatimTextOutput("inputValue"),
        h3('Crucial Weather elements with magnitude is listed bellow:'),
        h4('Temeprature: (in degree Fahrenheit)'),
        verbatimTextOutput("prediction"),
        h4('Humidity:'),
        verbatimTextOutput("prediction1"),
        h4('Wind:'),
        verbatimTextOutput("prediction2")
        
    )
    
  )
)

