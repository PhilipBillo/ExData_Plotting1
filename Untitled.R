library(lubridate)
library(tidyverse)

temp <- unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
power_consumption <- read.table(temp, header = TRUE ,sep = ";", stringsAsFactors = FALSE,
                                na.strings = "?")
power_consumption <- as_data_frame(power_consumption)
power_consumption <- power_consumption %>% mutate(Date = dmy(Date), Time = hms(Time))

sapply(power_consumption, function(x) sum(is.na(x)))

