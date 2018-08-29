# Load the required libraries
library(lubridate)
library(tidyverse)

# Load the dataset, recognise NAs, transform to a tibble and format date/time into corresponding formats
temp <- unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
power_consumption <- read.table(temp, header = TRUE ,sep = ";", stringsAsFactors = FALSE,
                                na.strings = "?")
power_consumption <- as_data_frame(power_consumption)
power_consumption <- power_consumption %>% mutate(date = dmy_hms(paste(Date, Time)))

# Filter for observations from 1st and 2nd of February, 2007
power_consumption_subset <- power_consumption %>% 
        filter(date %within% interval(ymd("2007-02-01"), ymd("2007-02-03")))

# Make plot1 into a png file
png("plot1.png", width = 480, height = 480)
hist(power_consumption_subset$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()

# Make plot4 
png("plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))
        # Make plot 1/4
plot(power_consumption_subset$date, power_consumption_subset$Global_active_power, type="n", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
lines(power_consumption_subset$date, power_consumption_subset$Global_active_power, type = "l")

        # Make plot 2/4
plot(power_consumption_subset$date, power_consumption_subset$Sub_metering_1, type="l", 
     xlab = "", ylab = "Energy sub metering", col = "black")
lines(power_consumption_subset$date, power_consumption_subset$Sub_metering_2, 
      type = "l", col = "red")
lines(power_consumption_subset$date, power_consumption_subset$Sub_metering_3, 
      type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5, bty = "n")

        # Make plot 3/4
plot(power_consumption_subset$date, power_consumption_subset$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

        #Make plot 4/4
plot(power_consumption_subset$date, power_consumption_subset$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()