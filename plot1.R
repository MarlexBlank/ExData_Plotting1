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
yourSetting <- par(bg = "transparent")
hist(as.numeric(subData$Global_active_power), col = 'red', main = "Global Active Power" , xlab = "Global Active Power (killowatts)")

# Saving PNG file
dev.copy(png , file = "plot1.png")
dev.off()
par(bg = yourSetting[["bg"]])