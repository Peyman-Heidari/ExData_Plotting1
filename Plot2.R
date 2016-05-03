#Reading the data
householdpower <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
householdpower$Date <- as.Date(householdpower$Date, format="%d/%m/%Y")
#Subsetting the desred days
power1 <- householdpower[(householdpower$Date=="2007-02-01") | (householdpower$Date=="2007-02-02"),]
power1$Global_active_power <- as.numeric(as.character(power1$Global_active_power))
power1$Global_reactive_power <- as.numeric(as.character(power1$Global_reactive_power))
power1$Voltage <- as.numeric(as.character(power1$Voltage))
power1 <- transform(power1, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
power1$Sub_metering_1 <- as.numeric(as.character(power1$Sub_metering_1))
power1$Sub_metering_2 <- as.numeric(as.character(power1$Sub_metering_2))
power1$Sub_metering_3 <- as.numeric(as.character(power1$Sub_metering_3))

#Plotting the required information
plot(power1$timestamp,power1$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()