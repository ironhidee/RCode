#question 2
c<-read.csv(file.choose(), header=T)
c$group<-as.factor(c$group)
table(c$group)
s1<-lm(wl1~group, data = c)
anova(s1)
require(mosaic)
f<-TukeyHSD(s1)
plot(f)
