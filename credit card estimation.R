require(memisc)
require(datasets)
require(timeDate)
require(forecast)
require(stats)
require(fpp)
#importing debit card transactions aggregated over months. Same aggregation can be performed for 
a<-debitcards
#Testing with dicker-fuller test for stationary series
adf.test(diff(log(a)), alternative="stationary", k=0)
acf(log(a))
acf(diff(log(a)))
fit <- arima(log(a), c(0, 1, 1),seasonal = list(order = c(0, 1, 1), period = 12))
pred <- predict(fit, n.ahead = 10*12)
ts.plot(a,2.718^pred$pred, log = "y", lty = c(1,3))
