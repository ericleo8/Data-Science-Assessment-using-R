df <- data.frame(a = c(1, 2, 3), b = c(4, 5, 6), c = c(7, 8, 9))
df[[2]]
df[[1]][[1]]
df[[2]][[3]]

x <- c("red", "blue", "yellow", "orange", "green", "purple")
y <- x[c(2, 3, 4)]
y

x <- factor(c("grape", "apples", "pear", "cherry", "mango", "panda")) # membuat variabel berisi factor
x
x[6] <- "apples" # mengganti isian factor
x

add_numbers <- function(x, y) {
    x + y
}
add_numbers(3, 3)

# mengganti missing value
df <- c(1, 2, 3, 4, 5, 6, NA, 7, 8, 9, NA)
df
mean_replace <- function(i) {
    i[is.na(i)] <- mean(i, na.rm = TRUE)
    i
}
df <- mean_replace(df)
df

# langkah awal
library(readr)
trees_df <- read.csv("https://storage.googleapis.com/dqlab-dataset/trees.csv")

# cek struktur data
names(trees_df)
str(trees_df)
names(trees_df)[1] <- "Diameter"
trees_df$diameter_ft <- trees_df$Diameter * 0.08333
head(trees_df)
summary(trees_df)
is.na(trees_df)

# shapiro test
shapiro.test(trees_df$diameter_ft)
shapiro.test(trees_df$Height)
shapiro.test(trees_df$Volume)

# density plot
plot(density(trees_df$Volume))

# mencari hubungan
lm(formula = Volume ~ Height + diameter_ft, data = trees_df)
plot(trees_df$diameter_ft, trees_df$Volume)
plot(trees_df$Height, trees_df$Volume)

# analisa efek pemberian obat tidur
library(readr) # pre-defined
library(dplyr) # pre-defined

sleep_df <- read_csv("https://storage.googleapis.com/dqlab-dataset/sleep.csv") # pre-defined

# Save the data in two different dataframe/vector
group1 <- filter(sleep_df, sleep_df$group == 1)
group2 <- filter(sleep_df, sleep_df$group == 2)

# Compute t-test
t_test <- t.test(group1$extra, group2$extra)
t_test

# boxplot
library(ggplot2)
ggplot(sleep_df, aes(x = as.character(group), y = extra, fill = as.character(group))) +
    geom_boxplot()

# membuat model sederhana
library(readr)
electric_bill <- read_csv("https://storage.googleapis.com/dqlab-dataset/electric_bill.csv")
model <- lm(amount_paid ~ num_people + housearea, data = electric_bill)

model

# training and testing
library(readr)
library(caret)
set.seed(123)
iris <- read_csv("https://storage.googleapis.com/dqlab-dataset/iris.csv")

trainIndex <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
training_set <- iris[trainIndex, ]
testing_set <- iris[-trainIndex, ]

dim(training_set)
dim(testing_set)

#model decision tree
install.packages('caret')
library(caret) #pre-defined 
library(rpart) #pre-defined
library(readr) #pre-defined
set.seed(123)  #pre-defined

suv_data <- read_csv("https://storage.googleapis.com/dqlab-dataset/suv_data.csv") #pre-defined

#split data to training & testing set
trainIndex <- createDataPartition(suv_data$Purchased, p = 0.8, list = FALSE)
training_set <- suv_data[trainIndex, ]
testing_set <- suv_data[-trainIndex,]

#build model with decision tree
model_dt <- rpart(Purchased ~ ., data = training_set, method="class")
predictions_dt <- predict(model_dt, newdata = testing_set, type = "class")

#evaluate performance with new data/ testing_set
testing_purchased <- factor(testing_set$Purchased) #pre-defined 

#show the evaluation result 
evaluation_result <- confusionMatrix(predictions_dt, testing_purchased)
evaluation_result