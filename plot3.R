library(data.table)
library(dplyr)

graphdata <- fread("household_power_consumption.txt", na.strings = "?")
graphdata <- mutate(graphdata, Date = as.Date(Date, format = "%d/%m/%Y"))

# only be using data from the dates 2007-02-01 and 2007-02-02
graphdata <- subset(graphdata, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
graphdata$DateTime <- with(graphdata, as.POSIXlt(paste(Date, Time)))

# construct the plot
with(graphdata, plot(DateTime, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering"))
with(graphdata, lines(DateTime, Sub_metering_2, col = "red"))
with(graphdata, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), y.intersp=0.6, cex=0.7, seg.len=0.5)
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()
