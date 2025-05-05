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

#Correlation Test function                          
corTest = function(x, y, alpha=0.05){
  
  r = cor(x,y)
  plot(x, y, xlab = "age", ylab = "salary",
       main = "Relationship between age and the salary")
  n = length(x)
  df = n-2
  t=r/sqrt((1-r^2)/(n-2))
  if(t>0){
    
    pVal = pt(t, n-2, lower.tail = FALSE) 
  }
  else{
    
    pVal = pt(t, n-2)
  }
  
  critical_value = qt(1- alpha / 2, df) #two tail so can be negative and positive if negative just delete the (1-)in the code
  
  cat("n =", n, "\n")
  cat("df =", df, "\n")
  cat("r =", r, "\n")
  cat("t value:",t, "\n" )
  cat("P-value:", pVal, "\n")
  cat("Critical t-value at alpha =", alpha, ":", critical_value, "\n")
  
  if (abs(t) > critical_value) {
    cat("The correlation is statistically significant at alpha =", alpha, "\n")
  } else {
    cat("The correlation is not statistically significant at alpha =", alpha, "\n")
  }
}

corTest(dropna_data$Age, dropna_data$Salary)
