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

# Make plot2 
png("plot2.png", width = 480, height = 480)
plot(power_consumption_subset$date, power_consumption_subset$Global_active_power, type="l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
