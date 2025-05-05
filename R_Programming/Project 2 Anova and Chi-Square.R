# check null data
sum(is.na(data))

# remove null data
salary<-na.omit(data)#data[rowSums(is.na(data)==0,)]

# check null data
sum(is.na(salary))

summary(salary)

sum(salary == "", na.rm = TRUE)

salary[salary == ""] <- NA

new.salary <- na.omit(salary)

# Replace String with another String
library(stringr)
new.salary$Education.Level <- str_replace(new.salary$Education.Level, "phD", "PhD")
new.salary$Education.Level <- str_replace(new.salary$Education.Level, "Bachelor's", "Bachelor's Degree")
new.salary$Education.Level <- str_replace(new.salary$Education.Level, "Master's", "Master's Degree")
new.salary$Education.Level <- str_replace(new.salary$Education.Level, "Bachelor's Degree Degree", "Bachelor's Degree")
new.salary$Education.Level <- str_replace(new.salary$Education.Level, "Master's Degree Degree", "Master's Degree")


#ANOVA Test function
anova = function(data, catList){
  
  cat = unique(catList)
  meanList = c()
  k = length(cat)
  n = length(data)
  ns = c()
  SSE = 0 
  
  for( i in 1:k){
    
    meani = mean(data[catList==cat[i]])
    ns = c( ns, length(catList[catList == cat[i]]) )
    SSE = SSE + sum( (data[catList==cat[i]] - meani)^2 )
    meanList = c(meanList, meani)
  }
  
  SST = sum( ((meanList - mean(meanList))^2)*ns )
  
  f = ( SST/(k-1) ) / ( SSE/(n-k) )
  pVal = pf(f, k-1, n-k, lower.tail = FALSE)
  
  print(data.frame(meanList, ns), colnames=c("mean","sample size"), rownames=cat)
  cat("F value:",f, "\n" )
  cat("P-value:", pVal, "\n")
  
}

#Chi-square Test of Independence function
chiIndCon = function(data1, data2, nInter = 10, minF = 4){
  
  interval = seq(min(data2)-0.0005, max(data2), (max(data2) - min(data2)+0.0005)/nInter)
  data2 = cut(data2, interval)
  conTable = table(data1,data2)
  print("before combine: ")
  print(conTable)
  
  print("after combine: ")
  while(sum(conTable<minF)!=0){
    
    len = length(conTable[1,])
    
    for(i in 1:len){
      
      if(sum(conTable[,i]<minF)!=0){
        
        
        if( (i != len) & (i != 1) ){
          
          if( (sum( (conTable[,i] + conTable[, i+1] )<minF)==0)){
            
            
            if( (i+1) == len){
              
              temTab = cbind(conTable[,1:(i-1)], conTable[,i]+conTable[,i+1])
              interval = c(interval[1:i],interval[(i+2):length(interval)])
              colname = colnames(conTable)
              colnames(tempTab) = c(colname[1:(i-1)], paste("(", interval[i], ",", interval[i+1], "]", sep=""))
            }
            else{
              
              tempTab = cbind(conTable[,1:(i-1)], conTable[,i]+conTable[,i+1] , conTable[,(i+2):len])
              interval = c(interval[1:i],interval[i+2], interval[(i+3):length(interval)])
              colname = colnames(conTable)
              colnames(tempTab) = c(colname[1:(i-1)], paste("(", interval[i], ",", interval[i+1], "]", sep=""), colname[(i+2):len] )
            }
            
            break
          }
          else if( sum( (conTable[,i-1] + conTable[,i] )<minF )==0 ){
            
            
            if( (i-1) == 1){
              
              tempTab = cbind(conTable[,i]+conTable[,i-1], conTable[,(i+1):len])
              interval = c( interval[i-1], interval[i+1], interval[(i+2):length(interval)] )
              colname = colnames(conTable)
              colnames(tempTab) = c(paste("(", interval[i-1], ",", interval[i], "]", sep=""), colname[(i+1):len] )
            }
            else{
              
              tempTab = cbind(conTable[, 1:(i-2)], conTable[,i]+conTable[,i-1], conTable[,(i+1):len])
              interval = c( interval[1:i-1], interval[i+1], interval[(i+2):length(interval)] )
              colname = colnames(conTable)
              colnames(tempTab) = c( colname[1:(i-2)], paste("(", interval[i-1], ",", interval[i], "]", sep=""), colname[(i+1):len])
              
            }
            
            break
          }
          
        }
        else if( i == len){
          
          
          if( sum( (conTable[,len-1] + conTable[,len] )<minF )==0){
            
            tempTab = cbind(conTable[, 1:(len-2)], conTable[,len] + conTable[,len-1])
            interval = c(interval[1:(len-1)], interval[len+1])
            colname = colnames(conTable)
            colnames(tempTab) = c( colname[1 : (len-2)], paste("(", interval[len-1], ",", interval[len], "]", sep=""))
            break
          }
        }
        else if( i == 1){
          
          if( sum( (conTable[,1] + conTable[, 2] )<minF )==0 ){
            
            tempTab = cbind(conTable[, 1]+conTable[,2] , conTable[,3:len])
            interval = c(interval[1], interval[3], interval[4:length(interval)])
            colname = colnames(conTable)
            colnames(tempTab) = c(paste("(", interval[1], ",", interval[2], "]", sep=""), colname[3:len])
            break
          }
        }
        
      }
    }
    
    conTable = tempTab
  }
  
  result = chisq.test(conTable, correct = FALSE)
  print("Observed frequency")
  print(result$observed)
  print("Expected frequency")
  print(result$expected)
  print(summary(result))
  print(result)
  
}

chiIndCon(new.salary$Education.Level, new.salary$Salary, nInter = 10, minF=4)

anova(new.salary$Salary, new.salary$Job.Title)
