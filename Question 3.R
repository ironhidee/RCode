#Question 3
attach(attitude)
y<-lm(rating~complaints+privileges+learning+raises+critical+advance)
summary(y)
anova(y)

#Performing the diagnostics
require(lmtest)
#dwtest
dwtest(rating~complaints+privileges+learning+raises+critical+advance)

#reset test
resettest(rating~complaints+privileges+learning+raises+critical+advance)
