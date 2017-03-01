#Loading libraires
require(forecast)
require(tseries)
#Rohit 
#Taking the given data as input
y<-read.csv(file.choose(), header=T)
#assigning the obs as a time series
yobs<-ts(y$Obs, start=c(2003,1), frequency=12)
#Plotting yobs for any inequalities
plot(yobs)
#Differencing the data to remove the trend
plot(diff(yobs))
#Logging the data to make the varience constant with time
plot(log10(yobs))
plot(diff(log10(yobs)))
#Conducting yje Dicker-fuller test to check for stationary series
adf.test(log10(yobs))
#Series is somewhat stationary
#Conducting the Arima
a1<-auto.arima(log10(yobs),approximation=FALSE,trace=FALSE)
#Arima modeling Done!
summary(a1)
#Checking for  independence in a given time series
Box.test(a1$residuals, lag=12, type = "Ljung-Box")
#We accept the null hypostesis and the model is a Success!
f<-forecast(a1, h=12)
plot(f)

h1<-stl(yobs, s.window="periodic")
plot(h1)
