# Reading the data
householdpower <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
householdpower$Date <- as.Date(householdpower$Date, format="%d/%m/%Y")
#subsetting our desired days
power1 <- householdpower[(householdpower$Date=="2007-02-01") | (householdpower$Date=="2007-02-02"),]
power1$Global_active_power <- as.numeric(as.character(power1$Global_active_power))
power1$Global_reactive_power <- as.numeric(as.character(power1$Global_reactive_power))
power1$Voltage <- as.numeric(as.character(power1$Voltage))
power1 <- transform(power1, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
power1$Sub_metering_1 <- as.numeric(as.character(power1$Sub_metering_1))
power1$Sub_metering_2 <- as.numeric(as.character(power1$Sub_metering_2))
power1$Sub_metering_3 <- as.numeric(as.character(power1$Sub_metering_3))

#setting up a panel of figures
par(mfrow=c(2,2))

#Fig 1
plot(power1$timestamp,power1$Global_active_power, type="l", xlab="", ylab="Global Active Power")
#Fig 2
plot(power1$timestamp,power1$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Fig 3
plot(power1$timestamp,power1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power1$timestamp,power1$Sub_metering_2,col="red")
lines(power1$timestamp,power1$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly

#Fig 4
plot(power1$timestamp,power1$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#Saving the resulted panel
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
