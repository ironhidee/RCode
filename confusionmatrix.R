TClass <- c("A", "A1", "B", "C", "MTO", "TLC")
PClass <- c("A", "A1", "B", "C", "MTO", "TLC")
Y      <- c(2816, 248, 34, 235, 001, 542)
df <- data.frame(TClass, PClass, Y)

library(ggplot2)
ggplot(data =  df, mapping = aes(x = TClass, y = PClass)) +
  geom_tile(aes(fill = Y), colour = "white") +
  geom_text(aes(label = sprintf("%1.0f", Y)), vjust = 1) +
  scale_fill_gradient(low = "blue", high = "red") +
  theme_bw() + theme(legend.position = "none")