shinyServer(function(input, output) {
  output$gctrend  <- renderPlot(gcrateplot(input$myyear,input$mylhjlist), height=800)
})