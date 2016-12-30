#Reading the dtata from files
train<-read.csv(file.choose(), header=T)
test<-read.csv(file.choose(), header=T)
str(train)
str(test)

#Since Test has to survive variable, we need to add one 
# Add a Survived variable to the test 
test.survived <- data.frame(survived = rep("None", nrow(test)), test[,])

#The survive variable is filled with "none"
# Combine data sets
data.combined <- rbind(train, test.survived)

str(data.combined)

#Cahnging the variables from int to factor
data.combined$survived <- as.factor(data.combined$survived)
data.combined$pclass <- as.factor(data.combined$pclass)


# Taking a look at the survival rates
table(data.combined$survived)


# Distribution across classes
table(data.combined$pclass)


# Load up ggplot2 package
require(ggplot2)


# Plot1 - Rich people survived at a higer rate
train$pclass <- as.factor(train$pclass)
ggplot(train, aes(x = pclass, fill = factor(survived))) +
  geom_bar() +
  xlab("Pclass") +
  ylab("Total Count") +
  labs(fill = "Survived") 