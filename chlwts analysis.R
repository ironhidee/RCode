b<-chickwts
chickwts$feed <- as.factor(chickwts$feed)
table(chickwts$feed)
x<-lm(weight~feed, data=chickwts)
anova(x)
summary(x)
require(mosaic)
TukeyHSD(chickmodel)
boxplot(weight~reorder(feed,weight,median), data=chickwts, xlab="Feed type", ylab="Chick weight at six weeks (g)", ylim=c(100,500))
