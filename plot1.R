
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

#casting as date
DFALL$Date<-as.Date(DFALL$Date, format='%d/%m/%Y')

#filtering data with dates 2007-02-01 and 2007-02-02
DF<-DFALL[(DFALL$Date>=as.Date("2007-02-01") & DFALL$Date<=as.Date("2007-02-02") ), ]
#discarding big dataframe
DFALL<-NA
#converting to numeric
DF$Global_active_power<-as.numeric(DF$Global_active_power)
#creating image
png("plot1.png", 480,480,"px")
#histogram
hist(DF$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
#closing image
dev.off()

