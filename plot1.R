setwd(".")

if (!file.exists("./household_power_consumption.txt")) {
  download.file(url="http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="household_power_consumption.zip")
  unzip(zipfile="household_power_consumption.zip")
}

#Load data with header and separator ;
DT<-read.table("./household_power_consumption.txt",header= TRUE,sep=";",stringsAsFactors=FALSE)

#Convert date to date format
DT$Date1 <- as.Date(DT$Date, "%d/%m/%Y")

#Select 2 day period of data
sel2days <- function(x,y){DT[DT$Date1 == x | DT$Date1 ==y, ]}
FebPower <- sel2days(as.Date("2007-02-01"), as.Date("2007-02-02"))

# Cast variables from character to numeric 
FebPower$gap <- as.numeric(FebPower$Global_active_power)
#FebPower$grp <- as.numeric(FebPower$Global_reactive_power)
#FebPower$vol <- as.numeric(FebPower$Voltage)

#Plot1
par(mfrow=c(1,1))
hist(FebPower$gap,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")

dev.copy(png, file="plot1.png")  ##Copy plot to a PNG file
dev.off()  ## Close the PNG device


