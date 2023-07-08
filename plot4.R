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


# plot 4
png(file='plot4.png', width = 480, height = 480, units = "px")
xticks = c("2007-02-01", "2007-02-02", "2007-02-03")
lab = c('Thu', 'Fri', 'Sat')
par(mfcol=c(2,2), oma=c(0,0,1,0)) # oma: outer margins - start bottom, then clockwise (left, top, right)
with(df, {
  # fig 1
  plot(Global_active_power~datetime, data=df, type='l', xaxt='n', xlab='', ylab='Global Active Power')
  axis.POSIXct(1, datetime, at=xticks, labels=lab)
  # fig 2  
  plot(Sub_metering_1~datetime, type='l', col='black', xaxt='n', xlab='', ylab='Energy sub metering') 
  lines(Sub_metering_2~datetime, type='l', col='red')
  lines(Sub_metering_3~datetime, type='l', col='blue')
  axis.POSIXct(1, datetime, at=xticks, labels=lab)
  legend('topright',lwd=2, col=c('black', 'blue', 'red'), bty = "n", legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
  # fig 3
  plot(Voltage~datetime, type='l', col='black', xaxt='n')
  axis.POSIXct(1, datetime, at=xticks, labels=lab)
  # fig 4
  plot(Global_reactive_power~datetime, type='l', col='black', xaxt='n')
  axis.POSIXct(1, datetime, at=xticks, labels=lab)
})
dev.off()