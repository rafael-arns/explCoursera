fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##download and read file
download.file(fileUrl,
              destfile = "C:/Users/rafael/Documents/coursera/exploratory/house.zip")
house<-read.table(unzip("C:/Users/rafael/Documents/coursera/exploratory/house.zip"),
                  sep = ";",
                  header=TRUE,na.strings = "?",
                  as.is = c(1,2))


##convert class; filter rows; adds new variable in date/time format in portuguese
house$Date<-as.Date(house$Date,format("%d/%m/%Y"))
library(dplyr)
housework<-house%>%
  tbl_df()%>%
  filter(Date=="2007/02/01"|
           Date=="2007/02/02")%>%
  mutate(timeConcat=paste0(Date," ",Time))
housework$timeConcat<-strptime(housework$timeConcat,
                               format = "%Y-%m-%d %H:%M:%S")

##plot 4 plots in two coluns and two rows
##inserts legend and save PNG file on Windows OS
png("plot4.png",type = "windows")
par(mfrow=c(2,2))

##first and second plot
with(housework,{
  plot(timeConcat,Global_active_power,type = "l",
       xlab = "",ylab = "Global Active Power")
  plot(timeConcat,Voltage,type = "l",xlab = "datetime")})

##third plot
with(housework,{
  plot(timeConcat,Sub_metering_1,type="l",col="black",xlab = "",
       ylab="Energy sub metering")
  points(timeConcat,Sub_metering_2,type = "l",col="red")
  points(timeConcat,Sub_metering_3,type = "l",col="blue")})
legend("topright",col = c("black","red","blue"),
       pch="-",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##fourth plot
plot(housework$timeConcat,housework$Global_reactive_power,type = "l",
     ylab = "Global_reactive_power",xlab = "datetime")
