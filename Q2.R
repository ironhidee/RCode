require(Ecdat)
attach(Computers)
reg1<-lm(price~speed+hd+ram+screen+cd+factor(multi)+factor(premium)+ads+trend)
summary(reg1)
outlierTest(reg1)

