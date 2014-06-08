#Checks if the package "sqldf" is installed in the user RStudio
#If not, download the package and loads it, if yes only loads it
if(length(find.package("sqldf",quiet=TRUE))==0){
  install.packages("sqldf")
  library(sqldf)
}
if(length(find.package("sqldf",quiet=TRUE))==1){
  library(sqldf)
}
#Checks if the file "household_power_consumption.txt" exists, if not it downloads the file and unzip it in the working directory
if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="electricdata",method="curl")
  unzip("electricdata")
}
#Read data from "household_power_consumption.txt" selecting just rows from date 1/2/2007 and 2/2/2007
data<-read.csv2.sql("household_power_consumption.txt",sql="SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007' ", eol="\n")
#Converts the named Date variable to a Date class variable
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
#Pastes the Date and Time variable in a new variable named newDate, and converts that new variable
#in a Date class variable
data$newDate<-paste(data$Date,data$Time)
data$newDate<-strptime(data$newDate,format="%Y-%m-%d %H:%M:%S")
#Opens a screen graphic device, makes an histogram with the data, copy the histogram on a png file and close the graphic devices
quartz()
with(data,{
      plot(data$newDate,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="",main="")
      #Add the two aditional lines to the plot in their respective colors
     lines(data$newDate,data$Sub_metering_2,type="l",col="Red")
     lines(data$newDate,data$Sub_metering_3,type="l",col="Blue")
     legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
            col=c("black","red","blue"),lty=c(1,1,1))
     }
    )
dev.copy(png,filename="plot3.png",width=480,height=480)
dev.off()
dev.off()
