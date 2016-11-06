fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##download and read file
download.file(fileUrl,
              destfile = "C:/Users/rafael/Documents/coursera/exploratory/house.zip")
house<-read.table(unzip("C:/Users/rafael/Documents/coursera/exploratory/house.zip"),
                  sep = ";",
                  header=TRUE,na.strings = "?",
                  as.is = c(1,2))

##convert class and filter rows
house$Date<-as.Date(house$Date,format("%d/%m/%Y"))
library(dplyr)
housework<-house%>%
  tbl_df()%>%
  filter(Date=="2007/02/01"|
           Date=="2007/02/02")

##plot and save PNG file on Windows OS
png("plot1.png",type = "windows")
hist(housework$Global_active_power,
     freq = 200,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main="Global Active Power (kilowatts)")