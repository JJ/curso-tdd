library("ggplot2")
library("ggthemes")

data <- read.csv("data/asistencia.csv")

data$Fecha <- as.Date( data$Fecha, "%Y-%m-%d")
ggplot(data,aes(x=Fecha,y=Asistencia))+geom_line()+theme_tufte()
ggsave("data/asistencia.png", width=12, height=8)
