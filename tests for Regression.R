attach(anscombe)
require(lmtest)

#reset test
resettest(y1~x1)
#the pvalue is .7861 the p-values give no evidence to reject the null hypothesis of no misspecification. For the given data set, the linear model appears adequate.

#DW Test
#Interprestting resukts as
#2 is no autocorrelation.
#0 to <2 is positive autocorrelation (common in time series data).
#>2 to 4 is negative autocorrelation (less common in time series data).
dwtest(y1~x1)
#Since DW is 3.2123, alternative hypothesis: true autocorrelation is greater than 0
#There is negative correlation.