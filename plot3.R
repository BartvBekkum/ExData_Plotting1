## use library
library(data.table)
library(dplyr)
library(sqldf)

## read file
setwd("C:/Users/bart/Documents/Coursera/4_Expl/Data/")
mydat <- read.csv.sql("household_power_consumption.txt",
                      sql = "select * from file where Date in ('1/2/2007','2/2/2007')",
                      header = TRUE,
                      sep = ";")

if (length(grep("\\?", mydat)) != 0) {print("nok")} else {print("ok")}

mydat$DateTime <- paste(mydat$Date,mydat$Time)
mydat$DateTime <- strptime(mydat$DateTime, format = "%d/%m/%Y %H:%M:%S")

##plot3
png('plot3.png', width = 480, height = 480)
plot(mydat$DateTime, mydat$Sub_metering_1, type = "l", col = 1, ylab = "Energy sub metering", xlab = "")
lines(mydat$DateTime, mydat$Sub_metering_2, col = 2)
lines(mydat$DateTime, mydat$Sub_metering_3, col = 4)
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c(1, 2, 4),
       lty=1)
dev.off()
