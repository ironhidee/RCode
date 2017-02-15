install.packages('mlogit')
catsup<-mlogit.data(Catsup,shape = 'wide',choice="choice")
Catsup
model<-mlogit(choice~price+disp+feat,data=Catsup)
subset(catsup,!duplicated(Catsup$id))
Catsup[!duplicated(Catsup$id),]
View(Catsup)
newdata<-Catsup[!duplicated(Catsup$id),]
summary(newdata)
newdata
attach(newdata)
output<-summary(glm(choice~.,data=newdata,family=binomial))
output
summary(glm(disp.heinz41~price.heinz41,data=newdata,family=binomial))
summary(glm(disp.heinz28~price.heinz28,data=newdata,family=binomial))
summary(glm(disp.heinz32~price.heinz32,data=newdata,family=binomial))
summary(glm(disp.hunts32~price.hunts32,data=newdata,family=binomial))
exp(-2.88)
