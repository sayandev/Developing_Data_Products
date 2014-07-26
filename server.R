library(shiny)
library(XML)
cityWeather <- function(city) {
  address=city
  url = paste( "http://api.openweathermap.org/data/2.5/weather?mode=xml&q=", URLencode(address), sep="" )
  xml = xmlTreeParse(url, useInternalNodes=TRUE) # take a look at the xml output:
  condition=xpathSApply(xml,"//current/clouds",xmlGetAttr,"name")
  cloud=xpathSApply(xml,"//current/clouds",xmlGetAttr,"name")
  country=xpathSApply(xml,"//current/city/country",xmlValue)
  city=xpathSApply(xml,"//current/city",xmlGetAttr,"name")  
  return(cat(paste("Weather forecast for", city, "in",country,"predicts:", condition)))
}

cityTemp <- function(city) {
    address=city
    url = paste( "http://api.openweathermap.org/data/2.5/weather?mode=xml&q=", URLencode(address), sep="" )
    xml = xmlTreeParse(url, useInternalNodes=TRUE) # take a look at the xml output:    
    temp_c=xpathSApply(xml,"//current/temperature",xmlGetAttr,"value")
    temp_min=xpathSApply(xml,"//current/temperature",xmlGetAttr,"min")
    temp_max=xpathSApply(xml,"//current/temperature",xmlGetAttr,"max")    
    city=xpathSApply(xml,"//current/city",xmlGetAttr,"name")
    temp_c=(as.double(temp_c)-273.15)*1.8+32
    temp_c=format(round(temp_c, 2), nsmall = 2)
    temp_min=(as.double(temp_min)-273.15)*1.8+32
    temp_min=format(round(temp_min, 2), nsmall = 2)
    temp_max=(as.double(temp_max)-273.15)*1.8+32
    temp_max=format(round(temp_max, 2), nsmall = 2)    
    return(cat(paste("Current temperature is:", temp_c, ", Min:",temp_min, ", Max:", temp_max,".")))
}

cityHumidity <- function(city) {
    address=city
    url = paste( "http://api.openweathermap.org/data/2.5/weather?mode=xml&q=", URLencode(address), sep="" )
    xml = xmlTreeParse(url, useInternalNodes=TRUE) # take a look at the xml output:    
    humidity=xpathSApply(xml,"//current/humidity",xmlGetAttr,"value")    
    city=xpathSApply(xml,"//current/city",xmlGetAttr,"name")    
    return(cat(paste("The Humidity is", humidity, "%.")))
}

cityWind <- function(city) {
    address=city
    url = paste( "http://api.openweathermap.org/data/2.5/weather?mode=xml&q=", URLencode(address), sep="" )
    xml = xmlTreeParse(url, useInternalNodes=TRUE) # take a look at the xml output:
    wind1=xpathSApply(xml,"//current/wind/speed",xmlGetAttr,"name")
    wind2=xpathSApply(xml,"//current/wind/speed",xmlGetAttr,"value")
    wind3=xpathSApply(xml,"//current/wind/direction ",xmlGetAttr,"name")
    wind4=xpathSApply(xml,"//current/wind/direction ",xmlGetAttr,"value")
    city=xpathSApply(xml,"//current/city",xmlGetAttr,"name")    
    return(cat(paste("Wind condition:",wind1,"; Speed:",wind2,"m/s, Direction:",wind3,"(",wind4,"degree.)")))
}

shinyServer(
  function(input, output) {        
    output$inputValue <- renderPrint({cityWeather(input$city)})
    output$prediction <- renderPrint({cityTemp(input$city)})
    output$prediction1 <- renderPrint({cityHumidity(input$city)})
    output$prediction2 <- renderPrint({cityWind(input$city)})     
  }
)
