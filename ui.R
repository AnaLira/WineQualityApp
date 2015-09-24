library(shiny)

# 
shinyUI(fluidPage(
  
  # Application title
  headerPanel("Assignment - Wine Quality Modeling"),
  
  # Sidebar with to collect input variables:
  # One radio button list to indicate the type of output the users wants
  # One checkbox list to indicate which variables from the data set are going to be considered 
  # in the linear modeling function or graphs
  # To avoid recalculating results on each variable selection, a submit button was added.
  sidebarPanel(
    h4("Model Configuration",align="center"),
    
    radioButtons("TypeAnalysis", label = h5("¿What would you like to see about wine quality related to the selected variables?"),
                 choices = list("Data discovery density graphs" = 1, "Plots with resulting linear model" = 2,
                                "Data discovery boxplot graphs" = 3),selected = 1),
    
    
    checkboxGroupInput("ModelVariables", 
                       label = h5("Select the variables to consider in the linear model:"), 
                       choices = list("Density"="wine$density",
                                      "pH"="wine$pH",
                                      "Sulphates"="wine$sulphates",
                                      "Alcohol"="wine$alcohol",
                                      "Fixed acidity" = "wine$fixed.acidity", 
                                      "Volatile acidity" = "wine$volatile.acidity", 
                                      "Citric Acid" = "wine$citric.acid",
                                      "Residual Sugar" = "wine$residual.sugar",
                                      "Chlorides"="wine$chlorides",
                                      "Free Sulfure Dioxide"="wine$free.sulfur.dioxide"
                                      ),
                       selected = c("wine$density","wine$pH")),
    
    submitButton( "Submit")
  ),
  
  # Show the results according to variables and type of output selected
  mainPanel(
    h5('Based on a dataset containing different measures for different Italian red wines, this application shows how the different variables measured affect resulting wine quality.
       The dataset used and description of the data source is available at:'),
    a('https://archive.ics.uci.edu/ml/datasets/Wine+Quality',href='https://archive.ics.uci.edu/ml/datasets/Wine+Quality'),
    h5('Wine quality is defined on a scale from 1 to 10, being 10 the top quality value.'),
    plotOutput("WineLMplot")
    )
  )
)