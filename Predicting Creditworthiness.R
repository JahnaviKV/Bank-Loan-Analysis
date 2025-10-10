install.packages(c("shiny", "randomForest", "caret", "dplyr"))

library(shiny)
library(randomForest)
library(caret)
library(dplyr)

loan_data <- loan.df

# Converting relevant categorical variables into factors
loan_data$DEFAULT <- as.factor(loan_data$DEFAULT)
loan_data$REASON <- as.factor(loan_data$REASON)
loan_data$JOB <- as.factor(loan_data$JOB)

# Train the Random Forest model
set.seed(123)
rf_model <- randomForest(DEFAULT ~ LOAN + MORTDUE + VALUE + REASON + JOB + YOJ + DEROG + DELINQ + CLAGE + NINQ + CLNO + DEBTINC,
                         data = loan_data, ntree = 700, mtry = 3, importance = TRUE)

# Define UI for the app
ui <- fluidPage(
  titlePanel("Loan Default Prediction Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("loan", "Loan Amount:", value = 10000, min = 0),
      numericInput("mortdue", "Mortgage Due:", value = 50000, min = 0),
      numericInput("value", "Home Value:", value = 100000, min = 0),
      selectInput("reason", "Loan Reason:", choices = levels(loan_data$REASON)),
      selectInput("job", "Job Category:", choices = levels(loan_data$JOB)),
      numericInput("yoj", "Years on Job:", value = 5, min = 0),
      numericInput("derog", "Number of Derogatory Reports:", value = 0, min = 0),
      numericInput("delinq", "Number of Delinquent Credit Lines:", value = 0, min = 0),
      numericInput("clage", "Age of Oldest Credit Line (months):", value = 100, min = 0),
      numericInput("ninq", "Number of Recent Credit Inquiries:", value = 0, min = 0),
      numericInput("clno", "Number of Credit Lines:", value = 10, min = 0),
      numericInput("debtinc", "Debt to Income Ratio (%):", value = 30, min = 0),
      
      actionButton("predict", "Predict")
    ),
    
    mainPanel(
      h3("Prediction Result"),
      verbatimTextOutput("prediction")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  observeEvent(input$predict, {
    # Create a new data frame for prediction
    new_data <- data.frame(
      LOAN = as.numeric(input$loan),
      MORTDUE = as.numeric(input$mortdue),
      VALUE = as.numeric(input$value),
      REASON = factor(input$reason, levels = levels(loan_data$REASON)),  # Ensuring factor type
      JOB = factor(input$job, levels = levels(loan_data$JOB)),  # Ensuring factor type
      YOJ = as.numeric(input$yoj),
      DEROG = as.numeric(input$derog),
      DELINQ = as.numeric(input$delinq),
      CLAGE = as.numeric(input$clage),
      NINQ = as.numeric(input$ninq),
      CLNO = as.numeric(input$clno),
      DEBTINC = as.numeric(input$debtinc)
    )
    
    # Predict using the random forest model
    prediction <- predict(rf_model, new_data)
    
    # Display the prediction result
    output$prediction <- renderText({
      if (prediction == 1) {
        "Yes"
      } else {
        "No"
      }
    })
  })
}
# Run the app
shinyApp(ui = ui, server = server)
