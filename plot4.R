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


##plot4
png('plot4.png', width = 480, height = 480)
par(mfrow=c(2,2))

##graph 1
plot(mydat$DateTime, mydat$Global_active_power,
     type = "l",
     ylab = "Global active power",
     xlab = "")

##graph 2
plot(mydat$DateTime, mydat$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

##graph 3
plot(mydat$DateTime, mydat$Sub_metering_1, type = "l", col = 1, ylab = "Energy sub metering", xlab = "")
lines(mydat$DateTime, mydat$Sub_metering_2, col = 2)
lines(mydat$DateTime, mydat$Sub_metering_3, col = 4)
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c(1, 2, 4),
       box.lty=0,
       inset = .01,
       lty=1)

##graph 4
plot(mydat$DateTime, mydat$Global_reactive_power,
     type = "l",
     ylab = "Global reactive power",
     xlab = "datetime")

##close
dev.off()
par(mfrow=c(1,1))
