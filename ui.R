shinyUI(pageWithSidebar(
  


headerPanel(h4("Annual Gonorrhea Incidence Rate By Local Health Jurisdiction")),

sidebarPanel( 
 
  sliderInput("myyear","Year",min=2001,max=2013,value=2001,format="####",animate=animationOptions(interval = 100, loop = FALSE)),
  selectInput("mylhjlist", "Select LHJ to Highlight:",choices = lhjlist,selected="State")
  
),

mainPanel(  
    plotOutput("gctrend")

)
))
