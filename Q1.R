require(car)
attach(Duncan)
str(Duncan)
type<-as.factor(Duncan$type)
table(type)

x<-lm(prestige~type) #Comaparing prestige across different types of occupation
anova(x)
require(mosaic)
x1<-TukeyHSD(x)
plot(x1)
#The results show that there is a huge difference between the prestige of prob-bc and wc and prof 

y<-lm(education~type) #Comaparing education across different types of occupation
anova(y)
y1<-TukeyHSD(y)
plot(y1)
#The results show that there is a huge difference between the education of prob-bc, wc-prof and wc-bc 

z<-lm(income~type) #Comaparing income across different types of occupation
anova(z)
z1<-TukeyHSD(z)
plot(z1)
#The results show that there is a huge difference between the incoe of prob-bc and wc-bc
