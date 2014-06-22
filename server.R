################################################################################################################
#Shiny and Epitools packages are required for this little app
library(shiny)
library(epitools)

#################################################################################################################
# gcrateplot is the main function that plots the data
gcrateplot <- function(year,lhj){
  
  cases <- paste0("c",year)
  pop   <- paste0("p",year)
  
  dat <- transform(dat,rate = dat[,cases]*100000/dat[,pop])
  dat <- dat[order(dat$rate),]
  CI <- 100000*pois.exact(dat[,cases],dat[,pop])[,4:5]
  CI[dat[,cases]==0,1:2] <-0
  
  mycol <- rep("blue",nrow(dat))
  mycol[dat$LHJ == lhj] <- "red"
  
  par(mar=par()$mar+c(2,6,0,0))
  
  t.plot <- barplot(dat$rate,col=mycol,xlim=c(0,350),horiz=TRUE,space=.3,xlab="incidence rate per 100,000 population (and 95% Confidence Interval)")
  axis(side=2,at=t.plot,labels=dat$LHJ,las=2,cex.axis=.9)
  arrows(y0=t.plot,x0=CI[,1],x1=CI[,2],length=.05,angle=90,code=3)
  mtext(text=year,side=3,cex=1.5)
  
  segments(50*1:7,min(t.plot),50*1:7,max(t.plot),col="gray",lty=2)
  
}

#################################################################################################################
#place is the location of the ui.R and server.R files AND the location of the .csv data file
place <- getwd()#"d:/GCratebyLHJ"

#read data
dat <- read.table(paste0(place,"/GC cases and pop by LHJ 2001-2013.csv"),sep=",",na.strings="",header=T)

#create vector used as "drop down" list in the app -- this is probalby better done "recursivley" in the app
lhjlist <- c("State",as.vector(dat$LHJ))

shinyServer(function(input, output) {
  output$gctrend  <- renderPlot(gcrateplot(input$myyear,input$mylhjlist), height=800)
})