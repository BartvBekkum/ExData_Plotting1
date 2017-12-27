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

##plot1
png('plot1.png', width = 480, height = 480)
hist(mydat$Global_active_power, col = 2 , main = "Global active power", xlab = "Global active power (kilowatts)")
dev.off()
