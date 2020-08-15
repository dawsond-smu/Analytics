


library(e1071)
library(naivebayes)
library(data.table)
library(DT)
library(forcats)
library(ggplot2)
library(haven)
library(Hmisc)
library(plotly)
library(scales)
library(shiny)
library(stringi)
library(dplyr)
library(rsconnect)
library(ggplot2)
library(caret)
library(class)
library(GGally)
library(e1071)
library(tidyr)
library(ggpubr)
library(readr)  # for read_csv
library(knitr)  # for kable
library(RCurl)
library(skimr)
library(DataExplorer)
library(usmap)
library(maps)
library(statebins)
library(tidyverse)
library(leaps)
library(neuralnet)
library(corrplot)
library(neuralnet)
library(nnet)
library(randomForest)
library(caTools)
library(xgboost)
library(markdown)
library(shiny)
CaseStudyDataUrl ="https://raw.githubusercontent.com/dawsond-smu/Analytics/master/CaseStudy2-data.csv"
CaseStudyData <-read_csv(url(CaseStudyDataUrl))
NoSalaryUrl ="https://raw.githubusercontent.com/dawsond-smu/Analytics/master/CaseStudy2CompSet%20No%20Salary.csv"
NoSalary <-read_csv(url(NoSalaryUrl))
NoAttritionUrl ="https://raw.githubusercontent.com/dawsond-smu/Analytics/master/CaseStudy2CompSet%20No%20Attrition.csv"
NoAttrition <-read_csv(url(NoAttritionUrl))
RegPredictUrl ="https://raw.githubusercontent.com/dawsond-smu/Analytics/master/Case2PredictionsRegressEXAMPLE.csv"
RegPredict <-read_csv(url(RegPredictUrl))
ClassPredictUrl ="https://raw.githubusercontent.com/dawsond-smu/Analytics/master/Case2PredictionsClassifyEXAMPLE.csv"
ClassPredict <-read_csv(url(ClassPredictUrl))
#Merging data together
CaseStudyNoSalary = merge(CaseStudyData, NoSalary, all=TRUE)
CaseStudyNoSalaryNoAttrition = merge(CaseStudyNoSalary, NoAttrition, all=TRUE)
summary(CaseStudyNoSalaryNoAttrition)
#Modify the variables for Analysis
CaseStudy = CaseStudyNoSalaryNoAttrition %>%  mutate(
  JobInvolvement = as.integer(as.factor(JobInvolvement)), 
  JobLevel = as.integer(as.factor(JobLevel)),
  JobSatisfaction = as.integer(as.factor(JobSatisfaction)), 
  PerformanceRating = as.integer(as.factor(PerformanceRating)), 
  RelationshipSatisfaction = as.integer(as.factor(RelationshipSatisfaction)), 
  EnvironmentSatisfaction = as.integer(as.factor(EnvironmentSatisfaction)),
  TrainingTimesLastYear = as.integer(as.factor(TrainingTimesLastYear)),
  WorkLifeBalance = as.integer(as.factor(WorkLifeBalance)),
  MaritalStatus = as.factor(MaritalStatus),
  Department = as.factor(Department),
  Gender = as.factor(Gender),
  BusinessTravel = as.factor(BusinessTravel),
  JobRole = as.factor(JobRole),
  Over18 = as.integer(as.factor(Over18)),
  OverTime = as.integer(as.factor(OverTime)),
  Department= as.factor(Department), 
  StockOptionLevel = as.integer(as.factor(StockOptionLevel)),
  LogMonthlyIncome = log(MonthlyIncome),
  LogDistanceFromHome = log(DistanceFromHome),
  LogJobLevel = log(JobLevel),
  LogPercentSalaryHike = log(PercentSalaryHike),
  NewRelationshipSatisfaction = 
    case_when(
      RelationshipSatisfaction == 1 ~ 0,
      TRUE ~ 1,
    ),
  NumCompaniesWorked = as.integer(NumCompaniesWorked),
  AttritionNum = as.integer(as.factor(Attrition)),
  GenderNum = 
    as.numeric(as.factor(case_when(
      Gender == 'Female' ~ 0,
      TRUE ~ 1,
    ))),
  Gender = as.factor(Gender),
  Department = as.factor(Department),
  MonthlyIncomeCategory = as.integer(as.factor(MonthlyIncome))
  
)



dataset <- CaseStudy

datasetnumeric = CaseStudy %>% select_if(is.numeric)
datasetcharacter = CaseStudy %>% select_if(is.character)

navbarPage("Welcome to DDS Analytics: Case Study 2",
           tabPanel("Plot EDA",
fluidPage(
  
  title = "Case Study Explorer",
  
  plotOutput('plot'),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("Case Study Explorer"),
           h5("DDS Analytics"),
           br(),
           checkboxInput('jitter', 'Jitter'),
           checkboxInput('smooth', 'Smooth'),
           checkboxInput('lm', 'Lm Model Graph')
    ),
    column(4, offset = 1,
           selectInput('x', 'X', names(dataset[sapply(dataset, is.numeric)])),
           selectInput('y', 'Y', names(dataset[sapply(dataset, is.numeric)])),
           selectInput('color', 'Color', c('None', names(dataset[sapply(dataset, is.factor)]))),
           selectInput('fill', 'Fill', c('None',names(dataset[sapply(dataset, is.factor)])))
    ),
    column(4,
           selectInput('facet_row', 'Facet Row',
                       c(None='.', names(dataset[sapply(dataset, is.factor)]))),
           selectInput('facet_col', 'Facet Column',
                       c(None='.', names(dataset[sapply(dataset, is.factor)])))
    )
  )
)),
tabPanel("Data",
         fluidPage(
             titlePanel("Case Study Data"),
             
             # Create a new Row in the UI for selectInputs
             fluidRow(
               column(4,
                      selectInput("Attrition",
                                  "Attrition:",
                                  c("All",
                                    unique(as.character(dataset$Attrition))))
               ),
               column(4,
                      selectInput("JobRole",
                                  "JobRole:",
                                  c("All",
                                    unique(as.character(dataset$JobRole))))
               )
             ),
             # Create a new row for the table.
             DT::dataTableOutput("table")
           )
)
           )



           
           
           
           
           
           
