df = read.delim('./Data/household_power_consumption.txt', sep = ";", dec = ".")

df$Date <- as.Date(df$Date, format='%d/%m/%Y')
df  <-  subset(df, Date >= '2007-02-01' & Date <= '2007-02-02')

# convert to numeric, if not Date or Time
for (x in names(df)) {
  if (!(x %in% c('Date', 'Time'))) {
    df[[x]] <- as.numeric(df[[x]])
  }
}

# PLOT 2: combining date and time into single object
df$datetime <- as.POSIXct(paste(df$Date, df$Time))

#xticks = c("2007-02-01 00:00:00 GMT", "2007-02-02 00:00:00 GMT", "2007-02-03 00:00:00 GMT")
png(file='plot2.png', width = 480, height = 480, units = "px")
xticks = c("2007-02-01", "2007-02-02", "2007-02-03")
plot(Global_active_power~datetime, data=df, type='l', xaxt='n', xlab='', ylab='Global Active Power (kilowatts)')
axis.POSIXct(1, df$datetime, at=xticks, labels=c('Thu', 'Fri', 'Sat'))
dev.off()
