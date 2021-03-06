attach(mtcars)
require(plyr)
count(mtcars, 'gear')
cd<-kmeans(iris[,c(4,3)] , centers = 3)
require(ggplot2)
ggplot(mtcars, aes(cyl, hp, color = gear)) + geom_point()
ggplot(iris, aes(Sepal.Length, Petal.Length, color= Species)) + geom_point()
