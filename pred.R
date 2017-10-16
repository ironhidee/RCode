require(xts)
require(forecast)
require(tseries)
dat <- read.csv(file.choose(),h=T)
#dat <- dat[10297:13152,]

time_index <- seq(from = as.POSIXct("2011-10-01 00:00"), 
                  to = as.POSIXct("2013-03-31 23:00"), by = "hour")
eventdata <- xts(dat$Count, order.by = time_index)

adf.test(eventdata)

x.msts <- msts(eventdata,seasonal.periods=c(24,168))
model <- tbats(x.msts,use.parallel = T,use.arma.errors = T)
f1<-forecast(model,h=2928)
f3<- thetaf(x.msts,h=2928)

f<- (f3$mean+f1$mean)/2

pred <- read.csv(file.choose(), h=T)

colnames(pred)<- "ID"

pred1 <- as.data.frame(cbind(pred$ID,f))

colnames(pred1)<- c("ID","Count")
write.csv(pred1 , "pred.csv", row.names = F)


