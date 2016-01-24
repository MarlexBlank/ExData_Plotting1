# This is the code to generate Plot 4
# ===============================================================================

# reading raw data
zipFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localFile <- tempfile()
download.file(zipFileURL,localFile)
allData <- read.table(unz(localFile,"household_power_consumption.txt"),sep = ";",header = TRUE,na.strings="?")

# subsetting data ( from 2007/02/01 to 2007/02/02 )
dates <- as.Date(allData$Date,format = "%d/%m/%Y")

startDate <- as.Date(strftime("2007/02/01",format = "%Y/%m/%d"))
endDate <-as.Date(strftime("2007/02/02",format = "%Y/%m/%d"))
subDataIndex <- which(dates >= startDate & dates <= endDate , arr.ind = TRUE)

subData <- allData[subDataIndex,]
subData[1:length(subData)] <- lapply(subData[1:length(subData)],as.character)


# Plotting
yourSetting <- par( bg = "transparent" , cex=1 , mfrow = c(2,2))
with(
  subData,
  {
    # top-left graph
    plot(strptime(paste(subData$Date,subData$Time,sep = " "),format = "%d/%m/%Y %H:%M:%S"),as.numeric(subData$Global_active_power),type = 'l',xlab = "" , ylab = "Global Active Power (killowatts)")
    # top-right graph
    plot(strptime(paste(subData$Date,subData$Time,sep = " "),format = "%d/%m/%Y %H:%M:%S"),as.numeric(subData$Voltage),type = 'l',xlab = "" , ylab = "Voltage")
    # bottom-left graph
    plot(strptime(paste(Date,Time,sep = " "),format = "%d/%m/%Y %H:%M:%S"),as.numeric(Sub_metering_1),type = "l",xlab = "",ylab = "Energy sub metering")
    lines(strptime(paste(Date,Time,sep = " "),format = "%d/%m/%Y %H:%M:%S"),as.numeric(Sub_metering_2),type = "l",col = "red")
    lines(strptime(paste(Date,Time,sep = " "),format = "%d/%m/%Y %H:%M:%S"),as.numeric(Sub_metering_3),type = "l",col = "blue")
    legend("topright" , col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1),text.width = 90000)
    # bottom-right graph
    plot(strptime(paste(Date,Time,sep = " "),format = "%d/%m/%Y %H:%M:%S"),as.numeric(Global_reactive_power),type = "l",xlab = "",ylab = "Global Reactive Power")
  }
)
# Saving PNG file
dev.copy(png , file = "plot4.png")
dev.off()
par(bg = yourSetting[["bg"]] , cex = yourSetting[["cex"]] , mfrow = yourSetting[["mfrow"]])