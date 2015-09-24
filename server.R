library(shiny)
library(ggplot2)
library(grid)
library(stats)

#Loading the dataset once
wine<<-read.csv("data/winequality-red.csv",sep=";")


shinyServer(function(input, output) {
  
  
  vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
  
  #The linear model is calculated with the lm() function based on the selected variables $ModelVariables
  fit<-reactive({
    lm(as.formula(paste("wine$quality~",paste(input$ModelVariables,collapse="+"))))})
  
  
  output$WineLMplot <- renderPlot({
    
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(ceiling(length(input$ModelVariables)/2), 2)))
    
    fila<-1
    column<-1
    
  
    # If the plots with linear model is selected, ggplot is used to display the resulting model in the 
    # variable fit -reactive function above-. The model  statistical relevant information related to each  variable
    # is placed on top of each graph, like P value, slope, etc.
   if (input$TypeAnalysis==2) {
   
        
    for (i in 1:length(input$ModelVariables)) { 
    
      p<-ggplot(fit()$model, aes_string(x = names(fit()$model)[i+1], y = names(fit()$model)[1])) + 
      geom_point() +
      stat_smooth(method = "lm", col = "blue") +
      labs(title = paste("Adj R2 = ",signif(summary(fit())$adj.r.squared, 3),
                         "Intercept =",signif(fit()$coef[[1]],3 ),
                         " Slope =",signif(fit()$coef[[i+1]], 3),
                         " P =",signif(summary(fit())$coef[i+1,4], 3))) +
      theme(title=element_text(size=8),axis.title.x=element_text(size=10),axis.title.y=element_text(size=10))
      
      
      print(p, vp = vplayout(fila, column))
      
      if (column==1) {column<-2} 
      else {
        fila<-fila+1
        column<-1
      }
      
    }
   }
   else {
     
     #If density graphs are selected, they are pinted using the qplot function, one for each variable selected.
     if (input$TypeAnalysis==1){
       for (i in 1:length(input$ModelVariables)) {
          p<-qplot(x=wine[,i],
                   data=wine,geom="density",fill=factor(quality),xlab="Wine Quality", ylab=input$ModelVariables[i])
          print(p, vp = vplayout(fila, column))
          if (column==1) {column<-2} 
          else {
            fila<-fila+1
            column<-1
          }   
      }
     } else {
       
       #If boxplot graphs are selected, they are pinted using the qplot function, one for each variable selected.
       if (input$TypeAnalysis==3){
         for (i in 1:length(input$ModelVariables)) {
           p<-qplot(quality,y=wine[,i],
                    data=wine,geom="boxplot",fill=factor(quality),xlab="Wine Quality", ylab=input$ModelVariables[i])
           print(p, vp = vplayout(fila, column))
           if (column==1) {column<-2} 
           else {
             fila<-fila+1
             column<-1
           }   
         }
     }
   }
   }  
      })
  
  
  #fit <- reactive({
  #  lm(as.formula(paste("wine.quality ~ ",paste(input$ModelVariables,collapse="+"))),data=wine)
  #3})
  
  #output$regTab <- renderTable({
  #  if(!is.null(input$independent)){
  #    summary(fit())$coefficients
  #  } else {
  #    print(data.frame(Warning="Please select Model Parameters."))
  #  }
  #})
})