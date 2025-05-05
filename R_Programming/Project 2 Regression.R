# import data
data<-read.csv("D:/utm_2/PSDA/project_2/Salary_Data.csv")

head(data)

# check data type
sapply(data, class)

#get summary
summary(data)

# change feature to factor
data$Gender<-as.factor((data$Gender))
sapply(data, class)   # check data type
summary(data)         #get summary

# change character for education level
data$Education.Level<-as.factor((data$Education.Level))
sapply(data,class)
summary(data)

# change character for job
data$Job.Title<-as.factor((data$Job.Title))
sapply(data,class)
summary(data)

# check null data
sum(is.na(data))

# remove null data
dropna_data<-na.omit(data)#data[rowSums(is.na(data)==0,)]

# check null data
sum(is.na(dropna_data))

summary(dropna_data)

#Regression                            
reg = function(x, y){
  
  model = lm(y~x)
  print(summary(model))
  print(cor(x,y))
  plot(x, y, xlab = "Year of Experience", ylab = "Salary",
       main = "Relationship between year of experience and salary")
  abline(model, col="red")
}
reg(dropna_data$Years.of.Experience, dropna_data$Salary)
#y=b0+b1x   b1=7046.77   b0=58283.28
#t larger means we confidence that the model is not 0, strong evidence, the more* the more significant
#residual standard error the smaller, the best, means more accurate
#multiple r square means how the year of experience helps to explain the salary, fitting the data as well(standard error)
#f large and p is small(basically is 0) indicate that we reject the null hypothesis, strong evidence the relationship does exist between the year and salary

