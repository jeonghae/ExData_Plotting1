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

#Plot2
par(mfrow=c(1,1))
FebPower$dtime <- as.POSIXct(paste(FebPower$Date1, FebPower$Time), format="%Y-%m-%d %H:%M:%S")
p2<-function(){
  plot(gap ~ dtime, data=FebPower, type="l",xlab="",ylab="Global Active Power (kilowatts)")
}
p2()
dev.copy(png, file="plot2.png")  ##Copy plot to a PNG file
dev.off()  ## Close the PNG device

