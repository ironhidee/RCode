require(HistData)
attach(GaltonFamilies)
str(GaltonFamilies)

#Now we have a look at the mean of the population 
mean(midparentHeight)
 
#Now we run regression on childHeight and midparentHeight
reg2<-lm(childHeight~midparentHeight)
summary(reg2)

#Now we have a look at the mean of the child heights 
mean(childHeight)
