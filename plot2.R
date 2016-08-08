library(dplyr)
library(ggplot2)
require(gridExtra)

energy_data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
energy_data <- tbl_df(energy_data)

subset_energy_data <- filter(energy_data, Date=="1/2/2007" | Date=="2/2/2007")

subset_energy_data <- mutate(subset_energy_data, DateTime=paste(Date, Time, sep=" "))
subset_energy_data$DateTime <- strptime(subset_energy_data$DateTime, "%d/%m/%Y %H:%M:%S")

#Create Plot 2
png("plot2.png")
ggplot(subset_energy_data, aes(DateTime, Global_active_power)) + 
    geom_line() + scale_x_datetime(date_labels = "%a", date_breaks = "1 day") +xlab("") + ylab("Global Active Power (kilowatts)")
dev.off()