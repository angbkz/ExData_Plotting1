library(data.table)
library(dplyr)

graphdata <- fread("household_power_consumption.txt", na.strings = "?")
graphdata <- mutate(graphdata, Date = as.Date(Date, format = "%d/%m/%Y"))

# only be using data from the dates 2007-02-01 and 2007-02-02
graphdata <- subset(graphdata, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
graphdata$DateTime <- with(graphdata, as.POSIXlt(paste(Date, Time)))

# construct the plot 
with(graphdata, plot(DateTime, Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
