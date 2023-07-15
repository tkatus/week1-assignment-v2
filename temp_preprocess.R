df = read.delim('./Data/household_power_consumption.txt', sep = ";", dec = ".")
cat('DataFrame size:', dim(df))

# convert dates and time to reasonable format
df$Date <- as.Date(df$Date, format='%d/%m/%Y')
#df$Time <- strptime(x = df$Time, format = "%H:%M:%S")

# use subset 2007-02-01 and 2007-02-02
df  <-  subset(df, Date >= '2007-02-01' & Date <= '2007-02-02')
# simple slice notation works too, but less intuitive - do not forget to include the ,: 
# df <- df[df$Date >= '2007-02-01' & df$Date <= '2007-02-02', ]
cat('Subset of dataFrame size:', dim(df))


for (x in names(df)) {
  cat(sum(df$x == '?'), 'missing values in column', x, '\n')
}

# convert to numeric, if not Date or Time
for (x in names(df)) {
  if (!(x %in% c('Date', 'Time'))) {
    df[[x]] <- as.numeric(df[[x]])
  }
}


# plot 1
png(file='plot1.png', width = 480, height = 480, units = "px")
hist(df$Global_active_power, main='Global Active Power', xlab='Global Active Power (kilowatts)', col='red')
dev.off()



# PLOT 2: combining date and time into single object
df$datetime <- as.POSIXct(paste(df$Date, df$Time))

#xticks = c("2007-02-01 00:00:00 GMT", "2007-02-02 00:00:00 GMT", "2007-02-03 00:00:00 GMT")
png(file='plot2.png', width = 480, height = 480, units = "px")
xticks = c("2007-02-01", "2007-02-02", "2007-02-03")
plot(Global_active_power~datetime, data=df, type='l', xaxt='n', xlab='', ylab='Global Active Power (kilowatts)')
axis.POSIXct(1, df$datetime, at=xticks, labels=c('Thu', 'Fri', 'Sat'))
dev.off()


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





