library(dplyr)
library(ggplot2)
require(gridExtra)

energy_data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
energy_data <- tbl_df(energy_data)

subset_energy_data <- filter(energy_data, Date=="1/2/2007" | Date=="2/2/2007")

subset_energy_data <- mutate(subset_energy_data, DateTime=paste(Date, Time, sep=" "))
subset_energy_data$DateTime <- strptime(subset_energy_data$DateTime, "%d/%m/%Y %H:%M:%S")

#Create Plot 1
png("plot1.png")
hist(subset_energy_data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()