# Load the dataset
# Make sure to replace the path with the actual path to your dataset
data <- read.csv("C:/Users/JIEMIN/OneDrive/Documents/JieMin personal/UTM Degree/YEAR 1 (20232024)/SEM 2/SECI1143 - SEC11 PROBABILITY & STATISTICAL DATA ANALYSIS/PROJECT/Salary_Data.csv")

# Inspect the data
head(data)

# check null data
sum(is.na(data))

# remove null data
dropna_data<-na.omit(data)#data[rowSums(is.na(data)==0,)]

# check null data
sum(is.na(dropna_data))

summary(dropna_data)


# Assuming the dataset has columns named 'Gender' and 'Salary'
# Filter the data by gender
male_salaries <- data$Salary[data$Gender == "Male"]
female_salaries <- data$Salary[data$Gender == "Female"]

# Perform a two-sample t-test
t_test_result <- t.test(male_salaries, female_salaries, var.equal = FALSE)

# Output the test results
print(t_test_result)

# Summary gender
sample_size_male <- sum(data$Gender == "Male")
sample_size_female <- sum(data$Gender == "Female")

# Output gender
print(sample_size_male)
print(sample_size_female)






