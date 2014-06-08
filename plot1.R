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
#Opens a screen graphic device, makes an histogram with the data, copy the histogram on a png file and close the graphic devices
quartz()
par(bg="white")
hist(data$Global_active_power, main ="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frecuency",col="Red")
dev.copy(png,filename="plot1.png",width=480,height=480)
dev.off()
dev.off()

