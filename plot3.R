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

##plot three different variable on y axis
##inserts legend and save PNG file on Windows OS
png("plot3.png",type = "windows")
with(housework,{
  plot(timeConcat,Sub_metering_1,type="l",col="black",xlab = "",
       ylab="Energy sub metering")
  points(timeConcat,Sub_metering_2,type = "l",col="red")
  points(timeConcat,Sub_metering_3,type = "l",col="blue")})
  legend("topright",col = c("black","red","blue"),
         pch="-",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))