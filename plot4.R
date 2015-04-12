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
FebPower$grp <- as.numeric(FebPower$Global_reactive_power)
FebPower$vol <- as.numeric(FebPower$Voltage)

#Plot4
par(mfrow=c(2,2))
FebPower$dtime <- as.POSIXct(paste(FebPower$Date1, FebPower$Time), format="%Y-%m-%d %H:%M:%S")
pp <- function(a,b,c) {    #function for 1st, 2nd and 4th plot
  plot(FebPower$dtime, a, type="l",main="",xlab=b, ylab=c)
}

p3 <- function() {  #function for 3rd plot
  with(FebPower, {
    plot(dtime, Sub_metering_1, type="l",main="",xlab="",ylab="Energy sub metering")
    lines(dtime,Sub_metering_2,col="red")
    lines(dtime,Sub_metering_3,col="blue")
    legend("topright",pch="_____",col=c("black","red","blue"), bty="n",xjust = 1, yjust = 1,legend=c("Sub_metering_1","Sun_metering_2","Sub_metering_3"))
  })
}

with(FebPower, {
  pp(gap,"","Global Active Power")
  pp(vol,"datetime","Voltage")
  p3()
  pp(grp,"datetime","Global_reactive_power")
})

dev.copy(png, file="plot4.png")  ##Copy plot to a PNG file
dev.off()  ## Close the PNG device

