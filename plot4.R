library(dplyr)
library(ggplot2)
require(gridExtra)

energy_data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
energy_data <- tbl_df(energy_data)

subset_energy_data <- filter(energy_data, Date=="1/2/2007" | Date=="2/2/2007")

subset_energy_data <- mutate(subset_energy_data, DateTime=paste(Date, Time, sep=" "))
subset_energy_data$DateTime <- strptime(subset_energy_data$DateTime, "%d/%m/%Y %H:%M:%S")

#Create Plot 4
png("plot4.png")
plot_NW <- ggplot(subset_energy_data, aes(DateTime, Global_active_power)) + 
    geom_line() + scale_x_datetime(date_labels = "%a", date_breaks = "1 day") +xlab("") + ylab("Global Active Power (kilowatts)")

plot_NE <- ggplot(subset_energy_data, aes(DateTime, Voltage)) + 
    geom_line() + scale_x_datetime(date_labels = "%a", date_breaks = "1 day") +xlab("datetime") + ylab("Global Active Power (kilowatts)")

plot_SW <- ggplot(subset_energy_data, aes(DateTime)) + 
    geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1"), show.legend = TRUE) + 
    geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2"), show.legend = TRUE) + 
    geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3"), show.legend = TRUE) + 
    scale_x_datetime(date_labels = "%a", date_breaks = "1 day") +xlab("") + ylab("Energy sub metering") +
    theme(legend.justification = c(1, 1), legend.position = c(1, 1))

plot_SE <- ggplot(subset_energy_data, aes(DateTime, Global_reactive_power)) + 
    geom_line() + scale_x_datetime(date_labels = "%a", date_breaks = "1 day") +xlab("datetime")


grid.arrange(plot_NW, plot_NE, plot_SW, plot_SE)
dev.off()