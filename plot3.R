download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="dataset.zip")
unzip("dataset.zip")

rm(list=ls())

data=read.table("./household_power_consumption.txt",header=T,sep=";")
data$Date=as.Date(data$Date,"%d/%m/%Y")

data.new=as.data.frame(sapply(subset(data,Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02")),
                              sub,pattern="\\?",replacement=NA))
#data.new$Date=as.Date(data.new$Date,"%d-%m-%Y")
data.new$datetime=strptime(paste(data.new$Date,data.new$Time),"%Y-%m-%d %H:%M:%S")

grep("Global|Sub|Voltage",names(data.new))
data.new[grep("Global|Sub|Voltage",names(data.new))]=lapply(data.new[grep("Global|Sub|Voltage",names(data.new))],
                                                            function(x){as.numeric(as.character(x))})

png(file="C:/Users/NathanielSOON/Desktop/Coursera Data science/Exploratory data analysis/Programming Assignment 1/plot3.png")
with(data.new,plot(datetime,Sub_metering_1,xlab="",ylab="Energy sub metering",type="n"))
with(data.new,lines(datetime,Sub_metering_1,col="black"))
with(data.new,lines(datetime,Sub_metering_2,col="red"))
with(data.new,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
dev.off()


