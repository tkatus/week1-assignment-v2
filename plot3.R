df = read.delim('./Data/household_power_consumption.txt', sep = ";", dec = ".")

df$Date <- as.Date(df$Date, format='%d/%m/%Y')
df  <-  subset(df, Date >= '2007-02-01' & Date <= '2007-02-02')

# convert to numeric, if not Date or Time
for (x in names(df)) {
  if (!(x %in% c('Date', 'Time'))) {
    df[[x]] <- as.numeric(df[[x]])
  }
}

df$datetime <- as.POSIXct(paste(df$Date, df$Time))

# plot 3
png(file='plot3.png', width = 480, height = 480, units = "px")
xticks = c("2007-02-01", "2007-02-02", "2007-02-03")
with(df, {
  plot(Sub_metering_1~datetime, type='l', col='black', xaxt='n', xlab='', ylab='Energy sub metering') # note: no separator (, or alike) 
  lines(Sub_metering_2~datetime, type='l', col='red')
  lines(Sub_metering_3~datetime, type='l', col='blue')
  axis.POSIXct(1, df$datetime, at=xticks, labels=c('Thu', 'Fri', 'Sat'))
  legend('topright',lwd=2, col=c('black', 'blue', 'red'), legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
})
dev.off()