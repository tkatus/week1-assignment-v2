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
