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

png(file="C:/Users/NathanielSOON/Desktop/Coursera Data science/Exploratory data analysis/Programming Assignment 1/plot1.png")
with(data.new,hist(Global_active_power,freq=T,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()
