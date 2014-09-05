
#Downloading and unzipping
if (!file.exists("household_power_consumption.txt")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url=fileUrl, destfile="household_power_consumption.zip")
  
  unzip("household_power_consumption.zip") 
  #Removing compressed file
  unlink("household_power_consumption.zip")  
  DateDownloaded <- date()
  print(paste("File downloaded from ", fileUrl, " on ", DateDownloaded))
  
}

#reading data
DFALL <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)

DFALL$DateTime<-paste(DFALL$Date, DFALL$Time)
#casting as date
DFALL$Date<-as.Date(DFALL$Date, format='%d/%m/%Y')
#DFALL$Time<-as.Date(DFALL$Time, format='%H:%M:%S')

#filtering data with dates 2007-02-01 and 2007-02-02
DF<-DFALL[(DFALL$Date>=as.Date("2007-02-01") & DFALL$Date<=as.Date("2007-02-02") ), ]

#discarding big dataframe
DFALL<-NA
#converting to numeric
DF$Global_active_power<-as.numeric(DF$Global_active_power)
DF$Sub_metering_1<-as.numeric(DF$Sub_metering_1)
DF$Sub_metering_2<-as.numeric(DF$Sub_metering_2)
DF$Sub_metering_3<-as.numeric(DF$Sub_metering_3)
DF$Voltage<-as.numeric(DF$Voltage)
DF$Global_reactive_power<-as.numeric(DF$Global_reactive_power)
#DF$DateTime<-paste(DF$Date, DF$Time)
DF$DateTime<-strptime(DF$DateTime, format='%d/%m/%Y %H:%M:%S')

Sys.setlocale("LC_TIME", "English")
#creating image
png("plot4.png", 480,480,"px")
#plot
par(mfrow=c(2,2))

plot(DF$DateTime,DF$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")

plot(DF$DateTime,DF$Voltage, type="l", 
     ylab="Voltage", xlab="datetime")

with(DF, 
     plot(DateTime,Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
with(DF, lines(DateTime,Sub_metering_1, type="l"))
with(DF, lines(DateTime,Sub_metering_2, type="l", col="red"))
with(DF, lines(DateTime,Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=1,col=c("black","red","blue"))

plot(DF$DateTime,DF$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")
#closing image
dev.off()