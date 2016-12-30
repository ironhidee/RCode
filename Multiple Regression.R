#Loading the inbulit data on airqulaity
x <-data("airquality")
#Looking at the structure of the data
str(airquality)

require(stats)#Load the stats pakage

#looking at how the Ozone factor is affected by the rest of the variables
ozone_affect <- lm(Ozone ~ Solar.R + Wind + Temp + Month + Day, data=x, na.action = T)