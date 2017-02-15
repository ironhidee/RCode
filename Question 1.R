#Question 1
x<-read.csv(file.choose(),header=T)
str(x)
summary(x)
lm(manaus~time, data = x)
boxplot(x$manaus)
boxplot.stats(x$manaus)
m<-matrix(x$manaus, ncol = 12)
colnames(m)<-month.abb
m<-as.data.frame(m)
boxplot(m)
